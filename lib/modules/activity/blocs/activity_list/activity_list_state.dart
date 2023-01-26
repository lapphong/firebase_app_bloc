part of 'activity_list_cubit.dart';

enum ActivityStateStatus { initial, loaded, error }

class ActivityListState extends Equatable {
  final ActivityStateStatus activityStateStatus;
  final List<Product> list;
  final List<double> progressCourse;
  final double totalProgress;
  final List<double> timeLearned;
  final CustomError error;

  const ActivityListState({
    required this.activityStateStatus,
    required this.list,
    required this.progressCourse,
    required this.totalProgress,
    required this.timeLearned,
    required this.error,
  });

  factory ActivityListState.initial() {
    return const ActivityListState(
      activityStateStatus: ActivityStateStatus.initial,
      list: [],
      progressCourse: [],
      totalProgress: 0.0,
      timeLearned: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [
        activityStateStatus,
        list,
        progressCourse,
        totalProgress,
        timeLearned,
        error
      ];

  @override
  String toString() {
    return 'ActivityListState(activityStateStatus:$activityStateStatus,list:$list,progressCourse:$progressCourse,totalProgress:$totalProgress,timeLearned:$timeLearned,error:$error)';
  }

  ActivityListState copyWith({
    ActivityStateStatus? activityStateStatus,
    List<Product>? list,
    List<double>? progressCourse,
    double? totalProgress,
    List<double>? timeLearned,
    CustomError? error,
  }) {
    return ActivityListState(
      activityStateStatus: activityStateStatus ?? this.activityStateStatus,
      list: list ?? this.list,
      progressCourse: progressCourse ?? this.progressCourse,
      totalProgress: totalProgress ?? this.totalProgress,
      timeLearned: timeLearned ?? this.timeLearned,
      error: error ?? this.error,
    );
  }
}
