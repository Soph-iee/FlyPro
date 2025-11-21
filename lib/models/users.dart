import 'dart:convert';
import 'package:flypro_expense_tracker/data/mock_users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }
}

class AuthService {
  static const String userKey = 'logged_in_user';

  Future<http.Response> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    final user = mockUsers.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return http.Response(
        jsonEncode({'success': false, 'message': 'Invalid credentials'}),
        401,
      );
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, jsonEncode(user));

    final response = {
      'success': true,
      'token': 'mock_jwt_token_12345',
      'user': user,
    };

    return http.Response(jsonEncode(response), 200);
  }

  // forgot password logic
  Future<http.Response> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = mockUsers.firstWhere(
      (u) => u['email'] == email,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return http.Response(
        jsonEncode({
          'success': false,
          'message': 'THis email is not registered',
        }),
        401,
      );
    }

    return http.Response(
      jsonEncode({
        'success': true,
        'message': 'this is your password: ${user['password']}',
        'user':user
      }),
      200,
    );
  }
  // logout logic

  Future<http.Response> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    final response = {
      'success': true,
      'message': 'logout successful',
    };

    return http.Response(jsonEncode(response), 200);
  }

  Future<http.Response> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);
    if (data == null) {
      final response = {
        'success': false,
        'message': 'No user logged in',
      };

      return http.Response(jsonEncode(response), 200);
    } else {
      final response = {
        'success': true,
        'message': 'user session active',
        'data': jsonDecode(data),
      };
      return http.Response(jsonEncode(response), 200);
    }
  }
}

class AuthRepository {
  final AuthService _service = AuthService();

  Future<UserModel?> login(String email, String password) async {
    final res = await _service.login(email, password);
    final body = jsonDecode(res.body);

    if (res.statusCode == 200 && body['success']) {
      return UserModel.fromMap(body['user']);
    }
    return null;
  }

  Future<UserModel?> forgotPassword(String email) async {
    final res = await _service.forgotPassword(email);
    final body = jsonDecode(res.body);

    if (res.statusCode == 200 && body['success']) {
      return UserModel.fromMap(body['user']);
    }
    return null;
  }
}
