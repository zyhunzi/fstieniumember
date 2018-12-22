import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class MyEvent {
  String text;
  MyEvent(this.text);
}

class UserLoggedInEvent {
  String user;
  UserLoggedInEvent(this.user);
}
