import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/module_upload/manager/upload_manager/upload_manager.dart';
import 'package:trafficy_captain/module_upload/response/imgbb/imgbb_response.dart';

@injectable
class ImageUploadService {
  final UploadManager _manager;

  ImageUploadService(this._manager);

  Future<String?> uploadImage(String filePath) async {
    ImgBBResponse? response = await _manager.upload(filePath);
    if (response == null) {
      return null;
    } else {
      return response.url;
    }
  }
}
