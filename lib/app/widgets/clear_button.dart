import 'package:flutter/material.dart';
import 'package:scum_poker/app/bloc/result_cubit.dart';
import 'package:scum_poker/app/bloc/vote_cubit.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';
import 'package:scum_poker/app/presentations/name/name_screen.dart';

class ClearSessionButton extends StatelessWidget {
  final String sessionId;
  const ClearSessionButton({Key? key, required this.sessionId})
    : super(key: key);

  Future<bool?> _confirm(BuildContext c) {
    return showDialog<bool>(
      context: c,
      builder: (ctx) => AlertDialog(
        title: Text('Clear session'),
        content: Text(
          'Delete all data for this session? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
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
      onPressed: () async {
        final ok = await _confirm(context);
        if (ok != true) return;

        // loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(child: CircularProgressIndicator()),
        );

        try {
          await getIt<VoteRepository>().deleteSession(sessionId);
          // optional: (ai method) unregister cubits tied to this session
          if (getIt.isRegistered<ResultCubit>())
            getIt.unregister<ResultCubit>();
          if (getIt.isRegistered<VoteCubit>()) getIt.unregister<VoteCubit>();

          Navigator.of(context).pop(); // close loading
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => NameScreen()),
            (route) => false,
          );
        } catch (e) {
          Navigator.of(context).pop(); // close loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to clear session: $e')),
          );
        }
      },
      child: Ink.image(
        image: Image.asset(ImageAssets.clearButton).image,
        height: 80,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
