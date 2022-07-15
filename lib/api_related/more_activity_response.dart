import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<MoreActivityResponse> fetchData() async {
  final rand = Random();
  final category = rand.nextInt(3);
  print(category);
  final categoryList = ["recreational", "diy", "relaxation"];
  print(categoryList.elementAt(category));
  final response = await
  http.get(Uri.parse('https://www.boredapi.com/api/activity?type=${categoryList.elementAt(category)}'));
  if(response.statusCode == 200){
    print("Got inside call");
    print(jsonDecode(response.body));
    return MoreActivityResponse.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MoreActivityResponse{
  final String activity;
  final String type;
//   final int participants;
//   final int price;
  final String link;
//   final String key;
//   final double accessibility;

  MoreActivityResponse({
    required this.activity,
    required this.type,
//     required this.participants,
//     required this.price,
    required this.link,
//     required this.key,
//     required this.accessibility,
  });

  factory MoreActivityResponse.fromJson(Map<String, dynamic> json) {
    return MoreActivityResponse(
      activity: json['activity'],
      type: json['type'],
//       participants: json['participants'],
//       price: json['price'],
      link: json['link'],
//       key: json['key'],
//       accessibility: json['accessibility']
    );
  }
}