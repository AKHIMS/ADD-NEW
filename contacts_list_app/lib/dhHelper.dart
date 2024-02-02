// ignore_for_file: avoid_print, prefer_conditional_assignment, depend_on_referenced_packages, file_names

import 'dart:developer';

// Importing necessary packages
import 'package:my_pplication/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Defining a singleton class for database operations
class DatabaseHelper {
  static DatabaseHelper? _instance; // Singleton instance
  static const String tableName = 'shoes'; // Table name

  DatabaseHelper._privateConstructor(); // Private constructor

  // Factory method to get the singleton instance
  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  // Getter method for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is not initialized, call the initDatabase method
    _database = await initDatabase();
    return _database!;
  }

  static Database? _database; // Database instance variable

  // Method to initialize the database
  Future<Database> initDatabase() async {
    try {
      // Getting the path for the database file
      String path = join(await getDatabasesPath(), 'shoes_database.db');

      // Opening the database and creating the 'shoes' table if it doesn't exist
      _database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute('''
   CREATE TABLE $tableName (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     shoe_id TEXT,
     name TEXT,
     description TEXT,
     price REAL,
     discount REAL,
     imageUrl TEXT,
     final_price REAL
   )
''');
      }, onConfigure: (db) async {
        // Enabling foreign key support
        await db.execute('PRAGMA foreign_keys = ON');
      });
      return _database!;
    } catch (e) {
      // Handling errors during database initialization
      print('Error initializing database: $e');
      rethrow;
    }
  }

  // Method to insert a shoe into the 'shoes' table
  Future<void> insertShoe(Shoe shoe) async {
    try {
      // Getting the database instance
      final Database db = await database;

      // Logging the shoe's imageUrl
      log('shoe imageurl is ${shoe.imageUrl}');

      // Inserting the shoe into the 'shoes' table
      await db.insert(
        tableName,
        shoe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Handling errors during shoe insertion
      print('Error inserting shoe: $e');
      throw DatabaseException('Failed to insert shoe into the database.');
    }
  }

  // Method to retrieve all shoes from the 'shoes' table
  Future<List<Shoe>> getShoes() async {
    try {
      // Getting the database instance
      final Database db = await database;

      // Querying all records from the 'shoes' table
      final List<Map<String, dynamic>> maps = await db.query(tableName);

      // Converting the query results to a list of Shoe objects
      return List.generate(maps.length, (i) {
        return Shoe.fromMap(maps[i]);
      });
    } catch (e) {
      // Handling errors during shoe retrieval
      print('Error getting shoes: $e');
      throw DatabaseException('Failed to retrieve shoes from the database.');
    }
  }

  // Method to close the database
  Future<void> close() async {
    try {
      // Getting the database instance
      final Database db = await database;

      // Closing the database
      db.close();
    } catch (e) {
      // Handling errors during database closure
      print('Error closing database: $e');
      throw DatabaseException('Failed to close the database.');
    }
  }
}

// Custom exception class for database-related errors
class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}
