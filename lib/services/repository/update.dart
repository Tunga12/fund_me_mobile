import 'dart:io';

import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/services/data_provider/update.dart';

class UpdateRepository {
  UpdateDataProvider updateDataProvider;
  UpdateRepository({
    required this.updateDataProvider,
  });

  Future<bool> createUpdate(
      Update update, String token, String fundraiseId, {File? image}) async {
    return await updateDataProvider.createUpdate(
      update,
      token,
      fundraiseId,
      image: image
    );
  }

  Future<bool> deleteUpdate(String updateId, String token) async {
    return await updateDataProvider.deleteUpdate(updateId, token);
  }
}
