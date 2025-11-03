import 'dart:convert';

import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String questionId;
  final String text;
  final List<Answer> answerList;

  const Question({
    this.questionId = '',
    this.text = '',
    this.answerList = const [],
  });

  Question copyWith({
    String? questionId,
    String? text,
    List<Answer>? answerList,
  }) {
    return Question(
      questionId: questionId ?? this.questionId,
      text: text ?? this.text,
      answerList: answerList ?? this.answerList,
    );
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] as String? ?? '',
      text: map['text'] as String? ?? '',
      answerList: List<Answer>.from(
        (map['answerList'] ?? []).map(
          (x) => Answer.fromMap(x),
        ),
      ),
    );
  }

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [questionId, text, answerList];
}
