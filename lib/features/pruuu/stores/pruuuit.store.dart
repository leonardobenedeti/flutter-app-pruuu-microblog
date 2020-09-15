import 'package:Pruuu/features/pruuu/repository/pruuu.repository.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:mobx/mobx.dart';

part 'pruuuit.store.g.dart';

class PruuuItStore = _PruuuItStore with _$PruuuItStore;

abstract class _PruuuItStore with Store {
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
}

enum PruuuItState { initial, loading, pruuublished, error }
