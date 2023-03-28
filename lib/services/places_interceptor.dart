
import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {

  final String _apiKey = 'pk.eyJ1Ijoid2lsbGlhbWl0eiIsImEiOiJjbGZoOHNrOGMxNGE3M3dtOG92ZHRia3lqIn0.AuCElZ4TwUXRLhM731aPbw';
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'language': 'es',
      'access_token': _apiKey
    });

    super.onRequest(options, handler);
  }

}
