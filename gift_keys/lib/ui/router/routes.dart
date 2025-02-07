extension type Route(String name) {
  String call() => name;
}

final class Routes {
  const Routes._();

  static final homePage = Route('home');
}
