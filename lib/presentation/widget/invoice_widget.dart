import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_app_bar.dart';
import '../../domain/entities/invoice_model.dart';

class InvoiceWidget extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(),
          30.vs(),
          // Header
          Text(
            'INVOICE',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text('Booked On: ${invoice.bookedOn}'),
          Text('Date: ${invoice.treatmentDate}'),
          Text('Time: ${invoice.treatmentTime}'),

          const SizedBox(height: 16),
          Divider(),

          // Patient Details
          Text(
            'Patient Details',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Name: ${invoice.name}'),
          Text('Address: ${invoice.address}'),
          Text('WhatsApp: ${invoice.whatsappNumber}'),

          const SizedBox(height: 16),
          Divider(),

          // Treatments
          Text(
            'Treatments',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: invoice.treatments.map((t) {
              final total = t.price * (t.male + t.female);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 3, child: Text(t.package)),
                    Expanded(flex: 2, child: Text('₹${t.price}')),
                    Expanded(flex: 1, child: Text('M:${t.male}')),
                    Expanded(flex: 1, child: Text('F:${t.female}')),
                    Expanded(flex: 2, child: Text('₹$total')),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          Divider(),

          // Summary
          _buildSummaryRow('Total Amount', '₹${invoice.totalAmount.toInt()}'),
          _buildSummaryRow('Discount', '₹${invoice.discountAmount.toInt()}'),
          _buildSummaryRow('Advance', '₹${invoice.advanceAmount.toInt()}'),
          const Divider(),
          _buildSummaryRow(
            'Balance',
            '₹${invoice.balanceAmount.toInt()}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
