import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.or_label_text.tr(),
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
