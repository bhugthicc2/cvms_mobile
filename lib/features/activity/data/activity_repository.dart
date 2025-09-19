import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collection = "activities";

  Future<void> addActivity(ActivityModel activity) async {
    final docRef = _db.collection(collection).doc();
    await docRef.set(activity.toMap());
  }

  Future<List<ActivityModel>> getRecentActivities({int limit = 50}) async {
    final snapshot =
        await _db
            .collection(collection)
            .orderBy('timestamp', descending: true)
            .limit(limit)
            .get();

    return snapshot.docs
        .map((doc) => ActivityModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
