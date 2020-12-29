import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/Data/data.dart';
import 'package:wallpaper_app/Model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widget.dart';

class Category extends StatefulWidget {
  final String catagori;
  Category({@required this.catagori});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = List();

  getSearchWallpapers() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.catagori}&per_page=5000&page=1",
        headers: {"Authorization": apiKey}).then((value) {
      Map<String, dynamic> jsonData;
      jsonData = jsonDecode(value.body);

      jsonData['photos'].forEach((element) {
        //print(element);
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });
      setState(() {});
    });
    //print(response.body);
  }

  @override
  void initState() {
    getSearchWallpapers();
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
              SizedBox(
                height: 20,
              ),
              wallpapersList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}
