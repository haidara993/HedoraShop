import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hedorashop/themes/constant.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedFn;

  CustomButton(this.text, this.onPressedFn);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressedFn,
        child: PhysicalModel(
          color: Colors.grey.withOpacity(.4),
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: PRIMARY_COLOR,
            ),
            child: Container(
              margin: EdgeInsets.all(14),
              alignment: Alignment.center,
              child: CustomText(
                alignment: Alignment.center,
                text: text,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ));
  }
}
