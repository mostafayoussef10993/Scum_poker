/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/voting_cubit.dart';
import '../../bloc/user_cubit.dart';
import '../../data/session_repository.dart';

class VotingScreen extends StatefulWidget {
  final String sessionId;
  const VotingScreen({Key? key, this.sessionId = 'session_1'})
    : super(key: key);

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  late final VotingCubit _votingCubit;
  final List<int> _cards = [0, 1, 2, 3, 5, 8, 13];

  @override
  void initState() {
    super.initState();
    _votingCubit = VotingCubit(SessionRepository());
    _votingCubit.listen(widget.sessionId);
  }

  @override
  void dispose() {
    _votingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserCubit>().state;
    final userName = userState.userName ?? 'Anonymous';
    final userId = userName; // Simple id for demo; in prod use UUID

    return BlocProvider.value(
      value: _votingCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voting — ${widget.sessionId}'),
          actions: [
            BlocBuilder<VotingCubit, VotingState>(
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Reset votes',
                      icon: const Icon(Icons.restart_alt),
                      onPressed: state.loading
                          ? null
                          : () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Reset votes?'),
                                  content: const Text(
                                    'This will delete all votes for this session. Continue?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: const Text('Reset'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed == true) {
                                await context.read<VotingCubit>().resetVotes();
                                if (!mounted) return;
                                final err = context
                                    .read<VotingCubit>()
                                    .state
                                    .error;
                                if (err != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Reset failed: $err'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Votes reset'),
                                    ),
                                  );
                                }
                              }
                            },
                    ),
                    IconButton(
                      icon: Icon(
                        state.reveal ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        context.read<VotingCubit>().toggleReveal(!state.reveal);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _cards.map((c) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () => _votingCubit.submitVote(
                    widget.sessionId,
                    userId,
                    userName,
                    c,
                  ),
                  child: Text('$c', style: const TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Expanded(
              child: BlocBuilder<VotingCubit, VotingState>(
                builder: (context, state) {
                  final entries = state.votes.values.toList();
                  if (state.loading && entries.isEmpty)
                    return const Center(child: CircularProgressIndicator());
                  if (entries.isEmpty)
                    return const Center(child: Text('No votes yet'));
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final v = entries[index];
                      final display = state.reveal
                          ? (v.value?.toString() ?? '-')
                          : (v.value != null ? 'Voted' : 'No vote');
                      return ListTile(
                        title: Text(v.name),
                        trailing: Text(display),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
