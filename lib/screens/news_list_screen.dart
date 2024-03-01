import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';
import 'package:news_flutter/services/news_service.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {


  const NewsListScreen( {super.key, });

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = NewsService.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.blueAccent,
            )),
        title:  Center(child: Text("Danh sách món ăn",
          style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 16,
            ),
          )
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.blueAccent,
              ))
        ],
      ),
      body: FutureBuilder<List<News>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final news = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(news.title),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(news.contentBlocks[2].content),
                            Text(news.contentBlocks[3].content),
                            Text("Rating:")
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                    leading: Image.network(
                      news.contentBlocks[1].content,
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(news: news),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
