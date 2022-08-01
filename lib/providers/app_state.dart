import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppState with ChangeNotifier {
  bool _isUpdate = true;
  String _version = '';

  bool get isUpdate {
    return _isUpdate;
  }

  String get version {
    return _version;
  }

  updateAppState(bool isUpdate) {
    _isUpdate = isUpdate;
    notifyListeners();
  }

  Future<void> fetchAppState() async {
    final url = Uri.parse('http://localhost:3009/api/update');

    try {
      final res = await http.get(url);
      final responseData = json.decode(res.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _version = responseData['version'];
      _isUpdate = responseData['isUpdate'];
      print(responseData);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
