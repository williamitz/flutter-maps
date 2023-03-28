import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {

  final String _apiKey = 'pk.eyJ1Ijoid2lsbGlhbWl0eiIsImEiOiJjbGZoOHNrOGMxNGE3M3dtOG92ZHRia3lqIn0.AuCElZ4TwUXRLhM731aPbw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'language': 'es',
      'overview': 'simplified',
      'steps': false,
      'access_token': _apiKey
    });

    super.onRequest(options, handler);
  }
  
}