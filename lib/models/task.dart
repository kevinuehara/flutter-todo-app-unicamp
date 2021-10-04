import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final bool done;

  const Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.createdAt,
    required this.done,
  });
}