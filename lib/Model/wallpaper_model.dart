class WallpaperModel {

  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel({this.photographer, this.photographer_url, this.photographer_id, this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
      photographer_url: jsonData['photographer_url']
    );
  }


}


class SrcModel {

  String original;
  String small;
  String potrait;

  SrcModel({this.original, this.small, this.potrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      potrait: jsonData['portrait'],
      original: jsonData['original'],
      small: jsonData['small']
    );
  }
}