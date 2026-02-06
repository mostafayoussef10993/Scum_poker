/*
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


class UserState extends Equatable {
  final String? userName;
  const UserState({this.userName});

  @override
  List<Object?> get props => [userName];
}

class UserCubit extends Cubit<UserState> {
  final TextEditingController nameController = TextEditingController();
  UserCubit() : super(const UserState());

  void saveName() {
    final name = nameController.text.trim();
    if (name.isNotEmpty) emit(UserState(userName: name));
  }

  bool get hasName => (state.userName ?? '').isNotEmpty;

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
*/
