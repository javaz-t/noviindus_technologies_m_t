import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';

Future<Map<String, dynamic>?> showAddPatientDialog(BuildContext context) async {
  int maleCount = 0;
  int femaleCount = 0;
  String? selectedTreatment;

  return await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    "Choose Treatment",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedTreatment,
                    hint: const Text("Choose preferred treatment"),
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                    items: ["Treatment A", "Treatment B", "Treatment C"]
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedTreatment = val);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.borderColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                   const Text(
                    "Add Patients",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                   Row(
                    children: [
                      const Expanded(child: Text("Male")),
                      IconButton(
                        onPressed: () {
                          if (maleCount > 0) {
                            setState(() => maleCount--);
                          }
                        },
                        icon: const Icon(Icons.remove_circle),
                        color: Colors.green,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedTreatment == null
                                ? Colors.grey
                                : AppColors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(maleCount.toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => maleCount++);
                        },
                        icon: const Icon(Icons.add_circle),
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                   Row(
                    children: [
                      const Expanded(child: Text("Female")),
                      IconButton(
                        onPressed: () {
                          if (femaleCount > 0) {
                            setState(() => femaleCount--);
                          }
                        },
                        icon: const Icon(Icons.remove_circle),
                        color: Colors.green,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(femaleCount.toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => femaleCount++);
                        },
                        icon: const Icon(Icons.add_circle),
                        color: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                   SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (selectedTreatment == null) {
                          return;
                        }
                        Navigator.pop(context, {
                          "treatment": selectedTreatment,
                          "male": maleCount,
                          "female": femaleCount,
                        });
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
