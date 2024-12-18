import 'package:filter_app/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
        ),
      ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
            readOnly: readOnly,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF800020),),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF800020),),
                  borderRadius: BorderRadius.circular(12)),
            ))
      ],
    );
  }
}
