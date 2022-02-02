import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:wiifd/data_model/profile_settings.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState.notPurchased() = _notPurchased;

  const factory PurchaseState.error(String errorMessage) = _Error;

  const factory PurchaseState.purchase(List<Package> package) = _purchased;
}
