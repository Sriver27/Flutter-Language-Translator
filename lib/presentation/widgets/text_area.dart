import 'package:flutter/material.dart';

class TranslationTextInput extends StatefulWidget {
  final int maxCharacters;
  final ValueChanged<String>? onChanged;

  TranslationTextInput({
    Key? key,
    required this.maxCharacters,
    this.onChanged,
  }) : super(key: key);

  @override
  _TranslationTextInputState createState() => _TranslationTextInputState();
}

class _TranslationTextInputState extends State<TranslationTextInput> {
  TextEditingController _controller = TextEditingController();
  int charactersTyped = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCharacterCount);
  }

  void _updateCharacterCount() {
    setState(() {
      charactersTyped = _controller.text.length;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(35, 37, 39, 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: TextField(
                  cursorHeight: 20,
                  controller: _controller,
                  maxLines: null,
                  maxLength: widget.maxCharacters,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 1.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(60, 62, 64, 1.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$charactersTyped/${widget.maxCharacters}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TranslationTextOutput extends StatefulWidget {
  final int maxCharacters;
  String translatedText;
  TranslationTextOutput(
      {super.key, required this.maxCharacters, required this.translatedText});

  @override
  State<TranslationTextOutput> createState() => _TranslationTextOutputState();
}

class _TranslationTextOutputState extends State<TranslationTextOutput> {
  TextEditingController _controller = TextEditingController();
  int charactersTyped = 0;
  @override
  void initState() {
    // TODO: implement initState
    _controller.text = widget.translatedText;
    charactersTyped = _controller.text.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(35, 37, 39, 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  readOnly: true,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 1.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(60, 62, 64, 1.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$charactersTyped/${widget.maxCharacters}",
                style: TextStyle(
                  color: Colors.white, // Color of character count text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
