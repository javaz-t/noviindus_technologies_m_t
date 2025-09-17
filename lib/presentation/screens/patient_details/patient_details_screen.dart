/*
import 'package:flutter/material.dart';

import '../../../data/model/patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Patient Info"),
            _buildInfoRow("ID", patient.id.toString()),
            _buildInfoRow("Name", patient.name),
            _buildInfoRow("Phone", patient.phone),
            _buildInfoRow("Address", patient.address),
            _buildInfoRow("Payment", patient.payment ?? "N/A"),
            _buildInfoRow(
              "Total Amount",
              patient.totalAmount?.toString() ?? "N/A",
            ),
            _buildInfoRow(
              "Discount",
              patient.discountAmount?.toString() ?? "N/A",
            ),
            _buildInfoRow(
              "Advance",
              patient.advanceAmount?.toString() ?? "N/A",
            ),
            _buildInfoRow(
              "Balance",
              patient.balanceAmount?.toString() ?? "N/A",
            ),
            _buildInfoRow("Date", patient.dateTime?.toString() ?? "N/A"),

            const SizedBox(height: 20),
            _buildSectionTitle("Branch Info"),
            if (patient.branch != null) ...[
              _buildInfoRow("Branch ID", patient.branch!.id.toString()),
              _buildInfoRow("Name", patient.branch!.name),
              _buildInfoRow("Location", patient.branch!.location),
              _buildInfoRow("Phone", patient.branch!.phone),
              _buildInfoRow("Mail", patient.branch!.mail),
              _buildInfoRow("Address", patient.branch!.address),
              _buildInfoRow(
                "Patients Count",
                patient.branch!.patientsCount.toString(),
              ),
              _buildInfoRow("GST", patient.branch!.gst),
              _buildInfoRow("Active", patient.branch!.isActive ? "Yes" : "No"),
            ] else
              const Text("No branch info available"),

            const SizedBox(height: 20),
            _buildSectionTitle("Patient Details Set"),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text("Detail ID: ${patient.id}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Male: ${patient.patientDetails!.male}"),
                    Text("Female: ${patient.patientDetails!.female}"),
                    Text(
                      "Treatment: ${patient.patientDetails!.treatment ?? "N/A"}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
*/
