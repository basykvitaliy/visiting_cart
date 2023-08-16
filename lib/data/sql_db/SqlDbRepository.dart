import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/model/my_card/address_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/model/user/user_model.dart';

class SqlDbRepository {
  static final SqlDbRepository instance = SqlDbRepository._instance();
  static Database? _db;
  SqlDbRepository._instance();

  AuthStatus? _status = AuthStatus.unknown;

  /// User model.
  String userTable = "user_table";
  String colId = "id";
  String colName = "name";
  String colBirthday = "birthday";
  String colPhone = "phone";
  String colEmail = "email";
  String colPhoto = "photo";
  String colQrCode = "qrcode";
  /// User model.


  /// Visitka model.
    String myCardTable = "my_card_table";
    String colCardId = "id";
    String colCardName = "cardName";
    String colBarcode = "barcode";
    String colDate = "date";
    String colBackgroundColor = "backgroundColor";
    String colCardPhoto = "photo";
    /// Visitka model.


  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    //String path = dir.path + "db";
    String path = p.join(dir.toString(),"db");
    final table = await openDatabase(path, version: 1, onCreate: _onCreate);
    return table;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $userTable("
        "$colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$colName TEXT, "
        "$colBirthday TEXT, "
        "$colPhone TEXT, "
        "$colEmail TEXT, "
        "$colPhoto TEXT, "
        "$colQrCode TEXT) "
    );

    await db.execute("CREATE TABLE $myCardTable("
        "$colCardId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$colCardName TEXT, "
        "$colBarcode TEXT, "
        "$colDate TEXT, "
        "$colBackgroundColor TEXT,"
        "$colCardPhoto TEXT) "
    );
  }

  Future<UserModel?> getUser() async {
    Database db = await this.db;
    final List<Map<String, Object?>> userModelMap = await db.query(userTable);

    if (userModelMap.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(userModelMap.last);

      Uint8List? photoBytes = userModelMap.last[colPhoto] as Uint8List?;
      userModel.photo = photoBytes;

      return userModel;
    } else {
      return null;
    }
  }

  Future<List<CardModel>> getUserCards() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> userCardsMapList = await db.query(myCardTable);
    final List<CardModel> cardsList = [];

    for (var element in userCardsMapList) {
      // Отримання байтів фотографії з колонки photo
      Uint8List? photoBytes = element[colCardPhoto] as Uint8List?;

      CardModel card = CardModel(
        id: element[colCardId],
        cardName: element[colCardName],
        barcode: element[colBarcode],
        date: element[colDate],
        backgroundColor: element[colBackgroundColor],
        photo: photoBytes,
      );

      cardsList.add(card);
    }

    return cardsList;
  }


  Future<AuthStatus> insertUser(UserModel userModel) async {
    Database db = await this.db;
    final result = await db.insert(userTable, userModel.toJson());
    if(result != null){
      _status = AuthStatus.successful;
    }else{
      _status = AuthStatus.error;
    }
    print("Save user");
    return _status!;
  }

  Future<AuthStatus> insertCard(CardModel card) async {
    Database db = await this.db;
    Map<String, dynamic> cardJson = card.toJson();

    final result = await db.insert(myCardTable, cardJson);
    if(result != null){
      _status = AuthStatus.successful;
    }else{
      _status = AuthStatus.error;
    }
    print("Save ");
    return _status!;
  }

  // Future<AuthStatus> updatePersonalCard(PersonalCardModel card) async {
  //   Database db = await this.db;
  //   Map<String, dynamic> cardJson = card.toJson();
  //
  //   final result = await db.update(
  //     personalCardTable,
  //     cardJson,
  //     where: '$colPersonalCardPhone = ?',
  //     whereArgs: [card.phone],
  //   );
  //
  //   if (result != 0) {
  //     _status = AuthStatus.successful;
  //   } else {
  //     _status = AuthStatus.error;
  //   }
  //   print("Update ");
  //   return _status!;
  // }
  //
  // Future<AuthStatus> updateCard(MyCardModel card) async {
  //   Database db = await this.db;
  //   Map<String, dynamic> cardJson = card.toJson();
  //   cardJson[colAddress] = jsonEncode(cardJson[colAddress]);
  //   cardJson[colWorkDay] = jsonEncode(cardJson[colWorkDay]);
  //   cardJson[colSocialNetworks] = jsonEncode(cardJson[colSocialNetworks]);
  //
  //   final result = await db.update(
  //     myCardTable,
  //     cardJson,
  //     where: '$colCardId = ?',
  //     whereArgs: [card.id],
  //   );
  //
  //   if (result != 0) {
  //     // Оновити поля об'єкта MyCardModel після виконання оновлення в базі даних
  //     card.isFavorite = cardJson['isFavorite'];
  //     // Оновити інші поля, які вам потрібно оновити
  //
  //     _status = AuthStatus.successful;
  //   } else {
  //     _status = AuthStatus.error;
  //   }
  //
  //   print("Update ");
  //   return _status!;
  // }
  //
  Future<AuthStatus> updateUser(UserModel user) async {
    Database db = await this.db;
    final result = await db.update(
      userTable,
      user.toJson(),
      where: "$colId = ?",
      whereArgs: [user.id],
    );
    if(result != null){
      _status = AuthStatus.successful;
    }else{
      _status = AuthStatus.error;
    }
    print("Save user");
    return _status!;
  }


  Future<bool> deleteCard(String id) async {
    Database db = await this.db;
    final result = await db.delete(myCardTable, where: "$colCardId = ?", whereArgs: [id]);
    if(result != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> deleteAllUser() async {
    Database db = await this.db;
    await db.delete(userTable);
  }

  /// Search
  // Future<List<dynamic>> searchAll(String query) async {
  //   List<dynamic> searchResults = [];
  //
  //   // Пошук в таблиці PersonalCardModel
  //   List<PersonalCardModel> personalCardResults = await searchPersonalCards(query);
  //   searchResults.addAll(personalCardResults);
  //
  //   // Пошук в таблиці ClubCardModel
  //   List<ClubCardModel> clubCardResults = await searchClubCards(query);
  //   searchResults.addAll(clubCardResults);
  //
  //   // Пошук в таблиці myCardTable
  //   List<MyCardModel> myCardResults = await searchMyCards(query);
  //   searchResults.addAll(myCardResults);
  //
  //   return searchResults;
  // }
  //
  // Future<List<ClubCardModel>> searchClubCards(String query) async {
  //   Database db = await this.db;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     clubCardTable,
  //     where: '$colClubCardTitle LIKE ?',
  //     whereArgs: ['%$query%'],
  //   );
  //   List<ClubCardModel> searchResults = [];
  //   for (final map in maps) {
  //     ClubCardModel card = ClubCardModel.fromJson(map);
  //     searchResults.add(card);
  //   }
  //   return searchResults;
  // }
  //
  // Future<List<PersonalCardModel>> searchPersonalCards(String query) async {
  //   Database db = await this.db;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     personalCardTable,
  //     where: '$colPersonalCardName LIKE ?',
  //     whereArgs: ['%$query%'],
  //   );
  //   List<PersonalCardModel> searchResults = [];
  //   for (final map in maps) {
  //     PersonalCardModel card = PersonalCardModel.fromJson(map);
  //     searchResults.add(card);
  //   }
  //   return searchResults;
  // }
  //
  // Future<List<MyCardModel>> searchMyCards(String query) async {
  //   Database db = await this.db;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     myCardTable,
  //     where: '$colNameUser LIKE ?',
  //     whereArgs: ['%$query%'],
  //   );
  //
  //   List<MyCardModel> searchResults = [];
  //   for (final element in maps) {
  //
  //     // Розпакування значення colAddress
  //     String addressString = element[colAddress];
  //     Map<String, dynamic> addressJson = jsonDecode(addressString);
  //     AddressModel address = AddressModel.fromJson(addressJson);
  //
  //     // Отримання байтів фотографії з колонки photo
  //     Uint8List? photoBytes = element[colCardPhoto] as Uint8List?;
  //
  //     // Декодування інших полів
  //     List<WorkTime> workDays = (jsonDecode(element[colWorkDay]) as List)
  //         .map((day) => WorkTime.fromJson(day))
  //         .toList();
  //
  //     List<SocialNetworks> socialNetworks = (jsonDecode(element[colSocialNetworks]) as List)
  //         .map((network) => SocialNetworks.fromJson(network))
  //         .toList();
  //
  //     MyCardModel card = MyCardModel(
  //         id: element[colCardId],
  //         address: address,
  //         days: workDays,
  //         socialNetworks: socialNetworks,
  //         type: element[colType],
  //         nameUser: element[colNameUser],
  //         companyName: element[colCompanyName],
  //         kindOfActivity: element[colKindOfActivity],
  //         phone: element[colPhone],
  //         email: element[colEMail],
  //         logoPath: element[colLogoPath],
  //         backgroundPath: element[colBackgroundPath],
  //         photo: photoBytes,
  //         isFavorite: element[colFavorite]
  //     );
  //
  //     searchResults.add(card);
  //   }
  //   return searchResults;
  // }

/// Search
}
