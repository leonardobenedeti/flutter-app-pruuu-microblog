import 'dart:async';

import 'package:Pruuu/features/pruuu/repository/pruuu.repository.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pruuuit_event.dart';
part 'pruuuit_state.dart';

class PruuuitBloc extends Bloc<PruuuitEvent, PruuuitState> {
  PruuuitBloc() : super(PruuuitInitial());

  var pruuuRepository = new PruuuRepository();

  @override
  Stream<PruuuitState> mapEventToState(
    PruuuitEvent event,
  ) async* {
    if (event is Pruuublish) {
      yield PruuuitLoading();
      bool result = await pruuuRepository.pruuublish(event.pruuu);
      yield result ? PruuuitPublished() : PruuuitError();
    }
  }
}
