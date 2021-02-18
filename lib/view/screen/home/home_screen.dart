import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_pagination/core/controller/home_controller.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller;

  const HomeScreen(this._controller, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("GetX Pagination"),

        ),
        body: Obx(() => LazyLoadScrollView(
              onEndOfPage: _controller.loadNextPage,
              isLoading: _controller.lastPage,
              child: ListView.builder(
                itemCount: _controller.images.length,
                itemBuilder: (context, index) {
                  final image = _controller.images[index];
                  return ListTile(
                    leading: Text(image.id),
                    title: Text(image.author),
                    subtitle: Image.network(image.download_url),
                  );
                },
              ),
            )),
      ),
    );
  }
}
