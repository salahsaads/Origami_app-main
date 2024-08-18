import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(HomeState(selectedIndex: 0));

  void selectPage(int index) {
    emit(HomeState(selectedIndex: index));
  }
}
