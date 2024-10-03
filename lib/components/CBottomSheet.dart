import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/CBottomButton.dart';
import 'package:my_app/components/CText.dart';
import 'package:my_app/enums.dart';

class BottomSheetParams {
  final BuildContext context;
  final Widget child;
  final String title;

  BottomSheetParams({
    required this.context,
    required this.child,
    required this.title,
  });
}

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;

  const CustomBottomSheet({
    required this.child,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: title, size: TextSize.large),
                ],
              ),
              const SizedBox(height: 10),
              child,
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

void showCBottomSheet(BottomSheetParams params) {
  showModalBottomSheet(
    context: params.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        title: params.title,
        child: params.child,
      );
    },
  );
}
