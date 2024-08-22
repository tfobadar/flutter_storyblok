import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextAlign? titleAlign;
  final TextAlign? descriptionAlign;

  SectionTitle({
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.titleAlign = TextAlign.start,
    this.descriptionAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              Theme.of(context)
                  .textTheme
                  .headlineSmall, // Updated to headlineSmall
          textAlign: titleAlign,
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: descriptionStyle ??
              Theme.of(context).textTheme.bodyMedium, // Updated to bodyMedium
          textAlign: descriptionAlign,
        ),
      ],
    );
  }
}
