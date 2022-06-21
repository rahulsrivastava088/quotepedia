import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String enteredTpoic = "";
  int quoteLimit = 10;
  List<displayQuote> dispQuote = [];

  void getQuoteData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.quotable.io/search/quotes?query=$enteredTpoic&limit=10'));

    if (response.statusCode == 200) {
      setState(() {
        var quoteDecodedData = jsonDecode(response.body);
        dispQuote.clear();
        for (int i = 0; i < quoteLimit; i++) {
          dispQuote.add(
            displayQuote(
                quoteDecodedData['results'][i]['content'],
                quoteDecodedData['results'][i]['author'],
              ),
          );
        }
      });
    } else {
      print(response.statusCode);
    }
  }

  Widget bottomSheetBuilder(BuildContext context) {
    return Container(
      child: ListView(
        children: dispQuote,
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
                  hintText: 'Enter Desired Topic',
                ),
                onChanged: (value) {
                  enteredTpoic = value;
                },
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter Desired Frequency',
                ),
                onChanged: (value) {
                  quoteLimit = value as int;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    getQuoteData();
                    showModalBottomSheet(
                        context: context, builder: bottomSheetBuilder);
                  },
                  child: Text('Search'))
            ],
          ),
        ),
      ),
    );
  }
}

class displayQuote extends StatelessWidget {

  String quote="";
  String author="";

  displayQuote(quote, author);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Text(quote),
                Text(author),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




