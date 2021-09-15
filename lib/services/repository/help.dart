import 'package:crowd_funding_app/Models/help.dart';
import 'package:crowd_funding_app/services/data_provider/help.dart';

class HelpRepository {
  final HelpDataProvider helpDataProvider;
  HelpRepository({required this.helpDataProvider});

  Future<List<HelpDataModel>> getHelp() async {
    return await helpDataProvider.getHelp();
  }
}
