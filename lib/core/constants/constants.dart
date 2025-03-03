import 'package:flutter_dotenv/flutter_dotenv.dart';

const String newsAPIBaseURL = 'https://newsapi.org/v2';
final String newsAPIKey = dotenv.env['NEWS_API_KEY'] ?? '';
const String countryQuery = 'us';
const String categoryQuery = 'general';
const String kDefaultImage = "https://coffective.com/wp-content/uploads/2018/06/default-featured-image.png.jpg";