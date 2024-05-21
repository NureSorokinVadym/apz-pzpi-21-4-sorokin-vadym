class Route {
  final String url;
  final String name;
  Route(this.url, this.name);
}

class Routes {
  static final home = Route('/', 'home');
  static final login = Route('/auth/login', 'login');
  static final sighup = Route('/auth/sighup', 'sighup');
  static final exercise = Route('/exercise', 'exercise');
  static final addExercise = Route('/exercise/add', 'addExercise');
  static final settings = Route('/settings', 'settings');
}
