import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:scum_poker/app/bloc/result_cubit.dart';
import 'package:scum_poker/app/bloc/user_cubit.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<VoteRepository>(
    VoteRepository(getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<NameCubit>(NameCubit());
}

void registerVoteCubit(String sessionId, String userId) {
  if (getIt.isRegistered<VoteCubit>()) {
    getIt.unregister<VoteCubit>();
  }

  getIt.registerSingleton<VoteCubit>(
    VoteCubit(getIt<VoteRepository>(), sessionId: sessionId, userId: userId),
  );
}

void registerResultCubit(String sessionId, String userId) {
  if (getIt.isRegistered<ResultCubit>()) {
    getIt.unregister<ResultCubit>();
  }

  getIt.registerSingleton<ResultCubit>(
    ResultCubit(getIt<VoteRepository>(), sessionId: sessionId, userId: userId),
  );
}
