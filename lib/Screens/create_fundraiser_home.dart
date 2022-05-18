import 'package:crowd_funding_app/Screens/create_fundraiser_page_one.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_page_shortcode.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/create_fundraiser_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateFundraiserHome extends StatelessWidget {
  const CreateFundraiserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.create_fundraiser_appbar_title_text.tr(),
          style: appbarTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.who_are_you_funraising_lable_text.tr(),
              style: bodyHeaderTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withAlpha(250),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CreateFundraiserCard(
              key: Key("create_legas_for_yourself"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateFundraiserPageShortcode(),
                  ),
                );
              },
              iconData: Icons.manage_accounts,
              title: LocaleKeys.your_self_or_someone_label_text.tr(),
              subTitle: LocaleKeys.donations_will_be_deposited_label_text.tr(),
            ),
            SizedBox(
              height: 10.0,
            ),
            CreateFundraiserCard(
              onPressed: () {},
              iconData: Icons.room_preferences_outlined,
              title: LocaleKeys.a_non_profit_or_label_text.tr(),
              subTitle: LocaleKeys.donations_will_be_auto_lable_text.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
