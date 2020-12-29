import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/Model/wallpaper_model.dart';
import 'package:wallpaper_app/Views/image_view.dart';

Widget brandName() {
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     Text('Wallpaper'),
  //     Text('App', style: TextStyle(color: Colors.black)),
  //   ],
  // );

  return Center(
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Wallpaper',
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: 'App',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    ),
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, context) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imageUrl: wallpaper.src.potrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.potrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(imageUrl: wallpaper.src.potrait, fit: BoxFit.cover,),
                    ),
              ),
            ),
          ));
        }).toList(),
      ),
    ),
  );
}
