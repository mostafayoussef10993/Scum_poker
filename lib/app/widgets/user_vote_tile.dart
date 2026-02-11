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
          return ListTile(title: Text(userName), trailing: Text('Loading...'));
        }

        final voteDocs = votesSnapshot.data!.docs;
        final latestVote = voteDocs.isNotEmpty
            ? voteDocs.first.get('value')
            : 'No vote';

        return ListTile(
          title: Row(
            children: [
              Icon(Icons.person, color: Colors.grey[700], size: 20),
              SizedBox(width: 8),
              Text(userName, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 50, // Fixed width for 2 digits
                height: 50, // Fixed height
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  // Center the content
                  child: (latestVote == 666 || latestVote == '666')
                      ? Icon(Icons.local_cafe, color: Colors.blue, size: 22)
                      : Text(
                          '$latestVote',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
