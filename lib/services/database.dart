import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");
  Future<void> updateUserData(String sugars, String name, int strength) async {
    try {
      await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
      print('User data updated successfully!');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

// brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Brew(
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '',
        strength: data['strength'] ?? 0,
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot, String uid) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        name: data['name'],
        sugars: data['sugar'],
        strength: data['strangth']);
  }

// get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

// get user doc stream
  Stream<UserData> get userData {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => _userDataFromSnapshot(snapshot, uid));
  }
}
