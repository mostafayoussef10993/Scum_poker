import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/models/user_model.dart';

class NameState {
  final UserModel? user;
  final bool isSaved;

  NameState({this.user, this.isSaved = false});

  NameState copyWith({UserModel? user, bool? isSaved}) {
    return NameState(user: user ?? this.user, isSaved: isSaved ?? this.isSaved);
  }
}

class NameCubit extends Cubit<NameState> {
  NameCubit() : super(NameState());
  void saveName(String name) {
    final newUser = UserModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
    );
    emit(state.copyWith(user: newUser, isSaved: true));
    print("Saved user: id=${newUser.id}, name=${newUser.name}");
  }

  void clearName() {
    emit(state.copyWith(user: null, isSaved: false));
  }
}
