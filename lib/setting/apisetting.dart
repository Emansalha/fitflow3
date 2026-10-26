class ApiSetting {
  // الرابط الأساسي للخادم (Base URL)
  static const String baseUrl = 'https://oss.exercisedb.dev/api/v1';

  // الـ Endpoints الخاصة بالتمارين
  static const String exercisesEndpoint = '/exercises';
  static const String bodyPartsEndpoint = '/bodyparts';
  static const String musclesEndpoint = '/muscles';
  static const String equipmentsEndpoint = '/equipments';

  // روابط كاملة جاهزة للاستخدام
  static String get exercisesUrl => '$baseUrl$exercisesEndpoint';
  static String get bodyPartsUrl => '$baseUrl$bodyPartsEndpoint';
  static String get musclesUrl => '$baseUrl$musclesEndpoint';
  static String get equipmentsUrl => '$baseUrl$equipmentsEndpoint';

  // YouTube Data API Configuration
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';
  static const String youtubeSearchEndpoint = '/search';

  /// رابط البحث في فيديوهات يوتيوب باهم تمارين الجيم واللياقة
  static String youtubeSearchUrl(String query, {String apiKey = 'YOUR_YOUTUBE_API_KEY'}) =>
      '$youtubeBaseUrl$youtubeSearchEndpoint?part=snippet&q=${Uri.encodeComponent(query)}&type=video&maxResults=10&key=$apiKey';

  // Pixabay API Configuration (https://pixabay.com/api/)
  static const String pixabayBaseUrl = 'https://pixabay.com/api/';
  static const String pixabayVideosBaseUrl = 'https://pixabay.com/api/videos/';

  /// رابط جلب صور التمارين والجيم من Pixabay API
  static String pixabaySearchImagesUrl(String query, {String apiKey = 'YOUR_PIXABAY_API_KEY'}) =>
      '$pixabayBaseUrl?key=$apiKey&q=${Uri.encodeComponent(query)}&image_type=photo&per_page=15';

  /// رابط جلب فيديوهات التمارين من Pixabay API
  static String pixabaySearchVideosUrl(String query, {String apiKey = 'YOUR_PIXABAY_API_KEY'}) =>
      '$pixabayVideosBaseUrl?key=$apiKey&q=${Uri.encodeComponent(query)}&per_page=15';

  // إعدادات الـ Headers الافتراضية للطلبات
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}