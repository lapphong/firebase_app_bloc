import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_search_state.dart';

class CategorySearchCubit extends Cubit<CategorySearchState> {
  CategorySearchCubit() : super(CategorySearchState.initial());

  void setSearchProduct(String newSearchProduct) {
    emit(state.copyWith(searchProduct: newSearchProduct));
  }
}
