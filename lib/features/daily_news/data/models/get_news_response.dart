import 'package:flutter_newsvigator_app/features/daily_news/data/models/article.dart';

class GetNewsResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  GetNewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory GetNewsResponse.fromJson(Map<String, dynamic> json) {
    return GetNewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      articles: (json['articles'] as List<dynamic>?)
              ?.map((article) => ArticleModel.fromJson(article))
              .toList() ??
          [],
    );
  }
}
