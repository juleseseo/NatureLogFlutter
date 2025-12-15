part of 'plant_details_cubit.dart';

abstract class PlantDetailsState {}

class PlantDetailsInitial extends PlantDetailsState {}

class PlantDetailsLoading extends PlantDetailsState {}

class PlantDetailsSuccess extends PlantDetailsState {
  final String summary;
  PlantDetailsSuccess(this.summary);
}

class PlantDetailsError extends PlantDetailsState {
  final String message;
  PlantDetailsError(this.message);
}
