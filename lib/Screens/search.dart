import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool textFieldIsFocused = true;

  toggleFocused() {
    setState(() {
      textFieldIsFocused = !textFieldIsFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: TextField(
                autofocus: textFieldIsFocused,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 1.0)),
                  suffixIcon: textFieldIsFocused
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            toggleFocused();
                            currentFocus.unfocus();
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            setState(() {
                              textFieldIsFocused = !textFieldIsFocused;
                            });
                          },
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
