import 'package:petrolops/src/model/area.dart';

class AreaDao {
  static List<Area> areas = [
    Area.fromJson({'areaId': 'area_1', 'name': 'AREA 1'}),
    Area.fromJson({'areaId': 'area_2', 'name': 'AREA 2'}),
    Area.fromJson({'areaId': 'area_3', 'name': 'AREA 3'})
  ];

  List<Area> getAll() {
    return AreaDao.areas;
  }
/*
  Future<List<Area>> getAll() async {
    final database = await Database.openAsync(GlobalController.database);
    final collection =
        await database.createCollection(collectionName, GlobalController.scope);
    final query = const QueryBuilder()
        .select(SelectResult.all())
        .from(DataSource.collection(collection));
    final result = await query.execute();
    final results = await result.allResults();
    List<Area> areas = [];
    for (var doc in results) {
      areas.add(Area.fromJson(doc.toPlainMap()[collectionName] as Map));
    }
    await database.close();
    return areas;
  }

  Future<void> insert(String name) async {
    final database = await Database.openAsync(GlobalController.database);
    final collection =
        await database.createCollection(collectionName, GlobalController.scope);
    final mutableDocument = MutableDocument();
    mutableDocument.setString(IdUtils().generateId(), key: 'id');
    mutableDocument.setString(name, key: 'name');
    mutableDocument.setString(
        name.toUpperCase().substring(0, (name.length / 3).round() + 1),
        key: 'sufix');
    await collection.saveDocument(mutableDocument);
    await database.close();
  }
  */
}
