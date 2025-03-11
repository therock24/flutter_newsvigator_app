abstract class RemoteArticlesEvent {
  const RemoteArticlesEvent();
}

class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}

class GetAllNews extends RemoteArticlesEvent {
  const GetAllNews();
}
