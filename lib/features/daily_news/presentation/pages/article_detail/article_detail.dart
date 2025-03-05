import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart'; // Import intl package
import '../../../../../di/injection_container.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';
import '../../bloc/article/local/local_article_event.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: const Icon(Ionicons.chevron_back, color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article?.title ?? "No Title",
            style: const TextStyle(
              fontFamily: 'Butler',
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 14),

          // DateTime (Formatted)
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                _formatDate(article?.publishedAt),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "Unknown date";
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMMM d, y • h:mm a').format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        image: article?.urlToImage != null && article!.urlToImage!.isNotEmpty
            ? DecorationImage(
          image: NetworkImage(article!.urlToImage!),
          fit: BoxFit.cover,
        )
            : null,
        color: Colors.grey[200], // Placeholder color
      ),
      child: article?.urlToImage == null || article!.urlToImage!.isEmpty
          ? const Center(child: Icon(Icons.image_not_supported, size: 50))
          : null,
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article?.description ?? "No description available."}\n\n${article?.content ?? ""}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        backgroundColor: Colors.black,
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    if (article != null) {
      BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text('Article saved successfully.'),
        ),
      );
    }
  }
}
