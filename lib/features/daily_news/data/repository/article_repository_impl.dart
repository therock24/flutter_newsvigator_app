import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_newsvigator_app/core/constants/constants.dart';
import 'package:flutter_newsvigator_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_newsvigator_app/features/daily_news/data/models/article.dart';
import 'package:flutter_newsvigator_app/core/resources/data_state.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/repository/article_repository.dart';

import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getTopNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getTopNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<List<ArticleEntity>>> getAllNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getAllNewsArticles(
        apiKey: newsAPIKey,
        searchQuery: 'bitcoin'
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
