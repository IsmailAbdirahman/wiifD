import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wiifd/app_state/purchase_state.dart';
import 'package:wiifd/data_source/payment_source.dart';
import 'package:wiifd/data_source/supabase_db.dart';

final paymentModelProvider =
    StateNotifierProvider<PaymentModel, PurchaseState>((ref) {
  final paymentSource = ref.watch(paymentProvider);
  final dataSource = ref.watch(supabaseProvider);
  return PaymentModel(paymentSource: paymentSource, supabaseDB: dataSource);
});

class PaymentModel extends StateNotifier<PurchaseState> {
  PaymentModel({required this.paymentSource, required this.supabaseDB})
      : super(PurchaseState.notPurchased()) {
    paymentSource.checkActiveSubscriptions();
    getPackages();
  }

  final PaymentSource paymentSource;
  final SupabaseDB supabaseDB;

  Future<List<Offering>> fetchOffering() async {
    final data = await paymentSource.fetchOffering();
    return data;
  }

  Future<List<Package>> getPackages() async {
    final data = await paymentSource.getPackages();
    state = PurchaseState.purchase(data);
    return data;
  }

  Future<bool> makePurchase(Package package) async {
    final result = await paymentSource.makePurchase(package);
    if (result == true) {
      supabaseDB.updateCoins(50);
    }
    return result;
  }
}
