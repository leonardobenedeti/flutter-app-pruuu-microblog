// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RemoteConfigStore on _RemoteConfigStore, Store {
  final _$disclaimerOnAtom = Atom(name: '_RemoteConfigStore.disclaimerOn');

  @override
  bool get disclaimerOn {
    _$disclaimerOnAtom.reportRead();
    return super.disclaimerOn;
  }

  @override
  set disclaimerOn(bool value) {
    _$disclaimerOnAtom.reportWrite(value, super.disclaimerOn, () {
      super.disclaimerOn = value;
    });
  }

  final _$switchDisclaimerAsyncAction =
      AsyncAction('_RemoteConfigStore.switchDisclaimer');

  @override
  Future<RemoteConfig> switchDisclaimer() {
    return _$switchDisclaimerAsyncAction.run(() => super.switchDisclaimer());
  }

  @override
  String toString() {
    return '''
disclaimerOn: ${disclaimerOn}
    ''';
  }
}
