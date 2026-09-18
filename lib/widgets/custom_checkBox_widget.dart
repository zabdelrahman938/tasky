import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatelessWidget {
  const CustomCheckboxWidget({super.key, required this.value, required this.onChanged, });
  final bool value;
final Function (bool? value)onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        checkColor: Color(0xffFFFCFC),
        activeColor: Color(0xff15B86C),
        onChanged: (bool? value)=>onChanged(value),
    );
  }
}
