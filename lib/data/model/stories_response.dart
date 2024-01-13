import 'package:json_annotation/json_annotation.dart';

part 'stories_response.g.dart';

@JsonSerializable()
class StoriesResponse {
  final bool error;
  final String message;
  @JsonKey(name: "listStory")
  final List<Story> listStory;

  StoriesResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$StoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesResponseToJson(this);
}

@JsonSerializable()
class StoriesDetailResponse {
  final bool error;
  final String message;
  final Story story;

  StoriesDetailResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoriesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesDetailResponseToJson(this);
}

@JsonSerializable()
class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double? lat;
  final double? lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
