import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/widgets/vote_button.dart';

class VoteScreen extends StatelessWidget {
  final String sessionId;
  final String userId;
  const VoteScreen({Key? key, required this.sessionId, required this.userId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VoteCubit>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(ImageAssets.poker, height: 300),

              Text(
                'Select your vote',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
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
                      sessionId: sessionId,
                      userId: userId,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
