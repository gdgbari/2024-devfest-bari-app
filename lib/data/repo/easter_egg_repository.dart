import 'package:devfest_bari_2025/data.dart';

class EasterEggRepository {
  EasterEggRepository._internal();

  static final EasterEggRepository _instance = EasterEggRepository._internal();

  factory EasterEggRepository() => _instance;

  final EasterEggApi _easterEggApi = EasterEggApi();

  Stream<String> easterEggStream() async* {
    await for (final event in _easterEggApi.easterEggStream) {
      final easterEggMessage = event.snapshot.value as String? ?? '';
      yield easterEggMessage.replaceAll('\\n', '\n');
    }
  }
}
