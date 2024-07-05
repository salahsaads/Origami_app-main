import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origami/features/Weight/data/network.dart';
import 'package:origami/features/Weight/prestion/view_model/model.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());
  int sumall = 0;
  Sum_All(int point) {
    sumall += point;
    emit(WeightInitial());
  }

  List<KhordaModel> data = [];
  GetData() async {
    emit(WeightLoading());
    try {
      data = await FirbaseData.GetData();
      emit(WeightLoaded());
    } catch (e) {
      emit(WeightError());
    }
  }
}
