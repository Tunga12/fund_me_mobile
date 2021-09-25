import 'package:crowd_funding_app/Models/reason.dart';
import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/services/data_provider/report.dart';

class ReportRepository {
  final ReportDataProvider reportDataProvider;

  ReportRepository({
    required this.reportDataProvider,
  });

  Future<Report> createReport(Report report, String token) async {
    return await reportDataProvider.createReport(report, token);
  }

  // fetch report reasons;
  Future<List<ReportReason>> getReportReasons() async {
    return await reportDataProvider.getReportReasons();
  }
}
