part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
class  EditProfileLoading extends EditProfileState{}
class  EditProfileFailure extends EditProfileState{
  final String errorMessage;
  EditProfileFailure({required this.errorMessage});
}
class  EditProfileSuccess extends EditProfileState{
  final String responseBody ;

  EditProfileSuccess({required this.responseBody});
}