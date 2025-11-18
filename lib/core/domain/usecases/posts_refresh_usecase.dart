import 'dart:async';

enum RefreshCommand { fetch }

class PostsRefreshUsecase {
  PostsRefreshUsecase();

  final StreamController<RefreshCommand> _controller =
      StreamController<RefreshCommand>.broadcast();

  Stream<RefreshCommand> get stream => _controller.stream;

  void fetch() {
    _controller.add(RefreshCommand.fetch);
  }
}


