import 'package:devfest_bari_2025/data.dart';

class QuizRepository {
  QuizRepository._internal();

  static final QuizRepository _instance = QuizRepository._internal();

  factory QuizRepository() => _instance;

  final QuizApi _quizApi = QuizApi();

  Future<Quiz> getQuiz(String quizCode) async {
    final response = await _quizApi.getQuiz(quizCode);

    if (response.error.code.isNotEmpty) {
      _quizErrorHandling(response.error.code);
    }

    return Quiz.fromJson(response.data);
  }

  Future<QuizResults> submitQuiz(
    String quizId,
    List<String?> answerList,
  ) async {
    final response = await _quizApi.submitQuiz(quizId, answerList);

    if (response.error.code.isNotEmpty) {
      _quizErrorHandling(response.error.code);
    }

    return QuizResults.fromJson(response.data);
  }
}

void _quizErrorHandling(String errorCode) {
  switch (errorCode) {
    case 'invalid-quiz-code':
      throw QuizInvalidCode();
    case 'quiz-not-found':
      throw QuizNotFoundError();
    case 'quiz-not-open':
      throw QuizNotOpenError();
    case 'quiz-time-up':
      throw QuizTimeIsUpError();
    case 'quiz-already-submitted':
      throw QuizAlreadySubmittedError();
    default:
      throw UnknownQuizError();
  }
}
