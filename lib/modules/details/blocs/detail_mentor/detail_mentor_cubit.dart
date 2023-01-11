import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'detail_mentor_state.dart';

class DetailMentorCubit extends Cubit<DetailMentorState> {
  final AppBase appBase;

  DetailMentorCubit({
    required this.appBase,
  }) : super(DetailMentorState.initial());

  Future<void> getListProductByTeacherID({required String id}) async {
    emit(state.copyWith(statusProduct: ProductStatus.initial));

    try {
      final listProduct = await appBase.getListProductByID(
        id: id,
        field: 'course_teacher_id',
        limit: 100,
      );
      emit(state.copyWith(
          statusProduct: ProductStatus.loaded, product: listProduct));
    } on CustomError catch (e) {
      emit(state.copyWith(statusProduct: ProductStatus.error, error: e));
    }
  }
}
