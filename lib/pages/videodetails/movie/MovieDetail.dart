import 'package:json_annotation/json_annotation.dart';

/// @Description :
/// @Author : fong
/// @Date:  2024/4/14  12:05


part 'MovieDetail.g.dart';
@JsonSerializable()
class MovieDetail {
  String title;
  String image;
  String category;
  String region;
  String year;
  String director;
  String protagonist;
  String status;
  String briefIntroduction;
  String contentIntroduction;
  int total;
  MovieDetail(
      {required this.title,
        required this.image,
        required this.category,
        required this.region,
        required this.year,
        required this.director,
        required this.protagonist,
        required this.status,
        required this.briefIntroduction,
        required this.contentIntroduction,
        required this.total});

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}