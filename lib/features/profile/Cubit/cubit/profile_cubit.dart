import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origami/features/profile/data/network.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  ProfileModel? profileModel1;
  getdata(String number) async {
    emit(ProfileLoading());
    try {
      ProfileModel profileModel = await FirbaseGet.getData(number);
      profileModel1 = profileModel;
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError());
    }
  }
}
