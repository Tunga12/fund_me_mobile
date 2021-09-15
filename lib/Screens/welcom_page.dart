import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/or.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);
  static const String routeName = "/welcomePage";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _images = [
    'assets/images/welcome_one.jpg',
    'assets/images/welcome_two.jpg',
    'assets/images/welcome_three.jpg'
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("welcome page");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 250.0,
                        autoPlay: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }),
                    items: _images.map(
                      (image) {
                        return Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: AssetImage(
                                image,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: size.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _images.map((urlOfItem) {
                        int index = _images.indexOf(urlOfItem);
                        return Container(
                          width: 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.black
                                  : Colors.white),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                      bottom: 0.0,
                      child: Container(
                        width: size.width,
                        height: 12.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(size.width, 20.0),
                            )),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/logo_image.PNG',
                      ),
                      width: size.width * 0.4,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      LocaleKeys.the_number_one_label_text.tr(),
                      textAlign: TextAlign.center,
                      style: titleTextStyle.copyWith(
                          height: 1.8,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.8)),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ContinueButton(
                      isValidate: true,
                      onPressed: () {},
                      title: LocaleKeys.start_a_legas_text.tr(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 45.0,
                      width: size.width,
                      child: TextButton(
                        key: Key("welcome_page_signin_button"),
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: Theme.of(context).accentColor))),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SigninPage.routeName, (route) => false);
                        },
                        child: Text(
                          LocaleKeys.login_appbar_title.tr(),
                          style: labelTextStyle.copyWith(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    OrDivider(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.routeName, (route) => false);
                      },
                      child: Text(
                        LocaleKeys.browse_fundraisers_text.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      LocaleKeys.legas_policy_text.tr(),
                      style: TextStyle(
                          fontSize: 11.0,
                          color: Theme.of(context).secondaryHeaderColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
