import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/flora_snap.dart';
import '../repository/herbarium_repository.dart';

part 'herbarium_state.dart';

class HerbariumCubit extends Cubit<HerbariumState> {
  final HerbariumRepository repository;

  HerbariumCubit(this.repository) : super(HerbariumInitial());

  Future<void> loadPlants() async {
    try {
      emit(HerbariumLoading());
      final plants = await repository.getAllPlants();
      emit(HerbariumSuccess(plants));
    } catch (e) {
      emit(HerbariumError(e.toString()));
    }
  }

  Future<void> deletePlant(int id, String imagePath) async {
    try {
      await repository.deletePlant(id, imagePath);
      await loadPlants();
    } catch (e) {
      emit(HerbariumError(e.toString()));
    }
  }
}
