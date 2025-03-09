import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_newsvigator_app/core/resources/data_state.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/usecases/get_top_articles.dart';

import '../../../../helpers/test_helper.mocks.dart'; // Import generated mock file

void main() {
  late GetTopArticlesUseCase getTopArticlesUseCase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    getTopArticlesUseCase = GetTopArticlesUseCase(mockArticleRepository);
  });

  final testArticles = [
    ArticleEntity(
      id: 1,
      author: "John Doe",
      title: "Breaking News",
      description: "A major event has happened.",
      url: "https://example.com/article",
      urlToImage: "https://example.com/image.jpg",
      publishedAt: "2025-03-06T12:36:00Z",
      content: "Full article content...",
    ),
    ArticleEntity(
      id: 2,
      author: "Jane Smith",
      title: "Technology Update",
      description: "Latest tech trends in 2025.",
      url: "https://example.com/tech",
      urlToImage: "https://example.com/tech_image.jpg",
      publishedAt: "2025-03-06T14:00:00Z",
      content: "Tech news content...",
    ),
  ];

  test(
    'should get top articles from the repository',
        () async {
      // Arrange: Mock the repository to return test data
      when(mockArticleRepository.getTopNewsArticles())
          .thenAnswer((_) async => DataSuccess(testArticles));

      // Act: Call the use case
      final result = await getTopArticlesUseCase.call();

      // Assert: Check if it returns the correct data
      expect(result, isA<DataSuccess<List<ArticleEntity>>>());
      expect(result.data, testArticles);
      verify(mockArticleRepository.getTopNewsArticles()).called(1);
      verifyNoMoreInteractions(mockArticleRepository);
    },
  );
}
