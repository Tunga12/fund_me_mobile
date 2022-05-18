import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class YourDonationDetail extends StatelessWidget {
  const YourDonationDetail({
    Key? key,
    required this.donation,
    required this.tip,
  }) : super(key: key);
  final double donation;
  final double tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(LocaleKeys.paywith_label_text.tr(),
              style: titleTextStyle.copyWith(
                  fontSize: 18.0,
                  color: Theme.of(context).secondaryHeaderColor)),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${LocaleKeys.Your_donation_label_text.tr()} ",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(0.5)),
              ),
              Text(
                "$donation.00",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(0.5)),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       LocaleKeys.Legas_tip_label_text.tr(),
          //       style: labelTextStyle.copyWith(
          //           color: Theme.of(context)
          //               .secondaryHeaderColor
          //               .withOpacity(0.5)),
          //     ),
          //     Text(
          //       "\$${(tip * donation).toStringAsFixed(2)}",
          //       style: labelTextStyle.copyWith(
          //           color: Theme.of(context)
          //               .secondaryHeaderColor
          //               .withOpacity(0.5)),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          Divider(
            thickness: 2.0,
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.total_due_today_label_text.tr(),
                style: labelTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              Text(
                "${(donation).toStringAsFixed(2)}",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
