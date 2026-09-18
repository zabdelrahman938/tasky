import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({super.key, required this.controller, required this.title, required this.hintText,  required this.maxLines,this.validator,});
final TextEditingController controller;
final String title;
final String hintText;
final int maxLines;
final Function(String? value)?validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
        //  cursorColor: Color(0xffFFFCFC),
          style:Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText,),
          validator:validator!=null?(String? value)=>validator!(value):null,


        ),
      ],
    );
  }
}
