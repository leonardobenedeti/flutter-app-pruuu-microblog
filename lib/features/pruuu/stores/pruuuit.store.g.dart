// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pruuuit.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PruuuItStore on _PruuuItStore, Store {
  final _$pruuuItStateAtom = Atom(name: '_PruuuItStore.pruuuItState');

  @override
  PruuuItState get pruuuItState {
    _$pruuuItStateAtom.reportRead();
    return super.pruuuItState;
  }

  @override
  set pruuuItState(PruuuItState value) {
    _$pruuuItStateAtom.reportWrite(value, super.pruuuItState, () {
      super.pruuuItState = value;
    });
  }

  final _$pruuublishAsyncAction = AsyncAction('_PruuuItStore.pruuublish');

  @override
  Future<PruuuItState> pruuublish(Pruuu pruuu) {
    return _$pruuublishAsyncAction.run(() => super.pruuublish(pruuu));
  }

  final _$removePruuuAsyncAction = AsyncAction('_PruuuItStore.removePruuu');

  @override
  Future<bool> removePruuu(Pruuu pruuu) {
    return _$removePruuuAsyncAction.run(() => super.removePruuu(pruuu));
  }

  @override
  String toString() {
    return '''
pruuuItState: ${pruuuItState}
    ''';
  }
}
