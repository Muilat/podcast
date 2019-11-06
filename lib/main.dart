import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcast/player_page.dart';
import 'package:podcast/podcast.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

String feedUrl = "https://itsallwidgets.com/podcast/feed";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => Podcast()..parseRss(feedUrl),
      child: Consumer<Podcast>(
        builder: (context, podcast, _) {
//        print(podcast.feed);
          return Material(
            child: Scaffold(
              appBar:  AppBar(
                title: Row(
                  children: [Text("Flutter Podcast"), Icon(Icons.headset_mic)],
                ),
                backgroundColor: Colors.blueGrey,

              ),
              body: podcast.feed == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                  children: podcast.feed.items
                    .map(
                      (i) => ListTile(
                        title: Text(i.title),
                        subtitle: Text(
                          i.description.trim(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
  //                            Provider.of<Podcast>(context).selectedItem = i;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (__) => PlayerPage(
                                item: i,
                                imageScr: Provider.of<Podcast>(context)
                                    .feed
                                    .image,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),

                  ),
            ),
          );
        },
      ),
    );
  }
}
