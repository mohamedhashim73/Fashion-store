abstract class ProfileStates{}

class ProfileInitialState extends ProfileStates{}
class GetUserDataSuccessState extends ProfileStates{}

class GetUserDataLoadingState extends ProfileStates{}

class GetUserDataErrorState extends ProfileStates{}

class UpdateUserDataSuccessState extends ProfileStates{}

class UpdateUserDataLoadingState extends ProfileStates{}

class UpdateUserDataErrorState extends ProfileStates{
  String error;
  UpdateUserDataErrorState({required this.error});
}

class LogOutLoadingState extends ProfileStates{}

class DeletedAccountSuccessfullyState extends ProfileStates{}

class ErrorDuringDeleteAccountState extends ProfileStates{}