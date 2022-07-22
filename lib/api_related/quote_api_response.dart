import 'dart:convert';

import 'package:being_u/common.dart';
import 'package:http/http.dart' as http;

Future<QuoteApiResponse> quoteData() async{
  final response = await http.get(Uri.parse("$quotesApi"));
  if(response.statusCode == 200){
    return QuoteApiResponse.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get quote');
  }
}

class QuoteApiResponse{
  final String content;
  final String authorName;

  QuoteApiResponse({
    required this.content, required this.authorName
  });

  factory QuoteApiResponse.fromJson(Map<String, dynamic> json){
    return QuoteApiResponse(
      content: json['content'],
      authorName: json['author'],
    );
  }
}