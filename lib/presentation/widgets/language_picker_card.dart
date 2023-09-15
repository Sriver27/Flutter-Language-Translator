import 'package:flutter/material.dart';

import '../pages/language_picker_dialog.dart';

class LanguagePicker extends StatefulWidget {
  String pickedLanguage;
  final ValueChanged<String> onLanguageSelected;
  LanguagePicker({
    Key? key,
    required this.pickedLanguage,
    required this.onLanguageSelected,
  }) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Color.fromRGBO(35, 37, 39, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: GestureDetector(
          onTap: () async {
            final selectedLanguage = await showModalBottomSheet(
              context: context,
              builder: (context) => LanguagePickerDialog(direction: "From"),
            );
            if (selectedLanguage != null) {
              // Update the selected language directly within this widget
              setState(() {
                widget.onLanguageSelected(selectedLanguage);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  child: Text(widget.pickedLanguage[0].toUpperCase()),
                ),
                Text(
                  widget.pickedLanguage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
