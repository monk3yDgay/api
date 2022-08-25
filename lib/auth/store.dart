import 'package:flutter/foundation.dart';

class Store extends ChangeNotifier {
  String api = "";
  // Store(this.api);
  void setAPi(String str) {
    this.api = str;
  }

  String getApi() {
    return this.api;
  }
}
