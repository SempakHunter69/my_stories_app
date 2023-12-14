import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_stories_app/data/api/api_service.dart';
import 'package:my_stories_app/data/model/stories_response.dart';
import 'package:my_stories_app/data/model/upload_response.dart';
import 'package:my_stories_app/provider/preferences_provider.dart';
import 'package:my_stories_app/utils/result_state.dart';
import 'dart:typed_data';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final PreferencesProvider preferencesProvider;

  StoryProvider({
    required this.apiService,
    required this.preferencesProvider,
  }) {
    _fetchAllStories();
  }

  late ResultState _state;
  String _message = '';
  late StoriesResponse _storiesResponse;
  late Story _story;
  String? imagePath;
  XFile? imageFile;
  bool isUploading = false;
  UploadResponse? uploadResponse;

  String get message => _message;
  StoriesResponse get result => _storiesResponse;
  ResultState get state => _state;
  Story get story => _story;

  Future<dynamic> _fetchAllStories() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final String? token = await preferencesProvider.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final stories = await apiService.fetchStories(token);
      if (stories.listStory.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Stories';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _storiesResponse = stories;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }

  Future<void> fetchStoryDetails(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final String? token = await preferencesProvider.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final storyInfo = await apiService.fetchStoryDetails(id, token);
      _state = ResultState.hasData;
      notifyListeners();
      _story = storyInfo.story;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> upload(
    Uint8List bytes,
    String fileName,
    String description,
  ) async {
    try {
      _message = '';
      uploadResponse = null;
      isUploading = true;
      notifyListeners();
      final String? token = await preferencesProvider.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      uploadResponse = await apiService.uploadDocument(
          Uint8List.fromList(bytes), fileName, description, token);
      _message = uploadResponse?.message ?? 'success';
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<Uint8List> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return Uint8List.fromList(bytes);

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    Uint8List newByte = Uint8List.fromList(bytes);

    do {
      compressQuality -= 10;
      newByte = Uint8List.fromList(
        img.encodeJpg(image, quality: compressQuality),
      );
      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<Uint8List> resizeImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return Uint8List.fromList(bytes);

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    bool isWidthMoreTaller = image.width > image.height;
    int imageTall = isWidthMoreTaller ? image.width : image.height;
    double compressTall = 1;
    int length = imageLength;
    Uint8List newByte = Uint8List.fromList(bytes);

    do {
      compressTall -= 0.1;
      final newImage = img.copyResize(
        image,
        width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
        height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      );
      length = newImage.length;
      if (length < 1000000) {
        newByte = Uint8List.fromList(img.encodeJpg(newImage));
      }
    } while (length > 1000000);

    return newByte;
  }
}
