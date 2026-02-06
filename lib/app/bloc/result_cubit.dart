import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';

// States
abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final DocumentSnapshot userDoc;
  final Stream<QuerySnapshot> sessionVotesStream;

  ResultLoaded({required this.userDoc, required this.sessionVotesStream});
}

class ResultError extends ResultState {
  final String message;
  ResultError(this.message);
}

// Cubit
class ResultCubit extends Cubit<ResultState> {
  final VoteRepository _repository;
  final String sessionId;
  final String userId;

  ResultCubit(this._repository, {required this.sessionId, required this.userId})
    : super(ResultInitial());

  Future<void> loadResults() async {
    try {
      emit(ResultLoading());

      final userDoc = await FirebaseFirestore.instance
          .collection('sessions')
          .doc(sessionId)
          .collection('users')
          .doc(userId)
          .get();

      final sessionVotesStream = _repository.getSessionVotes(
        sessionId: sessionId,
      );

      emit(
        ResultLoaded(userDoc: userDoc, sessionVotesStream: sessionVotesStream),
      );
    } catch (e) {
      emit(ResultError('Error loading results: $e'));
    }
  }
}
