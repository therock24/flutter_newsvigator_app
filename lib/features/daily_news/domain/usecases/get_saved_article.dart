import 'package:flutter_newsvigator_app/core/usecase/usecase.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
