/*
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/session_repository.dart';
import '../models/vote.dart';

class VotingState extends Equatable {
  final Map<String, Vote> votes; // userId -> Vote
  final bool reveal;
  final bool loading;
  final String? error;

  const VotingState({
    required this.votes,
    this.reveal = false,
    this.loading = false,
    this.error,
  });

  VotingState copyWith({
    Map<String, Vote>? votes,
    bool? reveal,
    bool? loading,
    String? error,
  }) {
    return VotingState(
      votes: votes ?? this.votes,
      reveal: reveal ?? this.reveal,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [votes, reveal, loading, error];
}

class VotingCubit extends Cubit<VotingState> {
  final SessionRepository _repo;
  StreamSubscription<Map<String, Vote>>? _votesSub;
  StreamSubscription? _sessionSub;
  String? _currentSessionId;

  VotingCubit(this._repo) : super(const VotingState(votes: {}));

  Future<void> listen(String sessionId) async {
    _currentSessionId = sessionId;
    emit(state.copyWith(loading: true));
    await _repo.createSessionIfNotExists(sessionId);

    _votesSub = _repo.votesStream(sessionId).listen(
      (map) {
        emit(state.copyWith(votes: map, loading: false));
      },
      onError: (e) => emit(state.copyWith(error: e.toString(), loading: false)),
    );

    _sessionSub = _repo.sessionStream(sessionId).listen((session) {
      emit(state.copyWith(reveal: session.reveal));
    }, onError: (e) => emit(state.copyWith(error: e.toString())));
  }

  Future<void> submitVote(
    String sessionId,
    String userId,
    String name,
    int? value,
  ) {
    return _repo.submitVote(sessionId, userId, name, value);
  }

  Future<void> toggleReveal(bool show) {
    if (_currentSessionId == null) return Future.value();
    return _repo.setReveal(_currentSessionId!, show);
  }

  Future<void> resetVotes() async {
    if (_currentSessionId == null) return;
    emit(state.copyWith(loading: true, error: null));
    try {
      await _repo.resetVotes(_currentSessionId!);
      // Clear votes locally until stream updates
      emit(state.copyWith(loading: false, votes: {}));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  @override
  Future<void> close() {
    _votesSub?.cancel();
    _sessionSub?.cancel();
    return super.close();
  }
}
*/
