import 'package:flutter/material.dart';
import 'package:quotepedia/screens/author_screen.dart';
import 'package:quotepedia/screens/favourite_screen.dart';
import 'package:quotepedia/screens/search_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AuthorScreen();
                      },
                    ),
                  );
                },
                child: Text('Author Quote'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ),
                );},
                child: Text('Search Quote'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FavouriteScreen();
                      },
                    ),
                  );
                },
                child: Text('Favourite Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
