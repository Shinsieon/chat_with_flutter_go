import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/CButton.dart';

class ButtonConfig {
  final String text;
  final VoidCallback onPressed;

  ButtonConfig({
    required this.text,
    required this.onPressed,
  });
}

class CustomBottomButton extends StatelessWidget {
  final List<ButtonConfig> buttons;
  final double height;
  final double gap;

  const CustomBottomButton({
    required this.buttons,
    this.height = 50,
    this.gap = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.asMap().entries.map((entry) {
        int index = entry.key;
        ButtonConfig button = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : gap / 2,
              right: index == buttons.length - 1 ? 0 : gap / 2,
            ),
            child: SizedBox(
              height: height,
              child: CustomButton(
                onPressed: button.onPressed,
                text: button.text,
                backgroundColor: index == 0
                    ? AppColors.cancelButtonColor
                    : AppColors.okButtonColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
