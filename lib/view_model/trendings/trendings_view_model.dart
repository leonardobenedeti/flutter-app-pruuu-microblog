import 'package:mobx/mobx.dart';
import 'package:pruuu/model/trending_model.dart';
import 'package:pruuu/repository/trendings_repository.dart';

part 'trendings_view_model.g.dart';

class TrendingsViewModel = _TrendingsViewModel with _$TrendingsViewModel;

abstract class _TrendingsViewModel with Store {
  @observable
  List<Trending> trendings = [];

  @action
  Future fetchTrendings() async {
    trendings = await TrendingsRepository().fetchTrendings();
  }
}
