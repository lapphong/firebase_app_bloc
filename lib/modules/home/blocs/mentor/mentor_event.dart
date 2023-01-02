part of 'mentor_bloc.dart';

abstract class MentorEvent extends Equatable {
  const MentorEvent();

  @override
  List<Object> get props => [];
}

class GetListBestMentorEvent extends MentorEvent {}

class LoadMoreBestMentorEvent extends MentorEvent {}
