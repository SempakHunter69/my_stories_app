import 'package:flutter/material.dart';
import 'package:my_stories_app/data/api/api_service.dart';
import 'package:my_stories_app/data/model/stories_response.dart';
import 'package:my_stories_app/provider/preferences_provider.dart';
import 'package:my_stories_app/utils/result_state.dart';

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
      print('$e');
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
}
