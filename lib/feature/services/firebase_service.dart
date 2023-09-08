import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileServiceBase {
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument();
  Future<List<Map<String, dynamic>>> getProfiles();
  Future<void> addProfile(String username, String photoURL);
  Future<void> removeProfile(int index);
  Future<List<Map<String, dynamic>>> getCharacterDataList();
  Future<void> updateProfile(int index, String username, String? photoURL);
}

class FirebaseProfileService extends ProfileServiceBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument() async {
    final user = _auth.currentUser;
    if (user != null) {
      final profileCollection = _firestore.collection('profiles');
      return profileCollection.doc(user.uid);
    }
    throw Exception('Kullanıcı oturumu açık değil');
  }

  @override
  Future<List<Map<String, dynamic>>> getProfiles() async {
    final profileDoc = await getProfileDocument();
    final docSnapshot = await profileDoc.get();
    final profilesData = docSnapshot.data()?['profiles'] ?? [];
    return List<Map<String, dynamic>>.from(profilesData);
  }

  @override
  Future<void> addProfile(String username, String photoURL) async {
    final profileDoc = await getProfileDocument();
    final profiles = await getProfiles();
    profiles.add({
      'username': username,
      'photoURL': photoURL,
    });
    await profileDoc.set({
      'profiles': profiles,
    });
  }

  @override
  Future<void> removeProfile(int index) async {
    final profiles = await getProfiles();
    if (index >= 0 && index < profiles.length) {
      profiles.removeAt(index);
      final profileDoc = await getProfileDocument();
      await profileDoc.set({
        'profiles': profiles,
      });
    } else {
      print('Geçersiz indeks');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getCharacterDataList() async {
    try {
      final querySnapshot = await _firestore.collection('characters').get();

      // Firestore'dan gelen belgeleri işleme
      List<Map<String, dynamic>> characterList = [];

      for (final documentSnapshot in querySnapshot.docs) {
        final documentData = documentSnapshot.data();
        final name = documentData['name'] as String;
        final photos = documentData['photos'] as List<dynamic>;

        characterList.add({
          'name': name,
          'photos': photos,
        });
      }

      // Karakter verilerini kullanmak için characterList'i döndürebilirsiniz
      return characterList;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(int index, String username, String? photoURL) async {
    try {
      final profiles = await getProfiles();
      if (index >= 0 && index < profiles.length) {
        profiles[index] = {
          'username': username,
          'photoURL': photoURL,
        };
        final profileDoc = await getProfileDocument();
        await profileDoc.set({
          'profiles': profiles,
        });
      } else {
        print('Geçersiz indeks');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
