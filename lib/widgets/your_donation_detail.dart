import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class YourDonationDetail extends StatelessWidget {
  const YourDonationDetail({
    Key? key,
    required this.donation,
    required this.tip,
  }) : super(key: key);
  final int donation;
  final double tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your donation",
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
                "Your donation $donation ",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(0.5)),
              ),
              Text(
                "\$$donation.00",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "GoFundMe tip",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(0.5)),
              ),
              Text(
                "\$${(tip * donation).toStringAsFixed(0)}.00",
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
                "Total due today",
                style: labelTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              Text(
                "\$${donation + int.parse((tip * donation).toStringAsFixed(0))}.00",
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
