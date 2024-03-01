import 'package:flutter/material.dart';
import 'package:news_flutter/screens/news_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=> RatingModel(),
    child:MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsListScreen(),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}

class RatingModel extends ChangeNotifier {
  final Map<int, double> _ratings = {};

  // Method to update rating for a specific article ID
  void updateRating(int articleId, double newRating) {
    _ratings[articleId] = newRating;
    notifyListeners();
  }

  // Method to get rating for a specific article ID
  double? getRating(int articleId) {
    return _ratings[articleId];
  }
}

