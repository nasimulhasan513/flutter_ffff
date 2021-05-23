import 'package:http/http.dart' as http;
import 'dart:convert';

/// A widget that has mutable state.
/// This recieve url as constructor parameter
///  ## Performance considerations
class Api {
  final String url;

  Api(this.url);

  getMyData() async {
    // this works good for api calling
    try {
      var response = await http.get(Uri.parse(this.url));
      return jsonDecode(response.body);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  postData(int row, String status) async {
    try {
      print('$row $status');
      var response = await http.get(
        Uri.parse("${this.url}?status=$status&row=$row"),
      );
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }
}
