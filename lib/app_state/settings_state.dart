import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.noError() = _NoError;

  const factory SettingsState.error(String errorMessage) = _Error;

  const factory SettingsState.loading() = _Loading;
}
