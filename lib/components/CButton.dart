import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/enums.dart';

// 버튼 크기 Enum

// 공통 버튼 위젯
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final ButtonSize size; // ButtonSize Enum으로 변경

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.okButtonColor,
    this.textColor = Colors.white,
    this.borderRadius = 15.0,
    this.size = ButtonSize.medium, // 기본값을 medium으로 설정
  });

  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져오기 위해 MediaQuery 사용
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth;

    // 버튼 크기 설정
    switch (size) {
      case ButtonSize.large:
        buttonWidth = screenWidth; // large는 전체 너비
        break;
      case ButtonSize.medium:
        buttonWidth = screenWidth * 0.5; // medium은 화면의 50%
        break;
      case ButtonSize.small:
        buttonWidth = screenWidth * 0.2; // small은 화면의 20%
        break;
      default:
        buttonWidth = screenWidth * 0.5; // 기본값은 medium
    }

    return SizedBox(
      width: buttonWidth, // 버튼 너비 설정
      height: 55, // 버튼 높이 설정
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, backgroundColor: backgroundColor,
          padding: EdgeInsets.zero, // Padding을 0으로 설정하여 height 적용
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius), // border-radius 적용
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
