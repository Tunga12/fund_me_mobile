import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 25) {
      firstHalf = widget.text.substring(0, 25);
      secondHalf = widget.text.substring(25, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return Container(
       
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf, style: labelTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                        color: Theme.of(context).secondaryHeaderColor),)
          : Column(
              children: [
                Container(
                 width: size.width * 0.6,
                  child: Text(
                    flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                    style: labelTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
