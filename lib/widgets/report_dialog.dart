import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/Models/report_reasons.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/report.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog(this.fundraise, {Key? key}) : super(key: key);
  final Fundraise fundraise;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  ReportReasons? _reportReasons = ReportReasons.REASON_ONE;
  List<String> _listReason = [
    "Unknown user from company",
    'Illegal fundraisers',
    'It is fundraised for profit'
  ];
  String _reason = "Unknown user from company";

  String _token = "";

  @override
  void initState() {
    super.initState();
    _getUserInformation();
  }

  _getUserInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData preferenceData = await userPreference.getUserToken();

    if (mounted) {
      setState(() {
        _token = preferenceData.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.tell_us_the_reason.tr()),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Radio<ReportReasons>(
                      value: ReportReasons.REASON_ONE,
                      groupValue: _reportReasons,
                      onChanged: (value) {
                        setState(() {
                          _reportReasons = value!;
                          _reason = _listReason[0];
                        });
                      }),
                  Text(_listReason[0])
                ],
              ),
              Row(
                children: [
                  Radio<ReportReasons>(
                      value: ReportReasons.REASON_TWO,
                      groupValue: _reportReasons,
                      onChanged: (value) {
                        setState(() {
                          _reportReasons = value!;
                          _reason = _listReason[1];
                        });
                      }),
                  Text(_listReason[1])
                ],
              ),
              Row(
                children: [
                  Radio<ReportReasons>(
                      value: ReportReasons.REASON_THREE,
                      groupValue: _reportReasons,
                      onChanged: (value) {
                        setState(() {
                          _reportReasons = value!;
                          _reason = _listReason[2];
                        });
                      }),
                  Text(_listReason[2])
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              backgroundColor: Theme.of(context).accentColor),
          onPressed: () async {
            loadingProgress(context);
            print(_token);
            Report _report =
                Report(fundraiserId: widget.fundraise.id, reason: _reason);
            print(_reason);
            await Provider.of<ReportModel>(context, listen: false)
                .createReport(_report, _token);
            Response _response =
                Provider.of<ReportModel>(context, listen: false).response;
            if (_response.status == ResponseStatus.SUCCESS) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Report sent");
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: _response.message);
            }
          },
          child: Text(
            LocaleKeys.submit_button_text.tr(),
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        )
      ],
    );
  }
}
