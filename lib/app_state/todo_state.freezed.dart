// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TodoStateTearOff {
  const _$TodoStateTearOff();

  _loading loading() {
    return const _loading();
  }

  _data data(List<TodoInfo> todoInfo) {
    return _data(
      todoInfo,
    );
  }

  _error error(String message) {
    return _error(
      message,
    );
  }
}

/// @nodoc
const $TodoState = _$TodoStateTearOff();

/// @nodoc
mixin _$TodoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TodoInfo> todoInfo) data,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_loading value) loading,
    required TResult Function(_data value) data,
    required TResult Function(_error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res> implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  final TodoState _value;
  // ignore: unused_field
  final $Res Function(TodoState) _then;
}

/// @nodoc
abstract class _$loadingCopyWith<$Res> {
  factory _$loadingCopyWith(_loading value, $Res Function(_loading) then) =
      __$loadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$loadingCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$loadingCopyWith<$Res> {
  __$loadingCopyWithImpl(_loading _value, $Res Function(_loading) _then)
      : super(_value, (v) => _then(v as _loading));

  @override
  _loading get _value => super._value as _loading;
}

/// @nodoc

class _$_loading implements _loading {
  const _$_loading();

  @override
  String toString() {
    return 'TodoState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TodoInfo> todoInfo) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_loading value) loading,
    required TResult Function(_data value) data,
    required TResult Function(_error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _loading implements TodoState {
  const factory _loading() = _$_loading;
}

/// @nodoc
abstract class _$dataCopyWith<$Res> {
  factory _$dataCopyWith(_data value, $Res Function(_data) then) =
      __$dataCopyWithImpl<$Res>;
  $Res call({List<TodoInfo> todoInfo});
}

/// @nodoc
class __$dataCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$dataCopyWith<$Res> {
  __$dataCopyWithImpl(_data _value, $Res Function(_data) _then)
      : super(_value, (v) => _then(v as _data));

  @override
  _data get _value => super._value as _data;

  @override
  $Res call({
    Object? todoInfo = freezed,
  }) {
    return _then(_data(
      todoInfo == freezed
          ? _value.todoInfo
          : todoInfo // ignore: cast_nullable_to_non_nullable
              as List<TodoInfo>,
    ));
  }
}

/// @nodoc

class _$_data implements _data {
  const _$_data(this.todoInfo);

  @override
  final List<TodoInfo> todoInfo;

  @override
  String toString() {
    return 'TodoState.data(todoInfo: $todoInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _data &&
            const DeepCollectionEquality().equals(other.todoInfo, todoInfo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(todoInfo));

  @JsonKey(ignore: true)
  @override
  _$dataCopyWith<_data> get copyWith =>
      __$dataCopyWithImpl<_data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TodoInfo> todoInfo) data,
    required TResult Function(String message) error,
  }) {
    return data(todoInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
  }) {
    return data?.call(todoInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(todoInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_loading value) loading,
    required TResult Function(_data value) data,
    required TResult Function(_error value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _data implements TodoState {
  const factory _data(List<TodoInfo> todoInfo) = _$_data;

  List<TodoInfo> get todoInfo;
  @JsonKey(ignore: true)
  _$dataCopyWith<_data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$errorCopyWith<$Res> {
  factory _$errorCopyWith(_error value, $Res Function(_error) then) =
      __$errorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$errorCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$errorCopyWith<$Res> {
  __$errorCopyWithImpl(_error _value, $Res Function(_error) _then)
      : super(_value, (v) => _then(v as _error));

  @override
  _error get _value => super._value as _error;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_error(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_error implements _error {
  const _$_error(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TodoState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _error &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$errorCopyWith<_error> get copyWith =>
      __$errorCopyWithImpl<_error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TodoInfo> todoInfo) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TodoInfo> todoInfo)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_loading value) loading,
    required TResult Function(_data value) data,
    required TResult Function(_error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_loading value)? loading,
    TResult Function(_data value)? data,
    TResult Function(_error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _error implements TodoState {
  const factory _error(String message) = _$_error;

  String get message;
  @JsonKey(ignore: true)
  _$errorCopyWith<_error> get copyWith => throw _privateConstructorUsedError;
}
