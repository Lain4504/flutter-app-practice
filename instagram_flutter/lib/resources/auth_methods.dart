import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty && file != null) {
        // Create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Upload profile picture to Firebase Storage
        String photoUrl = await _uploadImageToStorage('profilePics', file, false);

        // Add user to Firestore
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'photoUrl': photoUrl,
          'followers': [],
          'following': [],
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> _uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}