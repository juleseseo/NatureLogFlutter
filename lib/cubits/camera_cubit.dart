import 'dart:io';
import 'package:bloc/bloc.dart';
import '../models/flora_snap.dart';
import '../repository/herbarium_repository.dart';
import '../repository/plant_repository.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  final PlantRepository repository;
  final HerbariumRepository herbariumRepository;

  CameraCubit(this.repository, this.herbariumRepository) : super(CameraInitial());

  Future<void> sendImage(File image, {double latitude = 0.0, double longitude = 0.0}) async {
    try {
      emit(CameraLoading());
      final result = await repository.identifyPlant(image);

      final exists = await herbariumRepository.plantExists(result);

      if (!exists && result != "Aucune plante reconnue" && result != "Inconnu") {
        final savedImagePath = await herbariumRepository.saveImage(image, result);

        final plant = FloraSnap(
          name: result,
          imagePath: savedImagePath,
          type: FloraType.plante,
          date: DateTime.now(),
          latitude: latitude,
          longitude: longitude,
          description: '',
        );

        await herbariumRepository.addPlant(plant);
        emit(CameraSuccess(result, isNewPlant: true));
      } else {
        emit(CameraSuccess(result, isNewPlant: false));
      }
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }
}
