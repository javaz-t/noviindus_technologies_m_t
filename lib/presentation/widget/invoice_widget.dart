import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import '../../domain/entities/invoice_model.dart';

class InvoiceWidget extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.white,
        child: Stack(
          children: [
            // Background faint logo
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Opacity(
                  opacity: 0.1,
                  child: SvgPicture.asset(
                    "assets/svgs/logo.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/logo.svg",
                      height: 30,
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "KUMARAKOM",
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Cheepunkal P.O. Kumarakom, Kottayam, Kerala - 686563",
                            style: TextStyle(fontSize: 7, color: Colors.grey),
                          ),
                          Text(
                            "e-mail: unknown@gmail.com",
                            style: TextStyle(fontSize: 7, color: Colors.grey),
                          ),
                          Text(
                            "Mob: +91 9876543210 | +91 9786543210",
                            style: TextStyle(fontSize: 7, color: Colors.grey),
                          ),
                          Text(
                            "GST No: 32AABCU9603R1ZW",
                            style: TextStyle(fontSize: 7),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Divider(),

                // Patient details and booking info
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient Details",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          _buildPatientDetailRow("Name", invoice.name),
                          _buildPatientDetailRow("Address", invoice.address),
                          _buildPatientDetailRow(
                            "WhatsApp",
                            invoice.whatsappNumber,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                       children: [

                         10.vs(),
                         _buildPatientDetailRow(
                           "Booked On",
                           invoice.bookedOn,
                           true,
                         ),
                         _buildPatientDetailRow(
                           "Treatment Date",
                           invoice.treatmentDate,
                           true,
                         ),
                         _buildPatientDetailRow(
                           "Treatment Time",
                           invoice.treatmentTime,
                           true,
                         ),
                       ],
                                              ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Divider(),

                // Treatments header row
                Row(
                  children: const [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Treatment",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Price",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Male",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Female",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Treatment rows
                Column(
                  children: invoice.treatments.map((t) {
                    final total = t.price * (t.male + t.female);
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(t.package, style: TextStyle(fontSize: 7)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "₹${t.price}",
                            style: TextStyle(fontSize: 7),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${t.male}",
                            style: TextStyle(fontSize: 7),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${t.female}",
                            style: TextStyle(fontSize: 7),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("₹$total", style: TextStyle(fontSize: 7)),
                        ),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 8),
                Divider(),

                // Summary
                _buildSummaryRow(
                  "Total Amount",
                  "₹${invoice.totalAmount.toInt()}",
                  isBold: true,
                ),
                _buildSummaryRow(
                  "Discount",
                  "₹${invoice.discountAmount.toInt()}",
                ),
                _buildSummaryRow(
                  "Advance",
                  "₹${invoice.advanceAmount.toInt()}",
                ),
                Divider(),
                _buildSummaryRow(
                  "Balance",
                  "₹${invoice.balanceAmount.toInt()}",
                  isBold: true,
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Thank you for choosing us",
                          style: TextStyle(
                            fontSize: 7,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.vs(),
                        SizedBox(
                          width: 200,
                          child: Text(
                            textAlign: TextAlign.end,
                            "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                            style: TextStyle(fontSize: 7, color: Colors.grey),
                          ),
                        ),

                        8.vs(),
                        SvgPicture.asset('assets/svgs/sign.svg', height: 30),
                        50.vs(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 7,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        25.hs(),
        Text(
          value,
          style: TextStyle(
            fontSize: 7,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

Widget _buildPatientDetailRow(
  String label,
  String value, [
  bool isAlignEnd = false,
]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: isAlignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            textAlign: isAlignEnd?TextAlign.end:null,
            value,
            style: TextStyle(fontSize: 7, color: Colors.grey.shade700),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
