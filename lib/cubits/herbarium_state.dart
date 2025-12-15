part of 'herbarium_cubit.dart';

abstract class HerbariumState {}

class HerbariumInitial extends HerbariumState {}

class HerbariumLoading extends HerbariumState {}

class HerbariumSuccess extends HerbariumState {
  final List<FloraSnap> plants;
  HerbariumSuccess(this.plants);
}

class HerbariumError extends HerbariumState {
  final String message;
  HerbariumError(this.message);
}
