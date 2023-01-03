part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class GetListProductEvent extends ClassEvent {}

class LoadMoreProductEvent extends ClassEvent {}
