import 'package:flutter_newsvigator_app/core/resources/data_state.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // API methods
  Future<DataState<List<ArticleEntity>>> getTopNewsArticles();

  Future<DataState<List<ArticleEntity>>> getAllNewsArticles();

  // Database methods
  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);
}
