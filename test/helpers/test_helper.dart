import 'package:flutter_newsvigator_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/usecases/get_top_articles.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

@GenerateMocks(
  [
    ArticleRepository,
    NewsApiService,
    GetTopArticlesUseCase
  ],
  customMocks: [MockSpec<Dio>(as: #MockDioClient)],
)

void main() {}