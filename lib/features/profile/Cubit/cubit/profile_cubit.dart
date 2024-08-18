import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origami/features/profile/data/network.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  ProfileModel? profileModel;
  getdata() async {
    emit(ProfileLoading());
    try {
       profileModel = await FirbaseGet.getData();
    ;
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError());
    }
  }
}
