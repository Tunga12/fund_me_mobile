import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/reason.dart';
import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/Models/report_reasons.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/services/provider/report.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog(this.fundraise, this.reportReasons, {Key? key})
      : super(key: key);
  final Fundraise fundraise;
  final List<ReportReason> reportReasons;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String _token = "";

  String? _reportReason;
  String? _reportReasonName = "";

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
        _reportReason = widget.reportReasons[0].id;
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
            children: widget.reportReasons
                .map(
                  (reason) => Row(
                    children: [
                      Radio<String>(
                          value: reason.id!,
                          groupValue: _reportReason,
                          onChanged: (value) {
                            setState(() {
                              _reportReason = value!;
                              _reportReasonName = reason.name;
                            });
                          }),
                      Text(reason.name!)
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              backgroundColor: Theme.of(context).accentColor),
          onPressed: () async {
            // print(_reportReason);
            print(_reportReasonName);
            loadingProgress(context);
            print(_token);
            Report _report =
                Report(fundraiserId: widget.fundraise.id, id: _reportReason);
            print(_reportReasonName);
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
