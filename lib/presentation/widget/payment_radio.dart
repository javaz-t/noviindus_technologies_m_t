 import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

class PaymentRadioGroup extends StatefulWidget {
  final ValueChanged<String?> onSelectionChanged;
  final String? initialValue; // Added to set an initial selection if needed

  const PaymentRadioGroup({
    super.key,
    required this.onSelectionChanged,
    this.initialValue, // Constructor for initial value
  });

  @override
  State<PaymentRadioGroup> createState() => _PaymentRadioGroupState();
}

class _PaymentRadioGroupState extends State<PaymentRadioGroup> {
  String? _selectedValue;
  final List<String> _options = ['Cash', 'Card', 'UPI'];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Use Column to stack "Payment Option" label and the Row of radios
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: ' Payment Option',),
        const SizedBox(height: 8), // Spacing between label and radios
        Row(
          // Use Row to place radio buttons horizontally
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space evenly
          children: _options.map((String value) {
            return Expanded( // Use Expanded to give equal space to each radio button
              child: Row(
                mainAxisSize: MainAxisSize.min, // Keep inner row compact
                children: [
                  Radio<String>(
                    value: value,
                    groupValue: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                      widget.onSelectionChanged(newValue);
                    },
                  ),
                  Text(value), // The label for the radio button
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
