import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.obscure,
    this.controller,
    this.keyboardType,
    this.maxLength,
  });
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'NotoKufiArabic',
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          obscureText: obscure,
          validator: (value) {
            if (value!.isEmpty) {
              return 'ادخل البيانات بشكل صحيح';
            }
          },
          controller: controller,
          cursorColor: kPrimarycolor,
          keyboardType: keyboardType,
          maxLength: maxLength,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              contentPadding: const EdgeInsets.all(13.0),
              hintText: hint,
              suffixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
              hintTextDirection: TextDirection.rtl,
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none)),
        )
      ],
    );
  }
}
