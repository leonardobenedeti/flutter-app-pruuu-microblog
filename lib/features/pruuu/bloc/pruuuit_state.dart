part of 'pruuuit_bloc.dart';

@immutable
abstract class PruuuitState {}

class PruuuitInitial extends PruuuitState {}

class PruuuitLoading extends PruuuitState {}

class PruuuitPublished extends PruuuitState {}

class PruuuitError extends PruuuitState {}
