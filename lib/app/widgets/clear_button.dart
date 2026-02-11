import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scum_poker/app/bloc/result_cubit.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';
import 'package:scum_poker/app/presentations/name/name_screen.dart';
import 'package:quickalert/quickalert.dart';

class ClearSessionButton extends StatelessWidget {
  final String sessionId;
  const ClearSessionButton({Key? key, required this.sessionId})
    : super(key: key);

  Future<void> _confirm(BuildContext c) async {
    QuickAlert.show(
      context: c,
      type: QuickAlertType.confirm,
      title: 'Clear session',
      text: 'Delete all data for this session? This cannot be undone.',
      confirmBtnText: 'Delete',
      cancelBtnText: 'Cancel',
      confirmBtnColor: Colors.red,
      onConfirmBtnTap: () async {
        Navigator.of(c).pop(); // Close the confirm dialog

        // Show loading dialog
        showDialog(
          context: c,
          barrierDismissible: false,
          builder: (_) => Center(child: CircularProgressIndicator()),
        );

        try {
          await getIt<VoteRepository>().deleteSession(sessionId);

          // Unregister cubits
          if (getIt.isRegistered<ResultCubit>())
            getIt.unregister<ResultCubit>();
          if (getIt.isRegistered<VoteCubit>()) getIt.unregister<VoteCubit>();

          Navigator.of(c).pop(); // Close loading

          // Show success alert
          await QuickAlert.show(
            context: c,
            type: QuickAlertType.success,
            title: 'Success!',
            text: 'Session cleared successfully',
            autoCloseDuration: Duration(seconds: 2),
          );

          // Navigate to name screen
          Navigator.of(c).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => NameScreen()),
            (route) => false,
          );
        } catch (e) {
          Navigator.of(c).pop(); // Close loading

          // Show error alert
          QuickAlert.show(
            context: c,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Failed to clear session: $e',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () => _confirm(context),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: SvgPicture.asset(ImageAssets.clearButton, fit: BoxFit.cover),
      ),
    );
  }
}
