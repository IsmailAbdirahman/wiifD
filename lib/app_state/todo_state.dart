import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_model/todo_info_model.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.loading() = _loading;

  const factory TodoState.data(TodoInfo todoInfo) = _data;

  const factory TodoState.error(String message) = _error;
}
