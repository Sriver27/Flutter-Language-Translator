import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stylesync/api/apiServices.dart';
import 'package:stylesync/presentation/widgets/text_area.dart';

import '../widgets/language_picker_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String transformFromLanguage = "en";
  String transformToLanguage = "hi";
  ValueNotifier<bool> isInputChangedNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> inputText = ValueNotifier<String>("");
  String resultText = "";

  void updatePickedLanguage(String language, String direction) {
    setState(() {
      if (direction == "From") {
        transformFromLanguage = language;
      } else if (direction == "To") {
        transformToLanguage = language;
      }
    });
  }

  void translate() async {
    final translationResult = await TranslatorApi().translateText(
      inputText.value,
      transformFromLanguage,
      transformToLanguage,
    );
    setState(() {
      resultText =
          translationResult['data']['translations'][0]['translatedText'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 12),
                    child: const Text("Text Translation",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 2.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF232527),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LanguagePickerButton(
                          direction: "From",
                          pickedLanguage: transformFromLanguage,
                          onLanguageSelected: (language) {
                            updatePickedLanguage(language, "From");
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              final temp = transformFromLanguage;
                              transformFromLanguage = transformToLanguage;
                              transformToLanguage = temp;
                            });
                          },
                          child: const FaIcon(FontAwesomeIcons.exchange,
                              color: Color(0xFF828383), size: 15),
                        ),
                        LanguagePickerButton(
                          direction: "To",
                          pickedLanguage: transformToLanguage,
                          onLanguageSelected: (language) {
                            updatePickedLanguage(language, "To");
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Text("Translate from ",
                            style: TextStyle(
                                color: Color(0xFF828383),
                                fontSize: 14,
                                fontWeight: FontWeight.w300)),
                        Text('(${transformFromLanguage})',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                  TranslationTextInput(
                    maxCharacters: 2300,
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        isInputChangedNotifier.value = true;
                        inputText.value = text;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Text("Translate to ",
                            style: TextStyle(
                                color: Color(0xFF828383),
                                fontSize: 14,
                                fontWeight: FontWeight.w300)),
                        Text('(${transformToLanguage})',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                  TranslationTextOutput(
                    maxCharacters: 2300,
                    translatedText: resultText,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isInputChangedNotifier,
                    builder: (context, value, child) {
                      return value
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: ElevatedButton(
                                    onPressed: () => translate(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text("Translate",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurpleAccent),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
