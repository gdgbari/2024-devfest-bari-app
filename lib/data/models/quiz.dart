import 'dart:convert';

import 'package:devfest_bari_2025/data/models.dart';
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String quizId;
  final String title;
  final String type;
  final List<Question> questionList;
  final Duration timerDuration;

  const Quiz({
    this.quizId = '',
    this.title = 'Quiz',
    this.type = '',
    this.questionList = const [],
    this.timerDuration = const Duration(seconds: 0),
  });

  Quiz copyWith({
    String? quizId,
    String? title,
    String? type,
    int? maxScore,
    List<Question>? questionList,
    Duration? timerDuration,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      type: type ?? this.type,
      questionList: questionList ?? this.questionList,
      timerDuration: timerDuration ?? this.timerDuration,
    );
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      quizId: map['quizId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      type: map['type'] as String? ?? '',
      questionList: List<Question>.from(
        List<Map<String, dynamic>>.from(
          map['questionList'] ?? [],
        ).map((x) => Question.fromMap(x)),
      ),
      timerDuration: Duration(
        milliseconds: (map['timerDuration'] as int?) ?? 0,
      ),
    );
  }

  factory Quiz.fromJson(String source) =>
      Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      quizId,
      title,
      type,
      questionList,
      timerDuration,
    ];
  }
}
