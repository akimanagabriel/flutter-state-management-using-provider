import 'package:flutter/material.dart';
import 'package:flutter_state_management/models/user_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

/// A provider class that manages user data and persists it to a CSV file.
/// Implements ChangeNotifier to notify listeners of any data changes.
class UserProvider with ChangeNotifier {
  /// Internal list to store user models
  List<UserModel> _users = [];

  /// Name of the CSV file where user data is stored
  final String fileName = 'users.csv';

  /// Constructor that initializes by loading existing users
  UserProvider() {
    _loadUsers();
  }

  /// Gets the local application documents directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Returns a File object pointing to the users CSV file
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  /// Loads users from the CSV file or creates default users if file doesn't exist
  Future<void> _loadUsers() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          List<List<dynamic>> csvTable =
              const CsvToListConverter().convert(contents, eol: '\n');
          _users = csvTable
              .skip(0)
              .map((row) {
                if (row.length >= 3) {
                  return UserModel(
                    email: row[0]?.toString() ?? '',
                    firstName: row[1]?.toString() ?? '',
                    lastName: row[2]?.toString() ?? '',
                  );
                }
                return null;
              })
              .whereType<UserModel>()
              .toList();
        }
      } else {
        // Create default users if file doesn't exist
        _users = [
          UserModel(
              email: "gabsonbill@yahoo.com",
              firstName: "Akimana",
              lastName: "Gabriel"),
          UserModel(
            email: "eric@yahoo.com",
            firstName: "nkurunziza",
            lastName: "Eric",
          )
        ];
        await _saveUsers();
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading users: $e');
      // Initialize with default users if there's an error
      _users = [
        UserModel(
            email: "gabsonbill@yahoo.com",
            firstName: "Akimana",
            lastName: "Gabriel"),
        UserModel(
          email: "eric@yahoo.com",
          firstName: "nkurunziza",
          lastName: "Eric",
        )
      ];
      await _saveUsers();
    }
  }

  /// Saves the current list of users to the CSV file
  Future<void> _saveUsers() async {
    try {
      final file = await _localFile;
      List<List<dynamic>> csvData = _users
          .map((user) => [
                user.email,
                user.firstName,
                user.lastName,
              ])
          .toList();
      String csv = const ListToCsvConverter()
          .convert(csvData, fieldDelimiter: ',', eol: '\n');
      await file.writeAsString(csv);
    } catch (e) {
      debugPrint('Error saving users: $e');
    }
  }

  /// Returns a list of all users
  List<UserModel> get users => List.unmodifiable(_users);

  /// Adds a new user to the list and persists to storage
  Future<void> addUser(UserModel user) async {
    if (user.email.isNotEmpty &&
        user.firstName.isNotEmpty &&
        user.lastName.isNotEmpty) {
      _users.add(user);
      await _saveUsers();
      notifyListeners();
    }
  }

  /// Removes a user from the list and updates storage
  Future<void> removeUser(UserModel user) async {
    if (_users.contains(user)) {
      _users.remove(user);
      await _saveUsers();
      notifyListeners();
    }
  }
}
