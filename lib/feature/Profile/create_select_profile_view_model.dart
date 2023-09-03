import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'create_select_profile_view_model.g.dart';

class CreateSelectProfileViewModel = _CreateSelectProfileViewModelBase with _$CreateSelectProfileViewModel;

abstract class _CreateSelectProfileViewModelBase with Store {
  // MobX mağazanızdaki değişkenleri burada tanımlayın

  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  late CollectionReference<Map<String, dynamic>> profileCollection;
  late DocumentReference<Map<String, dynamic>> profileDoc;
  late CollectionReference<Map<String, dynamic>> mainCollection;

  @observable
  String newUsername = ''; // Kullanıcıdan aldığınız kullanıcı adını burada saklayın

  @observable
  String newPhotoURL = ''; // K

  @observable
  var docSnapshot;

  @observable
  List<Map<String, dynamic>> profiles = [];

  _CreateSelectProfileViewModelBase() {
    // Constructor içinde başlatma işlemlerini yapabilirsiniz
    profileCollection = FirebaseFirestore.instance.collection('profiles');
    profileDoc = profileCollection.doc(user?.uid);
    mainCollection = FirebaseFirestore.instance.collection('characters');
  }

  // Diğer değişkenleri ve işlevleri burada tanımlayın

  // MobX işlemleri için aksiyonları burada tanımlayın
  @action
  void removeProfile(int index) {
    // İndeks sınırları kontrolü
    if (index >= 0 && index < profiles.length) {
      // Seçilen profili kaldırın
      profiles.removeAt(index);

      // Firestore'daki profili güncelleyin
      profileDoc.set({
        'profiles': profiles,
      });
    } else {
      print('Geçersiz indeks');
    }
  }

  @action
  Future<void> addProfile(String username, String photoURL) {
    // Fetch existing profiles from Firestore
    return profileDoc.get().then((docSnapshot) {
      final profiles = List<Map<String, dynamic>>.from(docSnapshot.data()?['profiles'] ?? []);

      // Add the new profile
      profiles.add({
        'username': username,
        'photoURL': photoURL,
      });

      // Update the profiles in Firestore
      return profileDoc.set({
        'profiles': profiles,
      });
    });
  }

  @action
  Future<List<Map<String, dynamic>>> getCharacterDataList() async {
    try {
      final querySnapshot = await mainCollection.get();

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
      rethrow; // Hata durumunda isteği iletebilir veya işleyebilirsiniz
    }
  }

  @action
  Future<List<Map<String, dynamic>>> getProfiles() async {
    try {
      docSnapshot = await profileDoc.get();

      if (docSnapshot.exists) {
        // Firestore'dan gelen belge verilerini işleme
        final data = docSnapshot.data();
        final List<dynamic>? profiles = data?['profiles'];

        if (profiles != null) {
          // Profiles verisi mevcutsa ve boş değilse, listeyi döndür
          return List<Map<String, dynamic>>.from(profiles);
        }
      }

      // Veri yoksa veya hata oluşursa boş bir liste döndür
      return [];
    } catch (e) {
      print('Error: $e');
      rethrow; // Hata durumunda isteği iletebilir veya işleyebilirsiniz
    }
  }
}
