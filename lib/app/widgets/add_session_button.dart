import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';
import 'package:scum_poker/app/models/session_model.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';

class AddSessionButton extends StatelessWidget {
  final ValueChanged<SessionModel> onCreated;
  const AddSessionButton({Key? key, required this.onCreated}) : super(key: key);

  Future<void> _showCreateDialog(BuildContext context) async {
    final controller = TextEditingController();
    String? result;

    await showCupertinoDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (c) => _CreateSessionDialog(
        controller: controller,
        onConfirm: (value) {
          result = value;
          Navigator.of(c).pop();
        },
        onCancel: () => Navigator.of(c).pop(),
      ),
    );

    if (result != null && result!.isNotEmpty) {
      try {
        final id = await getIt<VoteRepository>().createSession(name: result!);
        final session = SessionModel(
          id: id,
          name: result!,
          createdAt: DateTime.now(),
        );
        onCreated(session);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create session: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle_outline, size: 28),
      onPressed: () => _showCreateDialog(context),
      tooltip: 'Create session',
    );
  }
}

// ── Separate widget for the dialog UI ────────────────────────────────────────

class _CreateSessionDialog extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onConfirm;
  final VoidCallback onCancel;

  const _CreateSessionDialog({
    required this.controller,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildDivider(),
            _buildTextField(context),
            _buildDivider(),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        children: [
          // Icon on top
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: CupertinoColors.activeBlue.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.news_solid,
              color: CupertinoColors.activeBlue,
              size: 26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'New Room',
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Enter a name for your Room',
            style: TextStyle(
              fontSize: 13,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: CupertinoTextField(
        controller: controller,
        placeholder: 'Session name',
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.tertiarySystemFill.resolveFrom(context),
          borderRadius: BorderRadius.circular(10),
        ),
        style: const TextStyle(fontSize: 16),
        autofocus: true,
        clearButtonMode: OverlayVisibilityMode.editing,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) => onConfirm(value.trim()),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        // Cancel button
        Expanded(
          child: CupertinoButton(
            onPressed: onCancel,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        // Vertical divider between buttons
        Container(
          width: 0.5,
          height: 50,
          color: CupertinoColors.separator.resolveFrom(context),
        ),
        // Create button
        Expanded(
          child: CupertinoButton(
            onPressed: () => onConfirm(controller.text.trim()),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              'Create',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 0.5, color: CupertinoColors.separator);
  }
}
