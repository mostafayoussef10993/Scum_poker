import 'package:flutter/material.dart';
import 'package:scum_poker/app/models/session_model.dart';
import 'package:scum_poker/app/widgets/add_session_button.dart';

class DropListSession extends StatelessWidget {
  final SessionModel? selectedSession;
  final List<SessionModel> sessionList;
  final ValueChanged<SessionModel?> onChanged;
  final ValueChanged<SessionModel>? onSessionAdded;

  const DropListSession({
    Key? key,
    required this.selectedSession,
    required this.sessionList,
    required this.onChanged,
    this.onSessionAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<SessionModel>(
            isExpanded: true,
            value: selectedSession,
            hint: Text(
              "Select a room",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            items: sessionList.map((session) {
              return DropdownMenuItem<SessionModel>(
                value: session,
                child: Text(session.name),
              );
            }).toList(),
            onChanged: onChanged, // calls back to parent
          ),
        ),
        SizedBox(width: 8),
        AddSessionButton(
          onCreated: (newSession) {
            if (onSessionAdded != null) onSessionAdded!(newSession);
          },
        ),
      ],
    );
  }
}
