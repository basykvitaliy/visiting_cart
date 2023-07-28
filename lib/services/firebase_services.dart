import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visiting_card/helpers/constants.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.unknown;
  static RxString notificationId = "".obs;

  CollectionReference collectionManagers = FirebaseFirestore.instance.collection("managers");
  CollectionReference collectionShops = FirebaseFirestore.instance.collection("shops");
  CollectionReference collectionProducts = FirebaseFirestore.instance.collection("products");
  CollectionReference collectionDefectiveProducts = FirebaseFirestore.instance.collection("defective_products");
  CollectionReference collectionNotifications = FirebaseFirestore.instance.collection("notifications");
  CollectionReference collectionBuyers = FirebaseFirestore.instance.collection("buyers");

  String getUserId() => _auth.currentUser!.uid;

  // Future<BuyersModel> getBuyer(String userId) async {
  //   QuerySnapshot snapshot = await collectionBuyers.get();
  //   var dat = snapshot.docs.firstWhere((element) => element.id == userId);
  //
  //   return BuyersModel(
  //     nameUser: dat.data().toString().contains('full_name') ? dat.get('full_name') : '',
  //     avatar: dat.data().toString().contains('full_name') ? dat.get('full_name') : '',
  //   );
  // }
  //
  // /// Stream for get cart from firebase.
  // static Stream<List<BuyersModel>> streamGetBuyer() {
  //   return FirebaseFirestore.instance
  //       .collection('buyers')
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<BuyersModel> listNotifications = List<BuyersModel>.empty(growable: true);
  //     for (var doc in query.docs) {
  //       var model = BuyersModel(
  //         nameUser: doc.data().toString().contains('full_name') ? doc.get('full_name') : '',
  //         avatar: doc.data().toString().contains('full_name') ? doc.get('full_name') : '',
  //       );
  //       listNotifications.add(model);
  //     }
  //     return listNotifications.toList();
  //   });
  // }

  /// Write product to firebase.
  Future<AuthStatus> writeProduct(Map<String, dynamic> product, String uId) async {
    try {
      await collectionProducts.doc(uId).set(product).whenComplete(() {
        _status = AuthStatus.successful;
      });
    } on FirebaseException catch (e, s) {
      _status = AuthStatus.firebaseError;
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      _status = AuthStatus.error;
    }
    return _status;
  }

  /// Write defective product to firebase.
  Future<AuthStatus> writeDefectiveProduct(Map<String, dynamic> defectiveProduct, String uId) async {
    try {
      await collectionDefectiveProducts.doc(uId).set(defectiveProduct).whenComplete(() {
        _status = AuthStatus.successful;
      });
    } on FirebaseException catch (e, s) {
      _status = AuthStatus.firebaseError;
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      _status = AuthStatus.error;
    }
    return _status;
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

  void signOut() {
    _auth.signOut().whenComplete(() {

    });
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await _auth
        .sendPasswordResetEmail(email: email)
        .then((v) => _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }

  // /// Get managers from firebase firestore.
  // Future<List<ManagerModel>> getManager() async {
  //   List<ManagerModel> listManagers = List<ManagerModel>.empty(growable: true);
  //
  //   try {
  //     QuerySnapshot snapshot = await collectionManagers.get();
  //
  //     for (var manager in snapshot.docs) {
  //       listManagers.add(ManagerModel.fromJson(manager.data() as Map<String, dynamic>));
  //     }
  //   } on FirebaseException catch (e, s) {
  //     print("ERROR FIREBASE CATCH: $e");
  //   } catch (e) {
  //     print("ERROR CATCH: $e");
  //   }
  //   return listManagers;
  // }
  //
  // /// Get shops.
  // Future<ManagerModel> getManagerFromId(String id) async {
  //   QueryDocumentSnapshot<Object?> managerModel;
  //   var man;
  //   try {
  //     QuerySnapshot snapshot = await collectionManagers.get();
  //     managerModel = snapshot.docs.firstWhere((element) => element.id == id);
  //     man = ManagerModel.fromJson(managerModel.data() as Map<String, dynamic>);
  //
  //   } on FirebaseException catch (e, s) {
  //     print("ERROR FIREBASE CATCH: $e");
  //   } catch (e) {
  //     print("ERROR CATCH: $e");
  //   }
  //   return man;
  // }
  //
  // /// Write a new notifications to firebase.
  // Future<String> createNewNotification(NotificationModel model) async {
  //   String? id = '';
  //   try {
  //     await collectionNotifications.add(model.toJson()).then((value) {
  //       id = value.id;
  //     });
  //   } on FirebaseAuthException catch (e, stack) {
  //     print(e.message.toString());
  //     return e.message.toString();
  //   } catch (e) {
  //     print(e.toString());
  //     return e.toString();
  //   }
  //   return id!;
  // }
  //
  // /// Stream for get cart from firebase.
  // static Stream<List<NotificationModel>> streamGetNotifications() {
  //   var id = Session.shopId;
  //   return FirebaseFirestore.instance
  //       .collection('notifications')
  //       .where("shop_id", isEqualTo: id)
  //       .where("type", isEqualTo: "buyer_need_help")
  //       .orderBy('created_at', descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<NotificationModel> listNotifications = List<NotificationModel>.empty(growable: true);
  //     notificationId.value = query.docs.first.id;
  //     for (var doc in query.docs) {
  //       var model = NotificationModel(
  //         type: doc.data().toString().contains('type') ? doc.get('type') : '',
  //         shopId: doc.data().toString().contains("shop_id") ? doc.get("shop_id") : '',
  //         userId: doc.data().toString().contains("user_id") ? doc.get("user_id") : '',
  //         managerId: doc.data().toString().contains("manager_id") ? doc.get("manager_id") : '',
  //         managerReadStatus:
  //             doc.data().toString().contains("manager_read_status") ? doc.get("manager_read_status") : false,
  //         adminReadStatus: doc.data().toString().contains("admin_read_status") ? doc.get("admin_read_status") : false,
  //         createdAt: doc["created_at"],
  //         updatedAt: doc["updated_at"],
  //         data: DataNotificationModel(
  //           location: doc["data"]["location"],
  //           problem: doc["data"]["problem"],
  //         ),
  //       );
  //       listNotifications.add(model);
  //     }
  //     return listNotifications.toList();
  //   });
  // }

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
  //
  // /// Update field manager_id from collection notification.
  // Future<AuthStatus> updateNotification(NotificationModel model) async {
  //   try {
  //     var managerId = getUserId();
  //
  //     await collectionNotifications.doc(notificationId.value).set({
  //       'manager_id': managerId,
  //       //'user_id': model.userId,
  //       'manager_read_status': true,
  //     }, SetOptions(merge: true));
  //     // await collectionNotifications.doc(notificationId.value).update(
  //     //   {
  //     //     'manager_id': managerId,
  //     //     'user_id': model.userId,
  //     //     'data': {
  //     //       'location': model.data?.location,
  //     //       'problem': model.data?.problem,
  //     //     },
  //     //     'manager_read_status': model.managerReadStatus,
  //     //     'admin_read_status': false
  //     //   },
  //     // );
  //     _status = AuthStatus.successful;
  //   } on FirebaseException catch (e, s) {
  //     print("ERROR FIREBASE CATCH: $e");
  //     _status = AuthStatus.firebaseError;
  //   } catch (e) {
  //     print("ERROR CATCH: $e");
  //     _status = AuthStatus.error;
  //   }
  //   return _status;
  // }
  //
  // /// Get notification from firebase firestore.
  // Future<List<NotificationModel>> getNotifications() async {
  //   List<NotificationModel> listNotifications = List<NotificationModel>.empty(growable: true);
  //   try {
  //     var id = Session.shopId;
  //     QuerySnapshot snapshot = await collectionNotifications.where("shop_id", isEqualTo: id).get();
  //
  //     for (var doc in snapshot.docs) {
  //       var model = NotificationModel(
  //           type: doc['type'],
  //           shopId: doc["shop_id"],
  //           userId: doc["user_id"],
  //           managerId: doc["manager_id"],
  //           managerReadStatus: doc["manager_read_status"],
  //           adminReadStatus: doc["admin_read_status"],
  //           data: DataNotificationModel(
  //             location: doc["data"]["location"],
  //             problem: doc["data"]["problem"],
  //           ));
  //       if (model.type == 'buyer_need_help') listNotifications.add(model);
  //     }
  //   } on FirebaseException catch (e, s) {
  //     print("ERROR FIREBASE CATCH: $e");
  //   } catch (e) {
  //     print("ERROR CATCH: $e");
  //   }
  //   return listNotifications.toList();
  // }
  //
  // /// Get shops.
  // Future<List<ShopModel>> getShops() async {
  //   List<ShopModel> listShops = List<ShopModel>.empty(growable: true);
  //   try {
  //     QuerySnapshot snapshot = await collectionShops.get();
  //     for (var shop in snapshot.docs) {
  //       listShops.add(ShopModel.fromJson(shop.data() as Map<String, dynamic>));
  //     }
  //   } on FirebaseException catch (e, s) {
  //     print("ERROR FIREBASE CATCH: $e");
  //   } catch (e) {
  //     print("ERROR CATCH: $e");
  //   }
  //   return listShops.toList();
  // }

  /// Get shops ids.
  Future<List<String>> getShopsId() async {
    List<String> listShops = List<String>.empty(growable: true);
    try {
      QuerySnapshot snapshot = await collectionShops.get();
      for (var shop in snapshot.docs) {
        listShops.add(shop.id);
      }
    } on FirebaseException catch (e, s) {
      print("ERROR FIREBASE CATCH: $e");
    } catch (e) {
      print("ERROR CATCH: $e");
    }
    return listShops.toList();
  }

  /// Update field last_activity from collection manager.
  Future<void> updateManager(String time) async {
    await collectionManagers
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
