// To parse this JSON data, do
//
//     final getVideoModel = getVideoModelFromJson(jsonString);

import 'dart:convert';

GetVideoModel getVideoModelFromJson(String str) => GetVideoModel.fromJson(json.decode(str));

String getVideoModelToJson(GetVideoModel data) => json.encode(data.toJson());

class GetVideoModel {
  List<dynamic>? user;
  List<dynamic>? banners;
  List<CategoryDict>? categoryDict;
  List<Result>? results;
  bool? status;
  bool? next;

  GetVideoModel({
    this.user,
    this.banners,
    this.categoryDict,
    this.results,
    this.status,
    this.next,
  });

  factory GetVideoModel.fromJson(Map<String, dynamic> json) => GetVideoModel(
        user: List<dynamic>.from(json["user"].map((x) => x)),
        banners: List<dynamic>.from(json["banners"].map((x) => x)),
        categoryDict: List<CategoryDict>.from(json["category_dict"].map((x) => CategoryDict.fromJson(x))),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user!.map((x) => x)),
        "banners": List<dynamic>.from(banners!.map((x) => x)),
        "category_dict": List<dynamic>.from(categoryDict!.map((x) => x.toJson())),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
        "next": next,
      };
}

class CategoryDict {
  String? id;
  String? title;

  CategoryDict({
    this.id,
    this.title,
  });

  factory CategoryDict.fromJson(Map<String, dynamic> json) => CategoryDict(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Result {
  int? id;
  String? description;
  String? image;
  String? video;
  List<int>? likes;
  List<dynamic>? dislikes;
  List<dynamic>? bookmarks;
  List<int>? hide;
  String? createdAt;
  bool? follow;
  User? user;

  Result({
    this.id,
    this.description,
    this.image,
    this.video,
    this.likes,
    this.dislikes,
    this.bookmarks,
    this.hide,
    this.createdAt,
    this.follow,
    this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        likes: List<int>.from(json["likes"].map((x) => x)),
        dislikes: List<dynamic>.from(json["dislikes"].map((x) => x)),
        bookmarks: List<dynamic>.from(json["bookmarks"].map((x) => x)),
        hide: List<int>.from(json["hide"].map((x) => x)),
        createdAt: json["created_at"],
        follow: json["follow"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "image": image,
        "video": video,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "dislikes": List<dynamic>.from(dislikes!.map((x) => x)),
        "bookmarks": List<dynamic>.from(bookmarks!.map((x) => x)),
        "hide": List<dynamic>.from(hide!.map((x) => x)),
        "created_at": createdAt,
        "follow": follow,
        "user": user!.toJson(),
      };
}

class User {
  int? id;
  String? name;
  dynamic image;

  User({
    this.id,
    this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
