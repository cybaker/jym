import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Exercise.g.dart';

// An exercise is sets of the same movements to perform
@JsonSerializable(explicitToJson: true)
class Exercise {
  String movement;
  int sets;
  int repsPerSet;
  String notes;

  Exercise({
    required this.movement,
    required this.sets,
    required this.repsPerSet,
    required this.notes,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}