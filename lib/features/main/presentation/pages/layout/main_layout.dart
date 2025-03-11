import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/all_news/all_news.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/top_headlines/top_headlines.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // Define pages for navigation
  final List<Widget> _pages = [
    const TopHeadlineNews(), // Home Page
    const SavedArticles(), // Saved Articles Page
    const AllNews() // All news
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      drawer: _buildDrawer(),
      body: IndexedStack(
        // This keeps the state of pages while switching
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }

  /// ✅ Persistent AppBar
  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Top Headline News',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  /// ✅ Persistent Drawer
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'App Sections',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(Icons.home, "Top News", 0),
          _buildDrawerItem(Icons.bookmark, "Saved Articles", 1),
          _buildDrawerItem(Icons.settings, "All News", 2),
        ],
      ),
    );
  }

  /// Drawer Item Builder
  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
          Navigator.pop(context); // Close the drawer
        });
      },
    );
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    setState(() {
      _selectedIndex = 1;
    });
  }
}
