// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TrendingsViewModel on _TrendingsViewModel, Store {
  late final _$trendingsAtom =
      Atom(name: '_TrendingsViewModel.trendings', context: context);

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

  late final _$fetchTrendingsAsyncAction =
      AsyncAction('_TrendingsViewModel.fetchTrendings', context: context);

  @override
  Future<dynamic> fetchTrendings() {
    return _$fetchTrendingsAsyncAction.run(() => super.fetchTrendings());
  }

  @override
  String toString() {
    return '''
trendings: ${trendings}
    ''';
  }
}
