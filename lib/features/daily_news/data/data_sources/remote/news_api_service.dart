import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';

import '../../models/get_news_response.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<GetNewsResponse>> getTopNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });

  @GET('/everything')
  Future<HttpResponse<GetNewsResponse>> getAllNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("q") String? searchQuery,
    @Query("from") String? from,
    @Query("sortBy") String? sortBy,
  });
}
