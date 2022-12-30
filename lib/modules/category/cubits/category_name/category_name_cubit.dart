import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';

part 'category_name_state.dart';

class CategoryNameCubit extends Cubit<CategoryNameState> {
  final AppBase appBase;
  CategoryNameCubit({
    required this.appBase,
  }) : super(CategoryNameState.initial());

  Future<void> getAllCategoryName() async {
    final list = await appBase.getNameCategory();
    emit(state.copyWith(list: list));
  }
}
