import 'dart:io';
import 'package:bloc/bloc.dart';
import '../repository/plant_repository.dart';

part  'camera_state.dart';
class CameraCubit extends Cubit<CameraState> {
  final PlantRepository repository;

  CameraCubit(this.repository) : super(CameraInitial());

  Future<void> sendImage(File image) async {
    try {
      emit(CameraLoading());
      final result = await repository.identifyPlant(image);
      emit(CameraSuccess(result));
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }
}
