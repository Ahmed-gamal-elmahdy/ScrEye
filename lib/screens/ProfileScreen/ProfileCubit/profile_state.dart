part of 'profile_cubit.dart';

@immutable
@immutable
abstract class ProfileState {
  final String name;
  final String email;
  final String password;
  final int age;
  final String gender;

  factory ProfileState.loading() {
    return ProfileLoading();
  }

  const ProfileState({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? password,
    int? age,
    String? gender,
  });
}

class ProfileLoading extends ProfileState {
  const ProfileLoading()
      : super(name: '', email: '', password: '', age: 0, gender: '');

  @override
  ProfileState copyWith(
      {String? name,
      String? email,
      String? password,
      int? age,
      String? gender}) {
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
  }) : super(
          name: name,
          email: email,
          password: password,
          age: age,
          gender: gender,
        );

  @override
  ProfileLoaded copyWith({
    String? name,
    String? email,
    String? password,
    int? age,
    String? gender,
  }) {
    return ProfileLoaded(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }
}

class ProfileSaved extends ProfileState {
  ProfileSaved(
      {super.name = "",
      super.email = "",
      super.password = "",
      super.age = 0,
      super.gender = ""});

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
