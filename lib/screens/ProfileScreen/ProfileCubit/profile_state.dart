part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  final String name;
  final String email;
  final String password;
  final int age;
  final String gender;
  final bool visibility;

  factory ProfileState.loading() {
    return const ProfileLoading();
  }

  const ProfileState({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    required this.visibility,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? password,
    int? age,
    String? gender,
    bool? visibility,
  });
}

class ProfileLoading extends ProfileState {
  const ProfileLoading()
      : super(
            name: '',
            email: '',
            password: '',
            age: 0,
            gender: '',
            visibility: false);

  @override
  ProfileState copyWith(
      {String? name,
      String? email,
      String? password,
      int? age,
      String? gender,
      bool? visibility}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required String name,
    required String email,
    required String password,
    required int age,
    required String gender,
    required bool visibility,
  }) : super(
          name: name,
          email: email,
          password: password,
          age: age,
          gender: gender,
          visibility: visibility,
        );

  @override
  ProfileLoaded copyWith({
    String? name,
    String? email,
    String? password,
    int? age,
    String? gender,
    bool? visibility,
  }) {
    return ProfileLoaded(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      visibility: visibility ?? this.visibility,
    );
  }
}

class ProfileSaved extends ProfileState {
  const ProfileSaved(
      {super.name = "",
      super.email = "",
      super.password = "",
      super.age = 0,
      super.gender = "",
      super.visibility = false});

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
