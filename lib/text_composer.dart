import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();

  bool _isComposed = false;

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile =
              // ignore: deprecated_member_use
              await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
              InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposed = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onPressed: _isComposed
                ? () {
              widget.sendMessage(text: _controller.text);
              _reset();
            }
                : null,
          ),
        ],
      ),
    );
  }
}
