
import 'package:quickplay/pages/home_page_start.dart';
import 'package:quickplay/pages/home_players.dart';
import 'package:quickplay/pages/home_profile.dart';
import 'package:quickplay/pages/visualizza_prenotazioni.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
<String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<Profile>(() => Profile());
    register<VisualizzaPrenotazioni>(() => VisualizzaPrenotazioni());
    register<HomePage>(() => HomePage());
    register<Players>(() => Players());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
