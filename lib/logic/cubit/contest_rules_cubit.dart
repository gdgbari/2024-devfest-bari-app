import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'contest_rules_state.dart';

class ContestRulesCubit extends Cubit<ContestRulesState> {
  final _contestRulesRepo = ContestRulesRepository();
  StreamSubscription? _streamSub;

  ContestRulesCubit() : super(ContestRulesState()) {
    fetchContestRules();
  }

  void fetchContestRules() {
    emit(state.copyWith(status: ContestRulesStatus.fetchInProgress));
    stopContestRulesFetch();

    try {
      final stream = _contestRulesRepo.contestRulesStream().asBroadcastStream();
      _streamSub = stream.listen(
        (contestRules) {
          emit(
            state.copyWith(
              status: ContestRulesStatus.fetchSuccess,
              rules: contestRules,
            ),
          );
        },
        onError: (_) {
          emit(state.copyWith(status: ContestRulesStatus.fetchFailure));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: ContestRulesStatus.fetchFailure));
    }
  }

  void stopContestRulesFetch() => _streamSub?.cancel();
}
