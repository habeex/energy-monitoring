part of 'network.dart';

class Network {
  static const connectTimeOut = Duration(seconds: 60);
  static const receiveTimeOut = Duration(seconds: 60);
  late Dio dio;

  final _dioBaseOptions = BaseOptions(
    connectTimeout: connectTimeOut,
    receiveTimeout: receiveTimeOut,
    baseUrl: UrlConfig.baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  Network({String? baseUrl}) {
    dio = Dio();
    dio.interceptors.add(ApiInterceptor());
    dio.options = _dioBaseOptions;
    if (baseUrl != null) dio.options.baseUrl = baseUrl;

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }

  /// Factory constructor used mainly for injecting an instance of [Dio] mock
  Network.test(this.dio);

  Future<Response> call(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formData,
    ResponseType responseType = ResponseType.json,
    String classTag = '',
    bool? showLog,
  }) async {
    Response? response;
    var params = queryParams ?? {};

    try {
      switch (method) {
        case RequestMethod.post:
          response = await dio.post(
            path,
            queryParameters: params,
            data: data,
            options: Options(responseType: responseType),
          );
          break;
        case RequestMethod.get:
          response = await dio.get(path, queryParameters: params);
          break;
        case RequestMethod.put:
          response = await dio.put(path, queryParameters: params, data: data);
          break;
        default:
          response = await dio.get(path, queryParameters: params);
          break;
      }
      return response;
    } on DioException catch (error, stackTrace) {
      final apiError = ApiError.fromDioError(error); // handle server side error
      return Future.error(apiError, stackTrace);
    } catch (_) {
      rethrow;
    }
  }
}

enum RequestMethod { post, get, put, delete, upload }
