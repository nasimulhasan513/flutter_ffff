import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  int count = 0;

  int increaseCount() => this.count++;
  setUser(int c) {
    this.count = c;
  }
}
