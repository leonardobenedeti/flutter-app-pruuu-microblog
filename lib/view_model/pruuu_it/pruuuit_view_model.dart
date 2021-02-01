import 'dart:async';

import 'package:Pruuu/repository/pruuu_repository.dart';
import 'package:Pruuu/model/pruuu_model.dart';
import 'package:mobx/mobx.dart';

part 'pruuuit_view_model.g.dart';

class PruuuItViewModel = _PruuuItViewModel with _$PruuuItViewModel;

abstract class _PruuuItViewModel with Store {
  @observable
  PruuuItState pruuuItState = PruuuItState.initial;

  @action
  Future<PruuuItState> pruuublish(Pruuu pruuu) async {
    pruuuItState = PruuuItState.loading;
    try {
      bool published = await PruuuRepository().pruuublish(pruuu);
      pruuuItState = published ? PruuuItState.pruuublished : PruuuItState.error;
    } catch (e) {
      pruuuItState = PruuuItState.error;
    }
    return pruuuItState;
  }

  @action
  Future<bool> removePruuu(Pruuu pruuu) async {
    try {
      await PruuuRepository().removePruuu(pruuu);
      return true;
    } catch (e) {
      return false;
    }
  }
}

enum PruuuItState { initial, loading, pruuublished, error }
