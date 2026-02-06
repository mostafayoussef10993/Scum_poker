import 'package:flutter/material.dart';
import 'package:scum_poker/app/models/session_model.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/widgets/drop_list_session.dart';
import 'package:scum_poker/app/widgets/subit_name_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController myController = TextEditingController();
  SessionModel? selectedSession;
  final List<SessionModel> sessionList = [
    SessionModel(id: '1', name: 'Session 1', createdAt: DateTime.now()),
    SessionModel(id: '2', name: 'Session 2', createdAt: DateTime.now()),
  ];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.avatar,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            Text(
              'Enter your name',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
            TextField(controller: myController),
            SizedBox(height: 20),
            SubmitNameButton(
              controller: myController,
              selectedSession: selectedSession,
            ),
            SizedBox(height: 20),
            DropListSession(
              selectedSession: selectedSession,
              sessionList: sessionList,
              onChanged: (value) {
                setState(() {
                  selectedSession = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
