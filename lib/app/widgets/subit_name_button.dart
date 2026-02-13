import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/bloc/user_cubit.dart';
import 'package:scum_poker/app/bloc/user_cubit.dart';
import 'package:scum_poker/app/models/session_model.dart';
import 'package:scum_poker/app/presentations/vote/vote_screen.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';

class SubmitNameButton extends StatelessWidget {
  final TextEditingController controller;
  final SessionModel? selectedSession;
  const SubmitNameButton({
    Key? key,
    required this.controller,
    required this.selectedSession,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        elevation: 0,
      ),
      onPressed: () async {
        final name = controller.text.trim();
        if (name.isEmpty || selectedSession == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Name Is Not Submitted Yet')));
          return;
        }
        try {
          final newUser = await context.read<NameCubit>().saveName(
            name,
            selectedSession!.id,
          );

          registerVoteCubit(selectedSession!.id, newUser.id);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VoteScreen(
                sessionId: selectedSession!.id,
                userId: newUser.id,
              ),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to save name: $e')));
        }
      },
      child: SvgPicture.asset(
        ImageAssets.submitButton,
        height: 80,
        width: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
