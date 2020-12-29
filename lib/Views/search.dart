import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/Data/data.dart';
import 'package:wallpaper_app/Model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> wallpapers = List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=150&page=1",
        headers: {"Authorization": apiKey});
    //print(response.body);

    Map<String, dynamic> jsonData;
    jsonData = jsonDecode(response.body);

    jsonData['photos'].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 10.0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none),
                        controller: searchController,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          getSearchWallpapers(searchController.text);
                          
                        },
                        child: Icon(Icons.search)),
                  ],
                ),
              ),
              wallpapersList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}
