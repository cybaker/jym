import 'package:json_annotation/json_annotation.dart';

import 'Exercise.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Workout.g.dart';

// An Workout is a group of exercises to perform
@JsonSerializable(explicitToJson: true)
class Workout {
  String startTime;
  String endTime;
  List<Exercise> exercises;

  Workout({
    required this.startTime,
    required this.endTime,
    required this.exercises,
  });

  Workout fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);

  Map<String, dynamic> toJson(Workout instance) => _$WorkoutToJson(this);
}
