/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user_cubit.dart';
import '../voting/voting_screen.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Enter name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userCubit.nameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _onContinue(context, userCubit),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _onContinue(context, userCubit),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue(BuildContext context, UserCubit userCubit) {
    final name = userCubit.nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a name')));
      return;
    }

    userCubit.saveName();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const VotingScreen()));
  }
}
*/
