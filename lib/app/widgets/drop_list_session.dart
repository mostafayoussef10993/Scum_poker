import 'package:flutter/material.dart';
import 'package:scum_poker/app/models/session_model.dart';

class DropListSession extends StatelessWidget {
  final SessionModel? selectedSession;
  final List<SessionModel> sessionList;
  final ValueChanged<SessionModel?> onChanged;

  const DropListSession({
    Key? key,
    required this.selectedSession,
    required this.sessionList,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SessionModel>(
      value: selectedSession,
      hint: Text(
        "Select a session",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      items: sessionList.map((session) {
        return DropdownMenuItem<SessionModel>(
          value: session,
          child: Text(session.name),
        );
      }).toList(),
      onChanged: onChanged, // ✅ calls back to parent
    );
  }
}
