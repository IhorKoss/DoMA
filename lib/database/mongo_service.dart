import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_project/constants/db_constants.dart';

class MongoService {
  static var db;
  static var collection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    collection = db.collection(COLLECTION_NAME);
  }

  static Future<ObjectId?> addStudent(Map<String, dynamic> data) async {
    try {
      final result = await collection.insertOne(data);
      print('Student added successfully');
      print(result.id.toString());
      return result.id as ObjectId;
    } catch (e) {
      print('$e');
      return null;
    }
  }
  static Future<Map<String, dynamic>?> getStudentById(ObjectId id) async {
    try {
      final result = await collection.findOne(where.id(id));
      if (result != null) {
        print('Student found');
        return result as Map<String, dynamic>?;
      } else {
        throw Exception('Student not found');
      }
    } catch (e) {
      print('$e');
    }
    return null;
  }
  static Future<Map<String, dynamic>?> getStudentByEmail(String email) async {
    try {
      final result = await collection.findOne(where.eq('email', email));
      if (result != null) {
        print('Student found');
        return result as Map<String, dynamic>?;
      } else {
        throw Exception('Student not found');
      }
    } catch (e) {
      print('$e');
    }
    return null;
  }
  static Future<void> updateStudent(String email, Map<String, dynamic> updatedData) async {
    try{
      final updateQuery = {
        '\$set': updatedData,
      };
      final result = await collection.updateOne(where.eq('email', email), updateQuery);
      if (result!=null) {
        print('Student updated successfully');
      } else {
        throw Exception('Student not found');
    }
  }catch(e){
      print('Error updating record: $e');
    }
  }

}
