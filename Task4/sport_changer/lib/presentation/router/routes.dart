class Route {
  final String url;
  final String name;
  Route(this.url, this.name);
}

class Routes {
  static final home = Route('/', 'home');
  static final login = Route('/auth/log_in', 'login');
  static final sighup = Route('/auth/sighup', 'sighup');
  static final exercise = Route('/exercise', 'exercise');
  static final addExercise = Route('/exercise/:id/add', 'addExercise');
  static final settings = Route('/settings', 'settings');
  static final client = Route('/client/:id', 'client');
  static final adminClients = Route('/admin/clients', 'adminClients');
  static final adminExercises = Route('/admin/exercises', 'adminExercises');
  static final adminCreateExercises =
      Route('/admin/exercises/create', 'adminCreateExercises');
}
