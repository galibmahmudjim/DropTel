import 'package:droptel/Constants/Logger.dart';
import 'package:droptel/Obj/Wallet.dart';
import 'package:droptel/Obj/eventWallet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../Obj/User.dart';

class Mongodb {
  static Db db = null as Db;
  static var User_collection;
  static var Event_collection;
  static DbCollection Event_Wallet_collection = null as DbCollection;

  static connect() async {
    await dotenv.load(fileName: "lib/.env");
    String? dbUrl = dotenv.env['MONGODB_URL'];
    db = await Db.create(dbUrl!);
    await db.open();
    User_collection = db.collection('User');
    Event_collection = db.collection('EventWallet');
    Event_Wallet_collection = db.collection('EventWalletDetails');
    return db;
  }

  static Future<dynamic?> NewUser(User user) async {
    if (db.isConnected == false) {
      await connect();
    }

    var result = await User_collection.insertOne(user.toJson());
    return result;
  }

  static Future<dynamic?> authenticateUser(
      String email, String password) async {
    if (db.isConnected == false) {
      await connect();
    }
    dynamic result = await User_collection.findOne({
      "Email": email,
      "Password": password,
    });
    return result;
  }

  static Future<dynamic> findUser(String id, String name) async {
    if (db.isConnected == false) {
      await connect();
    }
    var result = await User_collection.findOne({
      "_id": id,
      "Name": name,
    });

    return await result;
  }

  static Future<dynamic> addNewEvent(eventWallet eventwallet) async {
    if (db.isConnected == false) {
      await connect();
    }
    var result = await Event_collection.insertOne(eventwallet.toJson());

    return await result;
  }

  static Future<dynamic>? getAllEvents(String adminId) async {
    if (db.isConnected == false) {
      connect();
    }
    final result = await Event_collection.find({"AdminId": adminId}).toList();
    result.sort((a, b) {
      final fieldValueA =
          a['DateCreated'] as String; // Change the type as per your data
      final fieldValueB =
          b['DateCreated'] as String; // Change the type as per your data

      return fieldValueB.compareTo(fieldValueA);
    });
    return result;
  }

  static Future<dynamic>? getAllEventsByTitle(
      String adminId, String? text) async {
    if (db.isConnected == false) {
      connect();
    }
    final result = await Event_collection.find({"AdminId": adminId}).toList();
    result.sort((a, b) {
      final fieldValueA =
          a['DateCreated'] as String; // Change the type as per your data
      final fieldValueB =
          b['DateCreated'] as String; // Change the type as per your data

      return fieldValueB.compareTo(fieldValueA);
    });
    result.retainWhere((element) {
      return element['Title']
              .toString()
              .toUpperCase()
              .contains(text.toString().toUpperCase()) ||
          element['Description'].contains(text);
    });
    return result;
  }

  static Future<dynamic>? deleteEvent(String eventID) {
    if (db.isConnected == false) {
      connect();
    }
    return Event_collection.remove({"_id": eventID});
  }

  static Future<dynamic>? EventWalletDetails(Wallet wallet) async {
    if (db.isConnected == false) {
      connect();
    }

    dynamic query = {'EventID': wallet.eventID};
    dynamic update = wallet.toJson();
    var options = {"upsert": true};
    var result =
        await Event_Wallet_collection.update(query, update, upsert: true);
    return result;
  }

  static Future<dynamic>? FindEventDetails(String eventID) async {
    if (db.isConnected == false || !db.masterConnection.connected) {
      connect();
    }
    logger.d(db.masterConnection.connected);
    final result = await Event_Wallet_collection.findOne({"EventID": eventID});
    return await result;
  }
}
