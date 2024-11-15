import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/material.dart';
import 'package:petrolops/app.dart';
import 'package:petrolops/src/database/database_replicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CouchbaseLiteFlutter.init();
  await DatabaseReplicator().sync(null);
  runApp(const App());
}
