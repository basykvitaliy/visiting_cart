import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/model/logos/logos_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.unknown;
  static RxString notificationId = "".obs;

  CollectionReference collectionLogos = FirebaseFirestore.instance.collection("logos");

  String getUserId() => _auth.currentUser!.uid;

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

  /// Get managers from firebase firestore.
  Future<List<LogosModel>> getLogos() async {
    List<LogosModel> listManagers = List<LogosModel>.empty(growable: true);
    try {
      QuerySnapshot snapshot = await collectionLogos.get();
      for (var logo in snapshot.docs) {
        listManagers.add(LogosModel.fromJson(logo.data() as Map<String, dynamic>));
      }
    } on FirebaseException catch (e, s) {
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      print("ERROR CATCH: $e");
    }
    return listManagers;
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
