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
}
