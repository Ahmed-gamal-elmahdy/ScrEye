import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final Dio _dio = Dio();
  CancelToken _cancelToken = CancelToken();

  Future<dynamic> get(String url) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _cancelToken.cancel('Request canceled due to no internet connection');
      throw DioException(
        error: 'No internet connection',
        requestOptions: RequestOptions(path: url),
      );
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      StreamSubscription<ConnectivityResult>? subscription;
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          _cancelToken.cancel('Request canceled due to no internet connection');
          subscription!.cancel();
        }
      });

      try {
        final response = await _dio
            .get(url, cancelToken: _cancelToken)
            .timeout(const Duration(seconds: 30));
        return response;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          debugPrint('Request canceled');
        } else {
          debugPrint('Error occurred: $e');
        }
        rethrow;
      }
    }
  }

  Future<File> download(String url, String filePath) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _cancelToken.cancel('Request canceled due to no internet connection');
      throw DioException(
        error: 'No internet connection',
        requestOptions: RequestOptions(path: url),
      );
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      StreamSubscription<ConnectivityResult>? subscription;
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          _cancelToken.cancel('Request canceled due to no internet connection');
          subscription!.cancel();
        }
      });

      try {
        final response = await _dio
            .download(url, filePath, cancelToken: _cancelToken)
            .timeout(const Duration(seconds: 30));
        return File(filePath);
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          debugPrint('Request canceled');
        } else {
          debugPrint('Error occurred: $e');
        }
        rethrow;
      } catch (e) {
        throw Exception('Failed to download file: $e');
      }
    }
    throw Exception('Failed to download file: unknown error');
  }

  void cancelRequest() {
    _cancelToken.cancel('Request canceled by user');
  }
}
