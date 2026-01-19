part of 'camera_cubit.dart';

abstract class CameraState {}

class CameraInitial extends CameraState {}
class CameraLoading extends CameraState {}
class CameraSuccess extends CameraState {
  final String result;
  final bool isNewPlant;
  CameraSuccess(this.result, {this.isNewPlant = false});
}
class CameraError extends CameraState {
  final String message;
  CameraError(this.message);
}