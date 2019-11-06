import 'package:flutter/material.dart';
import 'package:podcast/play_control.dart';
import 'package:webfeed/domain/rss_item.dart';

class PlayerPage extends StatefulWidget {
  final RssItem item;
  final imageScr;

  const PlayerPage({Key key, this.item, this.imageScr});

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                widget.imageScr.url,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              flex: 0,
              child: Container(
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    PlayControls(
                      url: item.guid,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
