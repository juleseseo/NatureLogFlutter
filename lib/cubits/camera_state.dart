part of 'camera_cubit.dart';

abstract class CameraState {}

class CameraInitial extends CameraState {}
class CameraLoading extends CameraState {}
class CameraSuccess extends CameraState {
  final String result;
  CameraSuccess(this.result);
}
class CameraError extends CameraState {
  final String message;
  CameraError(this.message);
}