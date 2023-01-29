part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object?> get props => [];
}

class GetTeacherByIDEvent extends DetailEvent {
  final String? id;
  const GetTeacherByIDEvent({this.id});

  @override
  List<Object?> get props => [id];
}

class GetListVideoByIDEvent extends DetailEvent {
  final String userID;
  final Product product;

  const GetListVideoByIDEvent({
    required this.userID,
    required this.product,
  });

  @override
  List<Object?> get props => [userID, product];
}

class UpdateVideoProgressEvent extends DetailEvent {
  final VideoProgress? videoProgress;
  final String? userID;
  final String? productID;

  const UpdateVideoProgressEvent({
    required this.videoProgress,
    required this.userID,
    required this.productID,
  });

  @override
  List<Object?> get props => [videoProgress, userID, productID];
}
