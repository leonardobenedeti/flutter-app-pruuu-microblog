import 'package:Pruuu/features/feed/repository/feed.repository.dart';
import 'package:Pruuu/features/pruuu/repository/pruuu.repository.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'pruuuit.store.g.dart';

// This is the class used by rest of your codebase
class PruuuItStore = _PruuuItStore with _$PruuuItStore;

// The store-class
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
