import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future getPosts(bool isLoaded) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(isLoaded == false) {
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbzDYQgIOF4uRFqHe0b3UaTDG_iiIpyvxJ8n27uUv-HqpyxPcqZW/exec');
    if (response.statusCode == 200) {
      await prefs.setString('posts', response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  } else {
    return json.decode(prefs.getString('posts'));
  }
}