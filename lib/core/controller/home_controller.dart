import 'package:get/get.dart';
import 'package:getx_pagination/core/model/pagination_filter.dart';
import 'package:getx_pagination/core/model/image_model.dart';
import 'package:getx_pagination/core/repository/image_repository.dart';

class HomeController extends GetxController {
  final ImageRepository _imageRepository;
  final _images = <ImageModel>[].obs;
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  HomeController(this._imageRepository);

  List<ImageModel> get images => _images.toList();
  int get limit => _paginationFilter.value.limit;
  int get _page => _paginationFilter.value.page;
  bool get lastPage => _lastPage.value;

  @override
  onInit() {
    ever(_paginationFilter, (_) => _getAllImages());
    _changePaginationFilter(1, 15);
    super.onInit();
  }

  Future<void> _getAllImages() async {
    final imagesData = await _imageRepository.getImages(_paginationFilter.value);
    if (imagesData.isEmpty) {
      _lastPage.value = true;
    }
    _images.addAll(imagesData);
  }

  void changeTotalPerPage(int limitValue) {
    _images.clear();
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }

  void _changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val.page = page;
      val.limit = limit;
    });
  }

  void loadNextPage() => _changePaginationFilter(_page + 1, limit);
}
