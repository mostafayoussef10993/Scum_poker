/*

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vote.dart';
import '../models/session.dart';

class SessionRepository {
  final FirebaseFirestore _firestore;
  SessionRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<Map<String, Vote>> votesStream(String sessionId) {
    final coll = _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('votes');
    return coll.snapshots().map((snap) {
      return {for (var d in snap.docs) d.id: Vote.fromMap(d.id, d.data())};
    });
  }

  Stream<Session> sessionStream(String sessionId) {
    final doc = _firestore.collection('sessions').doc(sessionId);
    return doc.snapshots().map(
      (snap) => Session.fromMap(snap.id, snap.data() ?? {}),
    );
  }

  Future<void> submitVote(
    String sessionId,
    String userId,
    String name,
    int? value,
  ) {
    final doc = _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('votes')
        .doc(userId);
    return doc.set({'name': name, 'value': value});
  }

  Future<void> setReveal(String sessionId, bool reveal) {
    final doc = _firestore.collection('sessions').doc(sessionId);
    return doc.set({'reveal': reveal}, SetOptions(merge: true));
  }

  Future<void> createSessionIfNotExists(String sessionId) async {
    final docRef = _firestore.collection('sessions').doc(sessionId);
    final snap = await docRef.get();
    if (!snap.exists) {
      await docRef.set({
        'reveal': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Delete all votes in the given session and reset reveal to false.
  Future<void> resetVotes(String sessionId) async {
    final coll = _firestore
        .collection('sessions')
        .doc(sessionId)
        .collection('votes');
    final snap = await coll.get();
    if (snap.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    // Ensure reveal is reset to false after clearing votes
    await setReveal(sessionId, false);
  }
}
*/
