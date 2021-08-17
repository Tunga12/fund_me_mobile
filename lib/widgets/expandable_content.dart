import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/widgets/update_body.dart';
import 'package:flutter/material.dart';

class ExpandableContent extends StatefulWidget {
  const ExpandableContent({Key? key, required this.updates}) : super(key: key);

  final List<Update> updates;

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  bool _flag = true;
  List<Update> _firstHalf = [];
  List<Update> _secondHalf = [];

  @override
  void initState() {
    if (widget.updates.length > 1) {
      _firstHalf = [widget.updates.first];
      _secondHalf = widget.updates;
    } else {
      _firstHalf = [widget.updates.first];
      _secondHalf = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: _secondHalf.isEmpty
          ? UpdateBody(update: _firstHalf.first)
          : Column(
            children: [
              Column(
                  children: _flag
                      ? _firstHalf
                          .map((update) => UpdateBody(update: update))
                          .toList()
                      : _secondHalf
                          .map((update) => UpdateBody(update: update))
                          .toList(),
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _flag ? "show more" : "show less",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _flag = !_flag;
                    });
                  },
                ),
            ],
          ),
    );
  }
}
