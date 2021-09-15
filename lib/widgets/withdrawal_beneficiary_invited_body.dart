import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class BeneficiaryVinvited extends StatelessWidget {
  const BeneficiaryVinvited({
    Key? key,
    required this.beneficiary,
    required this.isAccepted,
    required this.isWithdrawn,
  }) : super(key: key);
  final User beneficiary;
  final bool isAccepted;
  final bool isWithdrawn;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BeneficiaryStatus(
            showVertical: true,
            title: "Beneficiary set",
            isCompleted: true,
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beneficiary.firstName! + " " + beneficiary.firstName!,
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    Text(
                      beneficiary.email!,
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          BeneficiaryStatus(
            showVertical: true,
            title: "Invitation Sent",
            isCompleted: true,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invitation sent to ${beneficiary.email}",
                    style: kBodyTextStyle.copyWith(
                      height: 2,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "Resend",
                    style: kBodyTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BeneficiaryStatus(
            showVertical: true,
            title: "Beneficiary accepted",
            isCompleted: isAccepted,
            child: Container(
              child: Text(
                "Waiting on ${beneficiary.firstName} to accept their invitation",
                style: kBodyTextStyle.copyWith(
                  height: 2,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          BeneficiaryStatus(
            showVertical: false,
            title: "Money withdrawn",
            isCompleted: isWithdrawn,
            child: Container(
              width: size.width * 0.8,
              child: Text(
                '${beneficiary.firstName} has not finished identification verification',
                style: kBodyTextStyle.copyWith(
                  height: 2,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Cancel invite",
              style: kBodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BeneficiaryStatus extends StatelessWidget {
  const BeneficiaryStatus({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.child,
    required this.showVertical,
  }) : super(key: key);

  final String title;
  final bool isCompleted;
  final Widget child;
  final bool showVertical;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isCompleted
                        ? Icons.check_circle_sharp
                        : Icons.circle_outlined,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
                    size: 15.0,
                  ),
                  if (showVertical)
                    SizedBox(
                      height: size.height * 0.15,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.3),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    child
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
