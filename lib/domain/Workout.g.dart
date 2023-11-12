// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
