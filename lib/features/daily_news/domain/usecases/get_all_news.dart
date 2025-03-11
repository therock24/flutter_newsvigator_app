import 'package:flutter_newsvigator_app/core/resources/data_state.dart';
import 'package:flutter_newsvigator_app/core/usecase/usecase.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/repository/article_repository.dart';

class GetAllNewsUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetAllNewsUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getAllNewsArticles();
  }
}
