import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:customer_app_mob/config/constants/url.dart';
import 'package:customer_app_mob/config/dio/auth_interceptor.dart';

class FileDownload {
  FileDownload(
      {required this.url, required this.filename, this.queryParameters});

  Dio dio = Dio();
  bool isSuccess = false;
  String filename;
  String url;
  Map<String, dynamic>? queryParameters;

  void startDownloading(BuildContext context, final Function okCallback) async {
    String path = await getFilePath(filename);
    dio.options = BaseOptions(baseUrl: AppConstant.apiUrlDevAndroid);
    dio.interceptors.addAll([
      AuthInterceptor(),
      PrettyDioLogger(
        request: true,
        error: true,
        compact: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
      ),
    ]);

    try {
      await dio.download(
        url,
        path,
        queryParameters: queryParameters,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;

        // Open file after download.
        openFile(path);
      });
    } catch (e) {
      log('Exception$e');
    }

    if (context.mounted && isSuccess) {
      Navigator.pop(context);
    }
  }

  Future<OpenResult?> openFile(String filePath) async {
    if (filePath.isNotEmpty) {
      final res = await OpenFilex.open(filePath);
      // ResultType
      final type = res.type.name;
      final msg = res.message;
      log('Open file: $msg $type');
      return res;
    }
    return null;
  }

  Future<String> getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      log('Cannot get download folder path $err');
    }
    return '${dir?.path}$filename';
  }
}
