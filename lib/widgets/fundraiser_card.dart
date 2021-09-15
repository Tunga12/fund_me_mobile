import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FundraiserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.65,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(
                40.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.healp_your_community_text.tr(),textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.6)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            LocaleKeys.user_current_location_text.tr(),
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(LocaleKeys.enter_locaton_text.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/car.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
