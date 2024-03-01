import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'news_list_screen.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;

  const NewsDetailScreen({super.key,  required this.news});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ratingModel = Provider.of<RatingModel>(context);
    double initialRating = ratingModel.getRating(widget.news.id) ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title,style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 16,
        ),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.news.contentBlocks.map((block) {
              // Using widget.news
              if (block.type == 'text') {
                return Column(
                  children: [
                    Text(block.content),
                    const SizedBox(height: 10),
                  ],
                );
              } else if (block.type == 'image') {
                return CachedNetworkImage(
                  imageUrl: block.content,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              } else {
                return const SizedBox.shrink();
              }
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Ratting"),
                RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 0.5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingModel.updateRating(widget.news.id, rating);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text( "Đánh giá: ${initialRating}"),
            const SizedBox(height:10),
            const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Số lượng',
                ),
              ),
            SizedBox(height:10),
            TextButton(style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),onPressed:() => {
              Navigator.push(context, MaterialPageRoute(builder: (context){
              return NewsListScreen();
                }
              )
              )} , child: Text("Order")),

          ],
        ),
      ),
    );
  }
}
