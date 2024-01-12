// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pruuuit_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PruuuItViewModel on _PruuuItViewModel, Store {
  late final _$pruuuItStateAtom =
      Atom(name: '_PruuuItViewModel.pruuuItState', context: context);

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

  late final _$pruuublishAsyncAction =
      AsyncAction('_PruuuItViewModel.pruuublish', context: context);

  @override
  Future<PruuuItState> pruuublish(Pruuu pruuu) {
    return _$pruuublishAsyncAction.run(() => super.pruuublish(pruuu));
  }

  late final _$removePruuuAsyncAction =
      AsyncAction('_PruuuItViewModel.removePruuu', context: context);

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
