import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

class CustomTimeSelector extends StatefulWidget {
  final String title;
  final void Function(int hour, int minute)? onTimeSelected;

  const CustomTimeSelector({
    super.key,
    required this.title,
    this.onTimeSelected,
  });

  @override
  State<CustomTimeSelector> createState() => _CustomTimeSelectorState();
}

class _CustomTimeSelectorState extends State<CustomTimeSelector> {
  int? _hour;
  int? _minute;

  Future<void> _pickHour() async {
    final selected = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Hour"),
          children: List.generate(24, (i) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, i),
              child: Text(i.toString().padLeft(2, '0')),
            );
          }),
        );
      },
    );
    if (selected != null) {
      setState(() => _hour = selected);
      widget.onTimeSelected?.call(_hour ?? 0, _minute ?? 0);
    }
  }

  Future<void> _pickMinute() async {
    final selected = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Minute"),
          children: List.generate(60, (i) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, i),
              child: Text(i.toString().padLeft(2, '0')),
            );
          }),
        );
      },
    );
    if (selected != null) {
      setState(() => _minute = selected);
      widget.onTimeSelected?.call(_hour ?? 0, _minute ?? 0);
    }
  }

  Widget _buildBox(String label, String value, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppConstants.tileBodyFillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppConstants.textFieldBorderColor,
                width: .850,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color:   AppConstants.textFieldHintTextColor
                      
                ),
              ),
              Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: widget.title),
        5.vs(),
        Row(
          children: [
            _buildBox("Hour", _hour?.toString().padLeft(2, '0') ?? "Hour", _pickHour),
            10.hs(),
            _buildBox("Minute", _minute?.toString().padLeft(2, '0') ?? "Minutes", _pickMinute),
          ],
        ),
        25.vs(),
      ],
    );
  }
}
