import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:crowd_funding_app/services/data_provider/withdraw.dart';

class WithdrawalRepository {
  final WithdrawDataProvider withdrawDataProvider;
  WithdrawalRepository({
    required this.withdrawDataProvider,
  });

  Future<bool> createWithdrawal(
      Withdrwal withdrwal, String token, String fundraiserId) async {
    return await withdrawDataProvider.createWithdrawal(
        withdrwal, token, fundraiserId);
  }

  Future<String> inviteBeneficiary(
      String email, String token, String fundraiseId) async {
    return await withdrawDataProvider.inviteBeneficiary(
        email, token, fundraiseId);
  }
}
