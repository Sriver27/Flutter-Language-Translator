import 'package:flutter/material.dart';

import '../pages/language_picker_dialog.dart';
import 'language_picker_card.dart';

class LanguagePickerButton extends StatelessWidget {
  final String direction;
  final String pickedLanguage;
  final ValueChanged<String> onLanguageSelected;

  LanguagePickerButton({
    required this.direction,
    required this.pickedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedLanguage = await showModalBottomSheet(
          context: context,
          builder: (context) => LanguagePickerDialog(
            direction: direction,
          ),
        );
        if (selectedLanguage != null) {
          onLanguageSelected(selectedLanguage);
        }
      },
      child: LanguagePicker(
        pickedLanguage: pickedLanguage,
        onLanguageSelected: onLanguageSelected,
      ),
    );
  }
}
