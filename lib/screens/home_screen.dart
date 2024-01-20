// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/data/model/stories_response.dart';
import 'package:my_stories_app/provider/navigation_provider.dart';
import 'package:my_stories_app/provider/preferences_provider.dart';
import 'package:my_stories_app/provider/story_provider.dart';
import 'package:my_stories_app/screens/profile_screen.dart';
import 'package:my_stories_app/screens/upload_screen.dart';
import 'package:my_stories_app/utils/result_state.dart';
import 'package:my_stories_app/widgets/story_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Function(Story) onTapped;
  final Function() isLogout;
  final Function() selectLocation;
  final Function(double lat, double lon) cekLokasi;
  const HomeScreen({
    super.key,
    required this.isLogout,
    required this.onTapped,
    required this.selectLocation,
    required this.cekLokasi,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final storyProvider = context.read<StoryProvider>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyProvider.pageItems != null) {
          storyProvider.fetchStories();
        }
      }
    });

    Future.microtask(() async => storyProvider.fetchStories());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.file_upload_outlined),
        label: 'Upload',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      )
    ];

    onLogout() async {
      final preferencesProvider = context.read<PreferencesProvider>();
      await preferencesProvider.clearToken();
      if (!preferencesProvider.isTokenAvailable) {
        widget.isLogout();
      }
    }

    Widget buildList(BuildContext context) {
      return Consumer<StoryProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return RefreshIndicator(
            onRefresh: () async {
              await state.fetchAllStories();
            },
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: state.result.listStory.length +
                  (state.pageItems != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.result.listStory.length &&
                    state.pageItems != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final stories = state.result.listStory[index];
                return InkWell(
                    onTap: () {
                      Provider.of<StoryProvider>(context, listen: false)
                          .fetchStoryDetails(stories.id);
                      widget.onTapped(stories);
                    },
                    child: StoryWidget(
                      story: stories,
                    ));
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Text('No data'),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Something when wrong'),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Cocials',
          style: myTextTheme.headline2!.copyWith(color: primaryYellow2),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                onLogout();
              },
              icon: context.watch<PreferencesProvider>().isLogout
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.logout)),
        ],
      ),
      body: IndexedStack(
        index: navigationProvider.currentIndex,
        children: [
          buildList(context),
          UploadScreen(
            selectLocation: widget.selectLocation,
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        items: bottomNavItems,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        onTap: (index) => navigationProvider.currentIndex = index,
      ),
    );
  }
}
