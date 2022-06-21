import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {

  String authorName = "";
  String quote = "";

  void getAuthordata() async{
    http.Response response = await http.get(Uri.parse(
        'https://api.quotable.io/search/authors?query=$authorName'));

    if (response.statusCode==200)
    {
      var authorDecodedData = jsonDecode(response.body);
      String authorSlug = authorDecodedData['results'][0]['slug'];
      getQuoteData(authorSlug);
    }
    else
    {
      print(response.statusCode);
    }
  }

  void getQuoteData(String authorSlug) async{
    http.Response response = await http.get(Uri.parse(
        'https://api.quotable.io/quotes?author=$authorSlug'));

    if (response.statusCode==200)
    {
      var quoteDecodedData = jsonDecode(response.body);
      setState(() {
        num quoteIndex = 0 + new Random().nextInt(quoteDecodedData['lastItemIndex'] - 0);
        quote = quoteDecodedData['results'][quoteIndex]['content'];
        authorName = quoteDecodedData['results'][0]['author'];
      });
    }
    else
    {
      print(response.statusCode);
    }
  }


  Widget bottomSheetBuilder(BuildContext context){
    return Container(
      child: Column(
        children: [
          Text(quote),
          Text(authorName),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.lightBlueAccent,
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                ),
                onChanged: (value) {
                  authorName = value;
                },
              ),
              ElevatedButton(
                  onPressed: (){
                    getAuthordata();
                    showModalBottomSheet(context: context, builder: bottomSheetBuilder);
                  },
                  child: Text('Search'))
            ],
          ),
        ),
      ),
    );
  }
}
