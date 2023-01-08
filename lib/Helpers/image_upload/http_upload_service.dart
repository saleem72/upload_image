//

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'upload_file_response.dart';

typedef OnDownloadProgressCallback = void Function(
    int receivedBytes, int totalBytes);
typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class HttpUploadService {
  static String apiKey = 'a75400525c218109de6f9f63227f6416';

  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static Future<UploadFileResponse?> fileUploadMultipart({
    // required String url,
    required File file,
    required OnUploadProgressCallback onUploadProgress,
  }) async {
    const url = 'https://api.imgbb.com/1/upload';
    final Map<String, dynamic> queryParameters = {"key": apiKey};
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    final httpClient = getHttpClient();
    final request = await httpClient.postUrl(uri);

    int byteCount = 0;

    var multipart = await http.MultipartFile.fromPath(
      "image",
      file.path,
      contentType: MediaType('image', 'jpeg'),
    );

    var requestMultipart = http.MultipartRequest("POST", uri)
      ..files.add(multipart);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader] ?? '');

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          onUploadProgress(byteCount, totalByteLength);
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();

    try {
      final respStr = await readResponseAsString(httpResponse);
      final result = UploadFileResponse.fromJson(respStr);
      return result;
    } on Exception {
      rethrow;
    }
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(convert.utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
