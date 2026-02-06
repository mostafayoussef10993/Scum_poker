import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';

abstract class VoteState {}

class VoteInitial extends VoteState {}

class VoteSelected extends VoteState {
  final int voteValue;
  VoteSelected(this.voteValue);
}

class VoteSaving extends VoteState {
  final int voteValue;
  VoteSaving(this.voteValue);
}

class VoteSaved extends VoteState {
  final int voteValue;
  VoteSaved(this.voteValue);
}

class VoteError extends VoteState {
  final String message;
  final int voteValue;
  VoteError(this.message, this.voteValue);
}

class VoteCubit extends Cubit<VoteState> {
  final VoteRepository _repository;
  final String sessionId;
  final String userId;
  VoteCubit(this._repository, {required this.sessionId, required this.userId})
    : super(VoteInitial());
  Future<void> submitVote(int voteValue) async {
    emit(VoteSelected(voteValue));
    emit(VoteSaving(voteValue));

    try {
      await _repository.saveVote(
        voteValue,
        sessionId: sessionId,
        userId: userId,
      );
      emit(VoteSaved(voteValue));
    } catch (e) {
      emit(VoteError(e.toString(), voteValue));
    }
  }

  void resetVote() {
    emit(VoteInitial());
  }
}
