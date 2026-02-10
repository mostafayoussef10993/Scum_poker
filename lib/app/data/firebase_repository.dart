import 'package:cloud_firestore/cloud_firestore.dart';

class VoteRepository {
  final FirebaseFirestore _firestore;
  VoteRepository(this._firestore);

  // STEP 0: Save user with their name in the session
  Future<void> saveUserName({
    required String sessionId,
    required String userId,
    required String userName,
  }) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .doc(userId)
        .set({'name': userName, 'createdAt': FieldValue.serverTimestamp()});
  }

  // STEP 1: Save vote with session and user context
  Future<void> saveVote(
    int voteValue, {
    required String sessionId,
    required String userId,
  }) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .doc(userId)
        .collection('votes')
        .add({'value': voteValue, 'timestamp': FieldValue.serverTimestamp()});
  }

  // STEP 2: Get all votes from a specific session and user
  Stream<QuerySnapshot> getVotes({
    required String sessionId,
    required String userId,
  }) {
    return _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .doc(userId)
        .collection('votes')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // STEP 3: Get all votes from a specific session (all users)
  Stream<QuerySnapshot> getSessionVotes({required String sessionId}) {
    return _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .snapshots();
  }

  // STEP 4: Get vote counts for a specific session
  Future<Map<int, int>> getVoteCounts({required String sessionId}) async {
    Map<int, int> counts = {};

    final usersSnapshot = await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .get();

    for (var userDoc in usersSnapshot.docs) {
      final votesSnapshot = await _firestore
          .collection('sessions')
          .doc(sessionId)
          .collection('users')
          .doc(userDoc.id)
          .collection('votes')
          .get();

      for (var voteDoc in votesSnapshot.docs) {
        final vote = voteDoc.data()['value'] as int;
        counts[vote] = (counts[vote] ?? 0) + 1;
      }
    }
    return counts;
  }

  // STEP 5: Get the latest vote from a specific user in a session
  Future<int?> getLatestUserVote({
    required String sessionId,
    required String userId,
  }) async {
    final snapshot = await _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('users')
        .doc(userId)
        .collection('votes')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data()['value'] as int;
    }
    return null;
  }

  // STEP 6: Clear all votes from a session (keeps users and session)
  Future<void> clearVotes(String sessionId) async {
    try {
      final usersSnap = await _firestore
          .collection('sessions')
          .doc(sessionId)
          .collection('users')
          .get();

      for (final userDoc in usersSnap.docs) {
        final votesSnap = await userDoc.reference.collection('votes').get();
        final batch = _firestore.batch();

        for (final voteDoc in votesSnap.docs) {
          batch.delete(voteDoc.reference);
        }

        await batch.commit();
      }
    } catch (e) {
      rethrow;
    }
  }

  // STEP 7: Delete a session and all its data
  Future<void> deleteSession(String sessionId) async {
    final sessionRef = _firestore.collection('sessions').doc(sessionId);

    try {
      final usersSnap = await sessionRef.collection('users').get();

      for (final userDoc in usersSnap.docs) {
        final votesSnap = await userDoc.reference.collection('votes').get();
        final batch = _firestore.batch();

        for (final voteDoc in votesSnap.docs) {
          batch.delete(voteDoc.reference);
        }

        batch.delete(userDoc.reference);
        await batch.commit();
      }

      await sessionRef.delete();
    } catch (e) {
      rethrow;
    }
  }
}
