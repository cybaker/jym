// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      muscleGroup: json['muscleGroup'] as String,
      movement: json['movement'] as String,
      sets: json['sets'] as int,
      repsPerSet: json['repsPerSet'] as int,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'muscleGroup': instance.muscleGroup,
      'movement': instance.movement,
      'sets': instance.sets,
      'repsPerSet': instance.repsPerSet,
      'notes': instance.notes,
    };
