import 'package:flutter/material.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/all_news/all_news.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';
import '../../features/daily_news/presentation/pages/top_headlines/top_headlines.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TopHeadlineNews());

      case '/AllNews':
        return _materialRoute(const AllNews());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const TopHeadlineNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
