import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_project/constants/db_constants.dart';
import 'package:provider/provider.dart';

import '../models/student_model.dart';

class MongoService {
  static var db;
  static var collection;
  static var loggedCollection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    collection = db.collection(COLLECTION_NAME);
    loggedCollection = db.collection(LOGGED_COLLECTION_NAME);
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

  static Future<ObjectId?> loggedStudent(Map<String, dynamic> data) async {
    try {
      final result = await loggedCollection.insertOne(data);
      print('Logged student data added successfully');
      return result.id as ObjectId;
    } catch (e) {
      print('$e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getLoggedStudent() async {
    try {
      final result = await loggedCollection.findOne();
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

  static Future<void> deleteLoggedStudent() async {
    try{
      final result = await loggedCollection.deleteOne({});
      if (result!=null) {
        print('Logged student data deleted successfully');
      } else {
        throw Exception('Student not found');
      }
    }catch(e){
      print('Error deleting record: $e');
    }
  }
  static Future<void> retryConnection(BuildContext context) async {
    try {
      await MongoService.connect();
      final loggedStudent = await MongoService.getLoggedStudent();
      if (loggedStudent != null) {
        Provider.of<Student>(context, listen: false).setLoggedInStudent(
          email: loggedStudent['email'] as String,
          password: loggedStudent['password'] as String,
          studentId: loggedStudent['studentId'] as String,
          fullName: loggedStudent['fullName'] != null ? loggedStudent['fullName'] as String : '',
          group: loggedStudent['group'] != null ? loggedStudent['group'] as String : '',
          isFullTimeStudent: loggedStudent['isFullTimeStudent'] != null ? loggedStudent['isFullTimeStudent'] as bool : true,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не вдалося підключитися: $e')),
      );
    }
  }

}
