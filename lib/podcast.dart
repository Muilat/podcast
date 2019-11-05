import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Podcast with ChangeNotifier{

  RssFeed feed;
  RssItem _selectedItem;

  void parseRss(String feedUrl) async{
    final response = await http.get(feedUrl);
    final xmlString = response.body;

    feed = RssFeed.parse(xmlString);
    notifyListeners();
  }
  RssItem get selectedItem => _selectedItem;

  set selectedItem(RssItem rssItem){
    _selectedItem = rssItem;
    notifyListeners();
  }
}

