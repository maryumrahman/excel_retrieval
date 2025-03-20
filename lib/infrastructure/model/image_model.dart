import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class ImageModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? recipeId;
  @HiveField(2)
  String? imageLink;
  bool updated;

  ImageModel({
    this.id,
    this.recipeId,
    this.imageLink,
    this.updated = false,
  });

  ImageModel copyWith({
    dynamic timeStamp,
    int? id,
    int? recipeId,
    String? imageLink,
    bool? updated,
  }) =>
      ImageModel(
        id: id ?? this.id,
        recipeId: recipeId ?? this.recipeId,
        imageLink: imageLink ?? this.imageLink,
        updated: updated ?? this.updated,
      );

  factory ImageModel.fromJson(Map<String, dynamic> json, String idKey,
      String sourceIdKey, String imageLinkKey) =>
      ImageModel(
        id: json[idKey],
        recipeId: json[sourceIdKey],
        imageLink: json[imageLinkKey],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipe_Id": recipeId,
    "imageLink": imageLink,
  };
}
