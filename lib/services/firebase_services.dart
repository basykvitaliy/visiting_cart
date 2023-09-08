import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as d;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/model/my_card/card_fb_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.unknown;
  static RxString notificationId = "".obs;

  CollectionReference collectionLogos = FirebaseFirestore.instance.collection("logos");
  CollectionReference collectionUsers = FirebaseFirestore.instance.collection("users");

  String getUserId() => _auth.currentUser!.uid;

  /// Create a new client to firebase cloudstore.
  Future<AuthStatus> writeCardToFirebase(CardFBModel cardModel) async {
    try {
      await collectionUsers.doc(getUserId()).collection("cards").doc(cardModel.id.toString()).set(cardModel.toJson()).whenComplete(() => _status = AuthStatus.successful);
    } on FirebaseAuthException catch (e, stack) {
      _status = AuthStatus.firebaseError;
      print(e.message.toString());
      return _status;
    } catch (e) {
      _status = AuthStatus.error;
      print(e.toString());
      return _status;
    }
    return _status;
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    var result;
    final storage = FirebaseStorage.instance;
    final File imageFile = File(imagePath);
    final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    final Reference reference = storage.ref().child(getUserId()).child(fileName);
    try {
      final UploadTask uploadTask = reference.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        final String photoUrl = await reference.getDownloadURL();
        result = photoUrl;
      });
    } catch (e) {
      print("Error uploading file: $e");
    }
    return result;
  }
  Future<List<CardFBModel>> getCards() async {
    List<CardFBModel> listCards = List<CardFBModel>.empty(growable: true);
    try {
      QuerySnapshot snapshot = await collectionUsers.doc(getUserId()).collection("cards").get();
      for (var card in snapshot.docs) {
        listCards.add(CardFBModel.fromJson(card.data() as Map<String, dynamic>));
      }
    } on FirebaseException catch (e, s) {
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      print("ERROR CATCH: $e");
    }
    return listCards;
  }

  Future<AuthStatus> removeCard(String docId) async {
    var uid = getUserId();
    await collectionUsers.doc(uid).collection("cards").doc(docId).delete().whenComplete(() {
      _status = AuthStatus.successful;
    }).catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }

  /// Sign in with google.
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    //final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    //
    // // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    return googleUser;
  }

  /// Sign in account.
  Future<String?>? signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e, stack) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// Get managers from firebase firestore.
  Future<List<LogosModel>> getLogos() async {
    List<LogosModel> listLogos = List<LogosModel>.empty(growable: true);
    try {
      QuerySnapshot snapshot = await collectionLogos.get();
      for (var logo in snapshot.docs) {
        listLogos.add(LogosModel.fromJson(logo.data() as Map<String, dynamic>));
      }
    } on FirebaseException catch (e, s) {
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      print("ERROR CATCH: $e");
    }
    return listLogos;
  }

  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  /// Update field last_activity from collection manager.
  Future<void> updateManager(String time) async {
    await collectionLogos
        .doc(getUserId())
        .update({'last_activity': time})
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  Future<Uint8List> downloadAndSaveImage(String imageUrl) async {
    final d.Dio dio = d.Dio();
    Uint8List? imageBytes;
    try {
      final d.Response<Uint8List> response = await dio.get<Uint8List>(
        imageUrl,
        options: d.Options(responseType: d.ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        imageBytes = response.data!;
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      print('Error: $e');
    }
    return imageBytes!;
  }
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage = "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}
