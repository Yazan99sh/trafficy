import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/module_upload/response/imgbb/imgbb_response.dart';
import 'package:trafficy_client/utils/logger/logger.dart';

@injectable
class UploadRepository {
  Future<ImgBBResponse?> upload(String filePath) async {
    var client = Dio();
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);
    try {
      Response? response = await client.post(
        Urls.UPLOAD_API,
        data: data,
      );
      Logger().info('Got a Response', response.toString());
      return ImgBBResponse(url: response.data);
    } catch (e) {
      return null;
    }
  }
}
