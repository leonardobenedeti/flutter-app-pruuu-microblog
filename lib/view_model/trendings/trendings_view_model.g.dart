// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrendingsViewModel on _TrendingsViewModel, Store {
  final _$trendingsAtom = Atom(name: '_TrendingsViewModel.trendings');

  @override
  List<Trending> get trendings {
    _$trendingsAtom.reportRead();
    return super.trendings;
  }

  @override
  set trendings(List<Trending> value) {
    _$trendingsAtom.reportWrite(value, super.trendings, () {
      super.trendings = value;
    });
  }

  final _$fetchTrendingsAsyncAction =
      AsyncAction('_TrendingsViewModel.fetchTrendings');

  @override
  Future fetchTrendings() {
    return _$fetchTrendingsAsyncAction.run(() => super.fetchTrendings());
  }

  @override
  String toString() {
    return '''
trendings: ${trendings}
    ''';
  }
}
