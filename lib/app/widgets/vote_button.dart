import 'package:flutter/material.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';

class VoteButton extends StatelessWidget {
  final String assetPath;
  final int value;
  final double size;
  final String sessionId;
  final String userId;
  const VoteButton({
    Key? key,
    required this.assetPath,
    required this.value,
    this.size = 60.0,
    required this.sessionId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<VoteCubit>().submitVote(value);

        print('Vote submitted: $value');
      },
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
