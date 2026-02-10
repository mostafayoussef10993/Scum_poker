import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/bloc/result_cubit.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/widgets/clear_button.dart';
import 'package:scum_poker/app/widgets/clear_votes_button.dart';
import 'package:scum_poker/app/widgets/vote_button.dart';
import 'package:scum_poker/app/widgets/user_vote_tile.dart';
import 'package:scum_poker/app/widgets/reveal_button.dart';
class VoteScreen extends StatefulWidget {
  final String sessionId;
  final String userId;
  const VoteScreen({Key? key, required this.sessionId, required this.userId})
      : super(key: key);

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  bool _revealed = false;

  void _toggleReveal() => setState(() => _revealed = !_revealed);

  @override
  Widget build(BuildContext context) {
    registerResultCubit(widget.sessionId, widget.userId);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<VoteCubit>()),
        BlocProvider(create: (_) => getIt<ResultCubit>()..loadResults()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image
              Center(child: Image.asset(ImageAssets.poker, height: 200)),
              SizedBox(height: 16),

              // Select your vote title
              Center(
                child: Text(
                  'Select your vote',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 16),

              // Voting buttons grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: ImageAssets.allVotes.length,
                itemBuilder: (context, index) {
                  final voteValues = ImageAssets.voteValues;
                  final int value = voteValues.length > index
                      ? voteValues[index]
                      : index + 1;

                  return VoteButton(
                    assetPath: ImageAssets.allVotes[index],
                    value: value,
                    sessionId: widget.sessionId,
                    userId: widget.userId,
                  );
                },
              ),
              SizedBox(height: 32),

              // All Votes Title with reveal button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Votes in Session:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  RevealButton(revealed: _revealed, onToggle: _toggleReveal),
                ],
              ),
              SizedBox(height: 12),

              // All users list with votes
              BlocBuilder<ResultCubit, ResultState>(
                builder: (context, state) {
                  if (state is ResultLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ResultError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }

                  if (state is ResultLoaded) {
                    return StreamBuilder(
                      stream: state.sessionVotesStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No votes yet'));
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return UserVoteTile(
                              userDoc: snapshot.data!.docs[index],
                              showVote: _revealed,
                            );
                          },
                        );
                      },
                    );
                  }

                  return Center(child: Text('Unknown state'));
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClearSessionButton(sessionId: widget.sessionId),
                  SizedBox(width: 20),
                  ClearVotesButton(sessionId: widget.sessionId),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
}
