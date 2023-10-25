import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../Obj/User.dart';

class Mongodb {
  static var db;
  static var User_collection;

  static connect() async {
    await dotenv.load(fileName: "lib/.env");
    String? dbUrl = dotenv.env['MONGODB_URL'];
    db = await Db.create(dbUrl!);
    await db.open();
    User_collection = db.collection('User');
    return db;
  }

  static NewUser(User user) async {
    if (db.isConnected() == false) await connect();

    var result = await User_collection.insertOne(user.toJson());
    print(result.success);
    return result;
  }

  static authenticateUser(String email, String password) async {
    var result = await User_collection.findOne({
      "Email": email,
      "Password": password,
    });
    return result;
  }
}
