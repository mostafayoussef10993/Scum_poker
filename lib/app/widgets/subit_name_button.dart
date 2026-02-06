import 'package:flutter/material.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';
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
        String userId = DateTime.now().millisecondsSinceEpoch.toString();

        await getIt<VoteRepository>().saveUserName(
          sessionId: selectedSession!.id,
          userId: userId,
          userName: controller.text,
        );
        registerVoteCubit(selectedSession!.id, userId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                VoteScreen(sessionId: selectedSession!.id, userId: userId),
          ),
        );
      },
      child: Ink.image(
        image: Image.asset(ImageAssets.submitButton).image,
        height: 80,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
