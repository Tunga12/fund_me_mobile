import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BeneficiaryContinue extends StatelessWidget {
  const BeneficiaryContinue(this.token, this.data, this.user, {Key? key})
      : super(key: key);

  final String token;
  final String data;
  final User user;
  static const String routeName = '/beneficiary_continue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continue'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: ContinueButton(
            isValidate: true,
            onPressed: () async {
              List<String> datas = data.split(':');
              if (data[1] == user.id) {
                loadingProgress(context);
                await Provider.of<FundraiseModel>(context, listen: false)
                    .getSingleFundraise(datas[0]);
                Response response =
                    Provider.of<FundraiseModel>(context, listen: false)
                        .response;
                if (response.status == ResponseStatus.SUCCESS) {
                  Fundraise _fundraise = response.data;
                  _fundraise.beneficiary = User(id: datas[1]);
                  await Provider.of<FundraiseModel>(context, listen: false)
                      .updateFundraise(_fundraise, token);
                  Response _response =
                      Provider.of<FundraiseModel>(context, listen: false)
                          .response;
                  print(_response.data);
                  if (_response.status == ResponseStatus.SUCCESS) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName, (route) => false,
                        arguments: 2);
                  } else {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "Something went wrong",
                        toastLength: Toast.LENGTH_LONG);
                  }
                } else {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Something went wrong",
                      toastLength: Toast.LENGTH_LONG);
                }
              } else {
                Fluttertoast.showToast(
                  msg: "err: you are not invited in this fundraiser",
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            title: "Continue",
          ),
        ),
      ),
    );
  }
}
