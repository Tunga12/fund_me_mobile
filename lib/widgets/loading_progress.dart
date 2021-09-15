import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future loadingProgress(BuildContext context) {
  return authShowDialog(
    context,
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          width: 20.0,
        ),
        Text(
          LocaleKeys.loading_label_text.tr(),
        ),
      ],
    ),
    close: false,
    error: false,
  );
}
