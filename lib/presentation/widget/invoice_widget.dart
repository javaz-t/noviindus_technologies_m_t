import 'package:flutter/material.dart';

import '../../domain/entities/invoice_model.dart';

class InvoiceWidget extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'INVOICE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Booked On ${invoice.bookedOn}'),
                      Text('${invoice.treatmentDate} | ${invoice.treatmentTime}'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Patient Details Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Name', invoice.name),
                            _buildDetailRow('Address', invoice.address),
                            _buildDetailRow('WhatsApp Number', invoice.whatsappNumber),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Treatment Date', invoice.treatmentDate),
                            _buildDetailRow('Treatment Time', invoice.treatmentTime),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Treatments Table
            Text(
              'Treatments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text('Treatment', style: _headerStyle())),
                        Expanded(flex: 2, child: Text('Price', style: _headerStyle())),
                        Expanded(flex: 1, child: Text('Male', style: _headerStyle())),
                        Expanded(flex: 1, child: Text('Female', style: _headerStyle())),
                        Expanded(flex: 2, child: Text('Total', style: _headerStyle())),
                      ],
                    ),
                  ),
                  // Table Rows
                  ...invoice.treatments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final treatment = entry.value;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : Colors.grey.shade50,
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text(treatment.package)),
                          Expanded(flex: 2, child: Text('₹${treatment.price}')),
                          Expanded(flex: 1, child: Text('${treatment.male}')),
                          Expanded(flex: 1, child: Text('${treatment.female}')),
                          Expanded(flex: 2, child: Text('₹${(treatment.price*(treatment.male+ treatment.female) )}')),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Total Amount', '₹${invoice.totalAmount.toInt()}'),
                  _buildSummaryRow('Discount', '₹${invoice.discountAmount.toInt()}'),
                  _buildSummaryRow('Advance', '₹${invoice.advanceAmount.toInt()}'),
                  const Divider(thickness: 2),
                  _buildSummaryRow(
                    'Balance',
                    '₹${invoice.balanceAmount.toInt()}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  TextStyle _headerStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black87,
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? Colors.teal.shade700 : null,
            ),
          ),
        ],
      ),
    );
  }
}
