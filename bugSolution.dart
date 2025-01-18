```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Process jsonData
    } else {
      // Handle specific HTTP error codes
      throw HttpException('HTTP error: ${response.statusCode}', response.body);
    }
  } on SocketException {
    // Handle socket exceptions (network errors)
    print('Network error: Could not connect to the server.');
  } on FormatException {
    // Handle JSON decoding errors
    print('JSON format error: Invalid JSON response.');
  } on HttpException catch (e) {
    // Handle specific HTTP exceptions
    print('HTTP error: ${e.message}');
  } catch (e) {
    // Handle other exceptions
    print('Unexpected error: $e');
  }
}

// Custom exception class for HTTP errors
class HttpException implements Exception {
  final String message;
  final String? responseBody;

  HttpException(this.message, this.responseBody);

  @override
  String toString() => 'HttpException: $message $responseBody';
}
```