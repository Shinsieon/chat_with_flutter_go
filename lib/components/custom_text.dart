import 'package:flutter/material.dart';
import 'package:my_app/enums.dart';

class CustomText extends StatelessWidget {
  final String text; // 메인 텍스트
  final Color color; // 텍스트 색상
  final TextSize size; // TextSize Enum
  final FontWeightOption fontWeight; // FontWeightOption Enum

  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.size = TextSize.medium, // 기본값을 medium으로 설정
    this.fontWeight = FontWeightOption.medium, // 기본값을 medium으로 설정
  });

  @override
  Widget build(BuildContext context) {
    double fontSize;

    // TextSize에 따라 폰트 크기 설정
    switch (size) {
      case TextSize.small:
        fontSize = 14.0; // small 폰트 크기
        break;
      case TextSize.medium:
        fontSize = 18.0; // medium 폰트 크기
        break;
      case TextSize.large:
        fontSize = 24.0; // large 폰트 크기
        break;
    }

    FontWeight weight;

    // FontWeightOption에 따라 폰트 두께 설정
    switch (fontWeight) {
      case FontWeightOption.bold:
        weight = FontWeight.bold; // bold 설정
        break;
      case FontWeightOption.medium:
        weight = FontWeight.w500; // medium 설정
        break;
      case FontWeightOption.thin:
        weight = FontWeight.w200; // thin 설정
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: weight,
          ),
        ),
      ],
    );
  }
}
