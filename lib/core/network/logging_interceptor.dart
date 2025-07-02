import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger('Dio');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info(
        '--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}');
    _logger.info('Headers:');
    options.headers.forEach((k, v) => _logger.info('$k: $v'));
    _logger.info('Query Parameters:');
    options.queryParameters.forEach((k, v) => _logger.info('$k: $v'));
    if (options.data != null) {
      _logger.info('Body: ${options.data}');
    }
    _logger.info('--> END ${options.method.toUpperCase()}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
        '<-- ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    _logger.info('Response: ${response.data}');
    _logger.info('<-- END');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe(
        '!!! ERROR [${err.response?.statusCode}] ${err.requestOptions.method.toUpperCase()} ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    _logger.severe('Error: ${err.error}');
    _logger.severe('Response: ${err.response?.data}');
    _logger.severe('!!! END ERROR');
    return super.onError(err, handler);
  }
}
