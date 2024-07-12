import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origami/features/Weight/data/network.dart';
import 'package:origami/features/Weight/prestion/view_model/model.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());
  double sumall = 0.0;
  Sum_All(double point) {
    sumall += point*.5;
    emit(WeightInitial());
  }

  Sum_All2(double point) {
    sumall = sumall - point * .5;
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
