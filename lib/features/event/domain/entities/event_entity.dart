

import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventEntity extends Equatable {
  CharacterModel? user;
  String? title;
  String? description;
  Color? statusColor;
  String? type;

  EventEntity({
    required this.user,
    required this.title,
    required this.description,
    required this.statusColor,
    required this.type,
  });
  
  @override
  List<Object?> get props => [user, title, description, statusColor, type];
}