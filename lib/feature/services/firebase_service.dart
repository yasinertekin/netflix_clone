import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';

abstract class ProfileServiceBase {
  Future<DocumentReference<Map<String, dynamic>>> getProfileDocument();
  Future<List<Map<String, dynamic>>> getProfiles();
  Future<void> addProfile(ProfileModel profileModel);
  Future<void> removeProfile(int index);
  Future<List<Map<String, dynamic>>> getCharacterDataList();
  Future<void> updateProfile(int index, ProfileModel profileModel);
  Future<void> addFavoriteMovie(String uid, MoviesModel movieName);
  Future<void> removeFavoriteMovie(String uid, MoviesModel movieName);
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
  Future<void> addProfile(ProfileModel profileModel) async {
    final profileDoc = await getProfileDocument();
    final profiles = await getProfiles();

    profiles.add({
      'username': profileModel.username,
      'photoURL': profileModel.photoURL,
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
    } else {}
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
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(int index, ProfileModel profileModel) async {
    try {
      final profiles = await getProfiles();
      if (index >= 0 && index < profiles.length) {
        profiles[index] = {
          'username': profileModel.username,
          'photoURL': profileModel.photoURL,
        };
        final profileDoc = await getProfileDocument();
        await profileDoc.set({
          'profiles': profiles,
        });
      } else {
        Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addFavoriteMovie(String uid, MoviesModel movie) async {
    try {
      final userProfileRef = FirebaseFirestore.instance.collection('profiles').doc(uid);
      await getProfiles();
      final userData = await userProfileRef.get();

      if (userData.exists) {
        await userProfileRef.update({
          'favoriteMovies': FieldValue.arrayUnion([movie.toMap()]),
        });
      } else {
        Exception();
      }
    } catch (e) {
      Exception();
    }
  }

  @override
  Future<void> removeFavoriteMovie(String uid, MoviesModel movie) async {
    try {
      final userProfileRef = FirebaseFirestore.instance.collection('profiles').doc(uid);
      await getProfiles();
      final userData = await userProfileRef.get();

      if (userData.exists) {
        await userProfileRef.update({
          'favoriteMovies': FieldValue.arrayRemove([movie.toMap()]),
        });
      } else {
        Exception();
      }
    } catch (e) {
      Exception();
    }
  }
}



/*  @override
  Future<void> addFavoriteMovie(String uid, MoviesModel movie) async {
    try {
      final userProfileRef = FirebaseFirestore.instance.collection('profiles').doc(uid);
      final userData = await userProfileRef.get();

      if (userData.exists) {
        final Map<String, dynamic> userDataMap = userData.data() as Map<String, dynamic>;
        List<dynamic> profiles = userDataMap['profiles'] ?? [];

        // "profiles" içindeki her "profile" nesnesinin "favorite" alanını güncelleyin
        final updatedProfiles = profiles.map((profile) {
          if (profile['favorite'] == null) {
            // Eğer "favorite" alanı henüz tanımlanmamışsa, yeni bir liste oluşturun
            profile['favorite'] = [movie.toMap()];
          } else {
            // "favorite" alanı zaten varsa, mevcut listeye yeni filmi ekleyin
            List<dynamic> favoriteMovies = profile['favorite'];
            favoriteMovies.add(movie.toMap());
            profile['favorite'] = favoriteMovies;
          }
          return profile;
        }).toList();

        await userProfileRef.update({
          'profiles': updatedProfiles,
        });
      } else {
        print('Kullanıcı belgesi bulunamadı.');
      }
    } catch (e) {
      print("Favori film ekleme hatası: $e");
    }
  }*/
