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
  final List courseVideoId;
  const GetListVideoByIDEvent({required this.courseVideoId});

  @override
  List<Object?> get props => [courseVideoId];
}
