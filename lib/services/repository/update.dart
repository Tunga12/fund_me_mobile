import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/services/data_provider/update.dart';

class UpdateRepository {
  UpdateDataProvider updateDataProvider;
  UpdateRepository({
    required this.updateDataProvider,
  });

  Future<Update> createUpdate(
      Update update, String token, String fundraiseId) async {
    return await updateDataProvider.createUpdate(
      update,
      token,
      fundraiseId,
    );
  }
}
