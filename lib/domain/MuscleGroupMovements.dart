import 'package:json_annotation/json_annotation.dart';

import 'Exercise.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'MuscleGroupMovements.g.dart';

// An Workout is a group of exercises to perform
@JsonSerializable(explicitToJson: true)
class MuscleGroupMovements {
  String muscleGroup;
  List<Exercise> exercises;

  MuscleGroupMovements({
    required this.muscleGroup,
    required this.exercises,
  });

  MuscleGroupMovements fromJson(Map<String, dynamic> json) => MuscleGroupMovements(
    muscleGroup: json['muscleGroup'] as String,
    exercises: (json['exercises'] as List<dynamic>)
        .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson(MuscleGroupMovements instance) => <String, dynamic>{
    'muscleGroup': instance.muscleGroup,
    'exercises': instance.exercises.map((e) => e.toJson()).toList(),
  };

}
