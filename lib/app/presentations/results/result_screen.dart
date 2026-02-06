import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/bloc/result_cubit.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/widgets/clear_button.dart';
import 'package:scum_poker/app/widgets/user_vote_tile.dart';

class ResultScreen extends StatelessWidget {
  final String sessionId;
  final String userId;
  final int votedValue;

  const ResultScreen({
    Key? key,
    required this.sessionId,
    required this.userId,
    required this.votedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Register cubit when entering screen
    registerResultCubit(sessionId, userId);

    return BlocProvider(
      create: (_) => getIt<ResultCubit>()..loadResults(),
      child: Scaffold(
        body: BlocBuilder<ResultCubit, ResultState>(
          builder: (context, state) {
            if (state is ResultLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ResultError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is ResultLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    // All Votes Title
                    Text(
                      'All Votes in Session:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    // All Users List
                    Expanded(
                      child: StreamBuilder(
                        stream: state.sessionVotesStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return UserVoteTile(
                                userDoc: snapshot.data!.docs[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 4),

                    Center(
                      child: Column(
                        children: [ClearSessionButton(sessionId: sessionId)],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}
