import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noviindus_technologies_m_t/domain/entities/invoice_model.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/invoice_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class InvoiceScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: InvoiceWidget(invoice: invoice),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _downloadPDF(context),
                icon: const Icon(Icons.download),
                label: const Text('Download PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPDF(BuildContext context) async {
    try {
      final pdf = await _generatePDF();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      // Also save to device storage
      final output = await getApplicationDocumentsDirectory();
      final file = File(
        "${output.path}/invoice_${invoice.name.replaceAll(' ', '_')}.pdf",
      );
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice saved to ${file.path}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<pw.Document> _generatePDF() async {
    final pdf = pw.Document();

    // Load SVG assets
    final String logoSvg = await rootBundle.loadString('assets/svgs/logo.svg');
    final String signSvg = await rootBundle.loadString('assets/svgs/sign.svg');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Background faint logo
              pw.Positioned.fill(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(40),
                  child: pw.Opacity(
                    opacity: 0.1,
                    child: pw.Center(
                      child: pw.SvgImage(svg: logoSvg, width: 300, height: 300),
                    ),
                  ),
                ),
              ),

              // Content
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header with logo and company details
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SvgImage(svg: logoSvg, width: 60, height: 60),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              "KUMARAKOM",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "Cheepunkal P.O. Kumarakom, Kottayam, Kerala - 686563",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey600,
                              ),
                            ),
                            pw.Text(
                              "e-mail: unknown@gmail.com",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey600,
                              ),
                            ),
                            pw.Text(
                              "Mob: +91 9876543210 | +91 9786543210",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey600,
                              ),
                            ),
                            pw.Text(
                              "GST No: 32AABCU9603R1ZW",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 16),
                  pw.Divider(color: PdfColors.grey400),

                  // Patient details and booking info
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Patient Details",
                              style: pw.TextStyle(
                                color: PdfColors.green,
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 8),
                            _buildPdfDetailRow("Name", invoice.name),
                            _buildPdfDetailRow("Address", invoice.address),
                            _buildPdfDetailRow(
                              "WhatsApp",
                              invoice.whatsappNumber,
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.SizedBox(height: 20),
                            _buildPdfDetailRow(
                              "Booked On",
                              invoice.bookedOn,
                              isAlignEnd: true,
                            ),
                            _buildPdfDetailRow(
                              "Treatment Date",
                              invoice.treatmentDate,
                              isAlignEnd: true,
                            ),
                            _buildPdfDetailRow(
                              "Treatment Time",
                              invoice.treatmentTime,
                              isAlignEnd: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 16),
                  pw.Divider(color: PdfColors.grey400),

                  // Treatments header
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          "Treatment",
                          style: pw.TextStyle(
                            color: PdfColors.green,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Price",
                          style: pw.TextStyle(
                            color: PdfColors.green,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          "Male",
                          style: pw.TextStyle(
                            color: PdfColors.green,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          "Female",
                          style: pw.TextStyle(
                            color: PdfColors.green,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            color: PdfColors.green,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),

                  // Treatment rows
                  pw.Column(
                    children: invoice.treatments.map((treatment) {
                      final total =
                          treatment.price * (treatment.male + treatment.female);
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 2),
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.Text(
                                treatment.package,
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                "₹${treatment.price}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Text(
                                "${treatment.male}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Text(
                                "${treatment.female}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                "₹$total",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  pw.SizedBox(height: 16),
                  pw.Divider(color: PdfColors.grey400),

                  // Summary section
                  _buildPdfSummaryRow(
                    "Total Amount",
                    "₹${invoice.totalAmount.toInt()}",
                    isBold: true,
                  ),
                  _buildPdfSummaryRow(
                    "Discount",
                    "₹${invoice.discountAmount.toInt()}",
                  ),
                  _buildPdfSummaryRow(
                    "Advance",
                    "₹${invoice.advanceAmount.toInt()}",
                  ),
                  pw.Divider(color: PdfColors.grey400),
                  _buildPdfSummaryRow(
                    "Balance",
                    "₹${invoice.balanceAmount.toInt()}",
                    isBold: true,
                  ),

                  pw.SizedBox(height: 16),

                  // Thank you section
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(width: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "Thank you for choosing us",
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Container(
                            width: 300,
                            child: pw.Text(
                              "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey600,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 16),
                          pw.SvgImage(svg: signSvg, width: 80, height: 40),
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfDetailRow(
    String label,
    String value, {
    bool isAlignEnd = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: isAlignEnd
            ? pw.CrossAxisAlignment.end
            : pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "$label: ",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              textAlign: isAlignEnd ? pw.TextAlign.right : null,
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSummaryRow(
    String label,
    String value, {
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.SizedBox(width: 50),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
