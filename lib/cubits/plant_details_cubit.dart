import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/plant_repository.dart';

part 'plant_details_state.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final PlantRepository repository;

  PlantDetailsCubit(this.repository) : super(PlantDetailsInitial());

  Future<void> fetchPlantSummary(String plantName) async {
    try {
      emit(PlantDetailsLoading());
      final summary = await repository.getPlantSummary(plantName);
      emit(PlantDetailsSuccess(summary));
    } catch (e) {
      emit(PlantDetailsError(e.toString()));
    }
  }
}
