part of 'activity_list_cubit.dart';

enum ActivityStateStatus { initial, loaded, error }

class ActivityListState extends Equatable {
  final ActivityStateStatus activityStateStatus;
  final List<Product> listInComplete;
  final List<Product> listComplete;
  final List<double> progressCourseInComplete;
  final List<double> progressCourseComplete;
  final List<double> timeLearnedInComplete;
  final List<double> timeLearnedComplete;
  final double totalProgress;
  final CustomError error;

  const ActivityListState({
    required this.activityStateStatus,
    required this.listInComplete,
    required this.listComplete,
    required this.progressCourseInComplete,
    required this.progressCourseComplete,
    required this.timeLearnedInComplete,
    required this.timeLearnedComplete,
    required this.totalProgress,
    required this.error,
  });

  factory ActivityListState.initial() {
    return const ActivityListState(
      activityStateStatus: ActivityStateStatus.initial,
      listInComplete: [],
      listComplete: [],
      progressCourseInComplete: [],
      progressCourseComplete: [],
      timeLearnedInComplete: [],
      timeLearnedComplete: [],
      totalProgress: 0.0,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [
        activityStateStatus,
        listInComplete,
        listComplete,
        progressCourseInComplete,
        progressCourseComplete,
        timeLearnedInComplete,
        timeLearnedComplete,
        totalProgress,
        error
      ];

  @override
  String toString() {
    return 'ActivityListState(activityStateStatus:$activityStateStatus,listInComplete:$listInComplete,listComplete:$listComplete,progressCourseInComplete:$progressCourseInComplete,progressCourseComplete:$progressCourseComplete,timeLearnedInComplete:$timeLearnedInComplete,timeLearnedComplete:$timeLearnedComplete,,totalProgress:$totalProgress,error:$error)';
  }

  ActivityListState copyWith({
    ActivityStateStatus? activityStateStatus,
    List<Product>? listInComplete,
    List<Product>? listComplete,
    List<double>? progressCourseInComplete,
    List<double>? progressCourseComplete,
    List<double>? timeLearnedInComplete,
    List<double>? timeLearnedComplete,
    double? totalProgress,
    CustomError? error,
  }) {
    return ActivityListState(
      activityStateStatus: activityStateStatus ?? this.activityStateStatus,
      listInComplete: listInComplete ?? this.listInComplete,
      listComplete: listComplete ?? this.listComplete,
      progressCourseInComplete:
          progressCourseInComplete ?? this.progressCourseInComplete,
      progressCourseComplete:
          progressCourseComplete ?? this.progressCourseComplete,
      timeLearnedInComplete:
          timeLearnedInComplete ?? this.timeLearnedInComplete,
      timeLearnedComplete: timeLearnedComplete ?? this.timeLearnedComplete,
      totalProgress: totalProgress ?? this.totalProgress,
      error: error ?? this.error,
    );
  }
}
