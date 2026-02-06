import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserVoteTile extends StatelessWidget {
  final DocumentSnapshot userDoc;

  const UserVoteTile({Key? key, required this.userDoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = userDoc.get('name') ?? 'Unknown';
    final userId = userDoc.id;

    return StreamBuilder<QuerySnapshot>(
      stream: userDoc.reference
          .collection('votes')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, votesSnapshot) {
        if (!votesSnapshot.hasData) {
          return ListTile(
            title: Text(userName),
            subtitle: Text('User ID: $userId'),
            trailing: Text('Loading...'),
          );
        }

        final voteDocs = votesSnapshot.data!.docs;
        final latestVote = voteDocs.isNotEmpty
            ? voteDocs.first.get('value')
            : 'No vote';

        return ListTile(
          title: Text(userName, style: Theme.of(context).textTheme.bodyMedium),
          subtitle: Text('User ID: $userId'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Vote: $latestVote',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
