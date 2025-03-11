import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsvigator_app/core/resources/data_state.dart';
import 'package:flutter_newsvigator_app/features/daily_news/domain/usecases/get_top_articles.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../domain/usecases/get_all_news.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetTopArticlesUseCase _getArticleUseCase;
  final GetAllNewsUseCase _getAllNewsUseCase;

  RemoteArticlesBloc(this._getArticleUseCase, this._getAllNewsUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
    on<GetAllNews>(onGetAllNews);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticlesState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }

  void onGetAllNews(GetAllNews event, Emitter<RemoteArticlesState> emit) async {
    final dataState = await _getAllNewsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
