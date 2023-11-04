// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MuscleGroupMovements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupMovements _$MuscleGroupMovementsFromJson(
        Map<String, dynamic> json) =>
    MuscleGroupMovements(
      muscleGroup: json['muscleGroup'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MuscleGroupMovementsToJson(
        MuscleGroupMovements instance) =>
    <String, dynamic>{
      'muscleGroup': instance.muscleGroup,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
