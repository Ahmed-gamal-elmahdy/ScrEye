part of 'captured_cubit.dart';

class CapturedState {
  final String name;
  final int age;
  final String gender;
  final String additionalInfo;
  final String imagePath;

  CapturedState({
    this.name = '',
    this.age = 0,
    this.gender = '',
    this.additionalInfo = '',
    this.imagePath = '',
  });

  CapturedState copyWith({
    String? name,
    int? age,
    String? gender,
    String? additionalInfo,
    String? imagePath,
  }) {
    return CapturedState(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
