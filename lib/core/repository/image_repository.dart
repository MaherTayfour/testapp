import 'package:dio/dio.dart';
import 'package:getx_pagination/core/model/pagination_filter.dart';
import 'package:getx_pagination/core/model/image_model.dart';

class ImageRepository {
  Dio _dio;

  ImageRepository(
    this._dio,
  );

  Future<List<ImageModel>> getImages(PaginationFilter filter) {
    return _dio.get('list', queryParameters: {
      'page': filter.page,
      'limit': filter.limit
    }).then((value) => value?.data
        ?.map<ImageModel>(
          (u) => ImageModel.fromJson(u),
        )
        ?.toList());
  }
}
