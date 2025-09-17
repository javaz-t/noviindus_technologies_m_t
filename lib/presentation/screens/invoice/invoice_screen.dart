import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../domain/entities/invoice_model.dart';
import '../../widget/invoice_widget.dart';

class InvoiceScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      print(e);
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
    final String svgString = await rootBundle.loadString(
      'assets/svgs/logo.svg',
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          pw.Positioned.fill(
            child: pw.Opacity(
              opacity: .5,
              child: pw.Center(
                child: pw.SvgImage(svg: svgString, width: 300, height: 300),
              ),
            ),
          );
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SvgImage(svg: svgString, width: 80, height: 80),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text("KUMARAKOM"),
                        pw.Text(
                          "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563",
                          style: pw.TextStyle(color: PdfColors.grey600),
                        ),
                        pw.Text(
                          "e-mail: unknown@gmail.com",
                          style: pw.TextStyle(color: PdfColors.grey600),
                        ),
                        pw.Text(
                          "Mob: +91 9876543210 | +91 9786543210",
                          style: pw.TextStyle(color: PdfColors.grey600),
                        ),
                        pw.Text("GST No: 32AABCU9603R1ZW"),
                        pw.Divider(color: PdfColors.grey600),
                      ],
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              // Patient Details
              pw.Container(
                padding: const pw.EdgeInsets.all(16),

                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Patient Details ',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.teal700,
                      ),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Name: ${invoice.name}'),
                                  pw.SizedBox(height: 4),
                                  pw.Text('Address: ${invoice.address}'),
                                  pw.SizedBox(height: 4),
                                  pw.Text(
                                    'WhatsApp: ${invoice.whatsappNumber}',
                                  ),
                                ],
                              ),
                              pw.Column(
                                children: [
                                  pw.Text('Booked On: ${invoice.bookedOn}'),
                                  pw.SizedBox(height: 4),

                                  pw.Text(
                                    'Treatment Date: ${invoice.treatmentDate}',
                                  ),
                                  pw.SizedBox(height: 4),
                                  pw.Text(
                                    'Treatment Time: ${invoice.treatmentTime}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              // Treatments Table
              pw.Text(
                'Treatments',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.teal700,
                ),
              ),
              pw.SizedBox(height: 12),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  // Header
                  pw.TableRow(
                     children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Treatment',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Price',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Male',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Female',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Treatments
                  ...invoice.treatments.map(
                    (treatment) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(treatment.package),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('₹${treatment.price}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('${treatment.male}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('${treatment.female}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${(treatment.price * (treatment.male + treatment.female))}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 24),

              // Summary
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total Amount'),
                        pw.Text('₹${invoice.totalAmount.toInt()}'),
                      ],
                    ),
                    pw.SizedBox(height: 8),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Discount'),
                        pw.Text('₹${invoice.discountAmount.toInt()}'),
                      ],
                    ),
                    pw.SizedBox(height: 8),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Advance'),
                        pw.Text('₹${invoice.advanceAmount.toInt()}'),
                      ],
                    ),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Balance',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        pw.Text(
                          '₹${invoice.balanceAmount.toInt()}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                            color: PdfColors.teal700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
