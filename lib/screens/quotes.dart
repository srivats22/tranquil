import 'package:being_u/api_related/quote_api_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  late Future<QuoteApiResponse> quotes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quotes = quoteData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuoteApiResponse>(
      future: quotes,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(snapshot.data!.content,
              style: GoogleFonts.novaRound(
                fontSize: 20, fontStyle: FontStyle.italic,
              ),),
              SizedBox(height: 10,),
              Text("-" + snapshot.data!.authorName, style: TextStyle(fontSize: 18),),
            ],
          );
        }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
