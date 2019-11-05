import 'package:flutter/material.dart';
import 'package:podcast/play_control.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => Podcast()..parseRss(feedUrl),
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Podcast>(
        builder: (context, podcast, _) {
//        print(podcast.feed);
          return podcast.feed == null
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
                            Provider.of<Podcast>(context).selectedItem = i;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (__) => PlayerPage(),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                );
        },
      ),
    );
  }
}

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<Podcast>(context).selectedItem.title),
      ),
      body: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Flexible(
//                flex: 1,
//                child: Placeholder(),
//              ),
//              Flexible(
//                flex: 0,
//                child: Container(
//                  color: Colors.blueGrey,
//                  child: Column(
//                    children: [PlayControls(),],
//                  ),
//                ),
//              )
//            ],
//          ),
          ),
    );
  }
}
