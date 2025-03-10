
import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomStepperWidget extends StatelessWidget {
  final bool isDone;
  final String firstStepHeader;
  final String secondStepHeader;

  final VoidCallback? onFirstStepperTap;
  final VoidCallback? onSecondStepperTap;

  const CustomStepperWidget(
      {super.key,
        required this.isDone,
        required this.firstStepHeader,
        required this.secondStepHeader,
        this.onFirstStepperTap,
        this.onSecondStepperTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: isDone && onFirstStepperTap != null
                  ? onFirstStepperTap
                  : null,
              child: Row(
                children: [
                  isDone
                      ? CircleAvatar(
                      radius: 10,
                      backgroundColor: context.colorScheme.primary,
                      child: Center(
                          child: Icon(
                            Icons.check,
                            size: 14,
                            color: context.colorScheme.surface,
                          )))
                      : Icon(
                    Icons.radio_button_checked,
                    color: context.colorScheme.primary,
                  ),
                  5.width,
                  Expanded(
                      child: Text(
                        firstStepHeader,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ))
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Divider(
              thickness: 2,
            ),
          ),
          10.width,
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: !isDone && onSecondStepperTap != null
                  ? onSecondStepperTap
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isDone
                      ? Icon(
                    Icons.radio_button_checked,
                    color: context.colorScheme.primary,
                  )
                      : Container(
                    height: 18,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
                        )),
                  ),
                  5.width,
                  Text(secondStepHeader)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
