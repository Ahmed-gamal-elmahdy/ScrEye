part of 'upload_cubit.dart';

abstract class UploadState {
  const UploadState();
}

class UploadInitial extends UploadState {
  const UploadInitial();
}

class UploadImageLoaded extends UploadState {
  final String imagePath;

  const UploadImageLoaded(this.imagePath);

  UploadImageLoaded copyWith({
    String? imagePath,
  }) {
    return UploadImageLoaded(
      imagePath ?? this.imagePath,
    );
  }
}

class UploadInProgress extends UploadImageLoaded {
  const UploadInProgress(String imagePath) : super(imagePath);
}
