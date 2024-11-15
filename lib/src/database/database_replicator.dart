import 'package:cbl/cbl.dart';
import 'package:petrolops/src/controller/global_controller.dart';

class DatabaseReplicator {
  String endpoint = '${GlobalController.baseURL}/${GlobalController.database}';
  String username = 'sync_gateway';
  String password = 'sync_gateway';

  Future<Replicator?> sync(Function? refresh) async {
    try {
      final database = await Database.openAsync(GlobalController.database);
      final collection = await database.defaultCollection;

      var replicatorConfiguration = ReplicatorConfiguration(
          target: UrlEndpoint(Uri.parse(endpoint)),
          replicatorType: ReplicatorType.pushAndPull,
          continuous: true,
          authenticator:
              BasicAuthenticator(username: username, password: password))
        ..addCollection(collection);

      final replicator = await Replicator.create(replicatorConfiguration);
      await replicator.addChangeListener((change) {
        print('Replicator activity: ${change.status.activity}');
        print(change);
        print(change.status.error);
        print(change.status.activity);
        print(change.status.activity.name);
        print(change.status.progress);
        print('');
        if (change.status.activity == ReplicatorActivityLevel.idle) {
          if (refresh != null) {
            refresh();
          }
        }
      });
      await replicator.start();
      return replicator;
    } catch (e) {
      print('');
      print(e);
      print('');
      return null;
    }
  }
}
