// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_bloc_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LoadStateStatusMatch on LoadStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() error,
      required T Function() success}) {
    final v = this;
    if (v == LoadStateStatus.initial) {
      return initial();
    }

    if (v == LoadStateStatus.loading) {
      return loading();
    }

    if (v == LoadStateStatus.error) {
      return error();
    }

    if (v == LoadStateStatus.success) {
      return success();
    }

    throw Exception('LoadStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? error,
      T Function()? success}) {
    final v = this;
    if (v == LoadStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == LoadStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == LoadStateStatus.error && error != null) {
      return error();
    }

    if (v == LoadStateStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
