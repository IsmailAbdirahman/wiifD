import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../main.dart';

final paymentProvider = Provider((ref) => PaymentSource());

class PaymentSource {
  static const apikey = 'goog_lfWQhaHxLGYrxrySNKCNlHLQKaa';

  Future<void> initKey() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(apikey);
  }

  checkActiveSubscriptions() {
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      await updatePurchaseStatus();
    });
  }

  updatePurchaseStatus() async {
    final purchaseInfo = await Purchases.getPurchaserInfo();
    final entitlement = purchaseInfo.entitlements.active.values.toList();
  }

  Future<List<Offering>> fetchOffering() async {
    try {
      final offering = await Purchases.getOfferings();
      final current = offering.current;
      return current == null ? [] : [current];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<List<Package>> getPackages() async {
    final offerings = await fetchOffering();
    final packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    return packages;
  }

  Future<bool> makePurchase(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  restoreUserInfo(String userUID) async {
    // Later log in provided user Id
    //'my_app_user_id'  can be the userUID
    LogInResult result = await Purchases.logIn(userUID);
  }
}
