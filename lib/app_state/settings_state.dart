import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiifd/data_model/profile_settings.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initializing() = _initializing;

  const factory SettingsState.error(String errorMessage) = _Error;

  const factory SettingsState.loaded(ProfileSettings data) = _Loaded;
}
