part of 'detail_mentor_cubit.dart';

enum ProductStatus { initial, loaded, error }

class DetailMentorState extends Equatable {
  final ProductStatus statusProduct;
  final List<Product> product;
  final CustomError error;
  const DetailMentorState({
    required this.statusProduct,
    required this.product,
    required this.error,
  });

  factory DetailMentorState.initial() {
    return const DetailMentorState(
      statusProduct: ProductStatus.initial,
      product: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [statusProduct, product, error];

  @override
  String toString() =>
      'DetailMentorState(statusProduct:$statusProduct,product:$product,error:$error)';

  DetailMentorState copyWith({
    ProductStatus? statusProduct,
    List<Product>? product,
    CustomError? error,
  }) {
    return DetailMentorState(
      statusProduct: statusProduct ?? this.statusProduct,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }
}
