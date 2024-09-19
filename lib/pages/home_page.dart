import 'package:flutter/material.dart';

import 'get_page.dart';
import 'post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final colorScheme = appTheme.colorScheme;
    final textTheme = appTheme.textTheme;

    Widget selectedPage;
    switch (selectedIndex) {
      case 0:
        selectedPage = const GetPage();
      case 1:
        selectedPage = const PostPage();
      // case 2:
      //   selectedPage = const PutPage();
      // case 3:
      //   selectedPage = const DeletePage();
      default:
        selectedPage = const Placeholder();
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainer,
      child: AnimatedSwitcher(
        duration: Durations.long2,
        child: selectedPage,
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.inversePrimary,
          title: Text(
            'Consume API',
            style: textTheme.titleLarge!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: mainArea),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              showUnselectedLabels: false,
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  if (value == 2 || value == 3) {
                    return;
                  }
                  selectedIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.article_outlined),
                  label: 'Get',
                  tooltip: 'Get',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add_outlined),
                  label: 'Post',
                  tooltip: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_document),
                  label: 'Put',
                  tooltip: 'Put',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.delete_outline),
                  label: 'Delete',
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
