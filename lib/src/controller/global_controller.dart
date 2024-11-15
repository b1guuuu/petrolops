import 'package:flutter/material.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/user.dart';

class GlobalController extends ChangeNotifier {
  static GlobalController instance = GlobalController();
  static const String baseURL = 'ws://192.168.0.99:4985';
  static const String database = 'petrolops';
  static const String scope = 'petrolops';
  List<Service> services = List<Service>.empty(growable: true);
  User? loggedUser;

  setUser(User user) {
    loggedUser = user;
    notifyListeners();
  }

  addService(Service service) {
    services.add(service);
    notifyListeners();
  }

  updateService(Service service) {
    int index = services.indexWhere((item) => item.title == service.title);
    if (index >= 0) {
      services[index] = service;
      notifyListeners();
    }
  }
}
