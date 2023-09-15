import 'package:flutter/material.dart';
import 'package:stylesync/api/apiServices.dart';

import '../widgets/custom_search_field.dart';

class LanguagePickerDialog extends StatefulWidget {
  final String direction;
  LanguagePickerDialog({super.key, required this.direction});
  @override
  _LanguagePickerDialogState createState() => _LanguagePickerDialogState();
}

class _LanguagePickerDialogState extends State<LanguagePickerDialog> {
  List<String> availableLanguages = [];
  List<String> displayedLanguages = [];
  int filteredListCount = 0;
  String selectedLanguage = '';

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLanguages();
  }

  Future<void> _fetchLanguages() async {
    try {
      final response = await TranslatorApi().fetchLanguages();
      final languagesList = response['data']['languages'];

      if (languagesList is List) {
        setState(() {
          availableLanguages = languagesList.map((language) {
            return language['language'].toString();
          }).toList();
          displayedLanguages =
              List.from(availableLanguages); // Copy all languages initially
        });
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (error) {
      print('Error fetching languages: $error');
    }
  }

  void _filterLanguages(String searchText) {
    setState(() {
      displayedLanguages = availableLanguages
          .where((language) =>
              language.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredListCount = displayedLanguages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFF16181A)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.direction,
                style: TextStyle(color: Colors.white30, fontSize: 18)),
          ),
          CustomSearchField(
            controller: _searchController,
            onChanged: (text) {
              _filterLanguages(text);
            },
          ),
          displayedLanguages.isEmpty
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("All Languages",
                          style:
                              TextStyle(color: Colors.white30, fontSize: 18)),
                    ),
                    Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("All Languages",
                      style: TextStyle(color: Colors.white30, fontSize: 18)),
                ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedLanguages.length,
              itemBuilder: (context, index) {
                final language = displayedLanguages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(language[0].toUpperCase()),
                    ),
                    tileColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    title:
                        Text(language, style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {
                        selectedLanguage = language;
                      });
                      Navigator.of(context).pop(language);
                    },
                  ),
                );
              },
            ),
          ),
          _searchController.text.isEmpty
              ? SizedBox()
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                      text: TextSpan(
                        text: 'There Are',
                        style: TextStyle(color: Colors.white30, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' $filteredListCount Languages',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          TextSpan(
                              text: ' With The',
                              style: TextStyle(
                                  color: Colors.white30, fontSize: 14)),
                          TextSpan(
                              text: ' Letter ${_searchController.text}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
