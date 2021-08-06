import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () async {
            final value2 = await _keyEditor.currentState?.getText();
            await Future.delayed(Duration(milliseconds: 500));
            final value = await _keyEditor.currentState?.getText();

            Navigator.of(context).pop(value);
          },
        ),
        title: Text("Story"),
      ),
      body: SingleChildScrollView(
        child: FlutterSummernote(
          value: widget.data,
          hasAttachment: true,
          hint: "Your text here...",
          key: _keyEditor,
          customToolbar: """
              [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']]
              ]""",
        ),
      ),
    );
  }
}
