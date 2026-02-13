import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';

class NameState {
  final UserModel? user;
  final bool isSaved;

  NameState({this.user, this.isSaved = false});

  NameState copyWith({UserModel? user, bool? isSaved}) {
    return NameState(user: user ?? this.user, isSaved: isSaved ?? this.isSaved);
  }
}

class NameCubit extends Cubit<NameState> {
  final VoteRepository _repository;

  NameCubit(this._repository) : super(NameState());

  /// Save name to Firestore under [sessionId] and emit new state.
  /// Returns the created UserModel.
  Future<UserModel> saveName(String name, String sessionId) async {
    final newUser = UserModel(id: Uuid().v4(), name: name);
    await _repository.saveUserName(
      sessionId: sessionId,
      userId: newUser.id,
      userName: newUser.name,
    );
    emit(state.copyWith(user: newUser, isSaved: true));
    return newUser;
  }

  void clearName() {
    emit(state.copyWith(user: null, isSaved: false));
  }
}
