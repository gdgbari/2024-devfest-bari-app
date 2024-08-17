import 'package:devfest_bari_2024/data.dart';

class QuizRepository {
  QuizRepository._internal();

  static final QuizRepository _instance = QuizRepository._internal();

  factory QuizRepository() => _instance;

  final QuizApi _quizApi = QuizApi();

  Future<Quiz> getQuiz(String quizId) async {
    try {
      final jsonQuiz = await _quizApi.getQuiz(quizId);
      return Quiz.fromJson(jsonQuiz);
    } catch (e) {
      rethrow;
    }
  }

  Future<QuizResults> submitQuiz(String quizId, List<int?> answerList) async {
    try {
      final jsonQuizResults = await _quizApi.submitQuiz(quizId, answerList);
      return QuizResults.fromJson(jsonQuizResults);
    } catch (e) {
      rethrow;
    }
  }
}
