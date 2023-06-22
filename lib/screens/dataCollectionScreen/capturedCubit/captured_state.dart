part of 'captured_cubit.dart';

class CapturedState {
  final String name;
  final int age;
  final String gender;
  final String additionalInfo;
  final String imagePath;
  final String anemic;
  final FilePickerResult files;
  final String errorMessage;

  CapturedState({
    required this.name,
    required this.age,
    required this.gender,
    required this.anemic,
    required this.additionalInfo,
    required this.imagePath,
    required this.files,
    required this.errorMessage, // Initialize the property
  });

  factory CapturedState.initial() {
    return CapturedState(
      name: '',
      age: 0,
      gender: '',
      imagePath: '',
      anemic: '',
      additionalInfo: '',
      files: FilePickerResult([]),
      errorMessage: '', // Set the initial value to an empty string
    );
  }

  CapturedState copyWith({
    String? name,
    int? age,
    String? gender,
    String? additionalInfo,
    String? imagePath,
    String? anemic,
    String? errorMessage,
    FilePickerResult? files,
  }) {
    return CapturedState(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      imagePath: imagePath ?? this.imagePath,
      anemic: anemic ?? this.anemic,
      errorMessage: errorMessage ?? this.errorMessage,
      files: files ?? this.files,
    );
  }
}
