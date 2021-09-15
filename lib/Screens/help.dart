import 'package:crowd_funding_app/Models/help.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/help_detail.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/help.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/help_card.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/unorderd_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  List<HelpDataModel> _helps = [];
  List<HelpDataModel> _searchedHelp = [];
  bool _search = false;
  String _searchTitle = '';

  Response _response = Response(
    status: ResponseStatus.LOADING,
    data: '',
    message: '',
  );

  _getHelps() async {
    await Future.delayed(
      Duration(seconds: 2),
      () => Provider.of<HelpModel>(context, listen: false).getHelp(),
    );
    Response responseHelp =
        Provider.of<HelpModel>(context, listen: false).response;
    setState(() {
      _helps = responseHelp.data;
      _response = responseHelp;
    });
  }

  _searchHelp(String title) {
    setState(() {
      _searchedHelp = _helps
          .where(
            (element) =>
                element.title!.toLowerCase().contains(title.toLowerCase()) ||
                element.content!.toLowerCase().contains(title.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  void initState() {
    _getHelps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (_response.status == ResponseStatus.SUCCESS) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.Help_listtile_text.tr(),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: size.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    // spreadRadius: 5,
                    blurRadius: 0.3,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/logo_image.PNG",
                    ),
                    width: size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.how_can_I_hlep_you_text.tr() + "?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _search = false;
                        });
                      }
                    },
                    onSubmitted: (title) {
                      if (title.isNotEmpty) {
                        _search = true;
                        _searchHelp(title);
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        hintText: LocaleKeys.search_label_text.tr(),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: LocaleKeys.click_here_text.tr(),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        TextSpan(
                          text: LocaleKeys.looking_for_fundraiser_text.tr(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).secondaryHeaderColor),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              color: Colors.pink.shade50.withOpacity(0.6),
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: _search && _searchedHelp.isEmpty
                  ? Center(
                      child: Text(
                        'Not Found',
                        style: bodyHeaderTextStyle.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      primary: true,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _search ? _searchedHelp.length : _helps.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HelpDetail(
                                  body: _search
                                      ? _searchedHelp[index].content!
                                      : _helps[index].content!,
                                  title: _search
                                      ? _searchedHelp[index].title!
                                      : _helps[index].title!,
                                ),
                              ),
                            );
                          },
                          child: HelpCard(
                            content: _search
                                ? _searchedHelp[index].content!
                                : _helps[index].content!,
                            title: _search
                                ? _searchedHelp[index].title!
                                : _helps[index].title!,
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.popular_article_text.tr(),
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                  UnorderedList(text: LocaleKeys.changing_phone_number_text.tr()),
                 
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5.0,
                      offset: Offset(0, 3))
                ],
              ),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  child: Text(
                    LocaleKeys.get_help_text.tr(),
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            
          ],
        ),
      );
    } else {
      return ResponseAlert(_response.message);
    }
  }
}
