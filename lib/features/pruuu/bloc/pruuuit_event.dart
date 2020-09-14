part of 'pruuuit_bloc.dart';

@immutable
abstract class PruuuitEvent {}

class Pruuublish extends PruuuitEvent {
  Pruuu pruuu;

  Pruuublish({
    @required this.pruuu,
  });
}
