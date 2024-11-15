import 'package:cbl/cbl.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/utils/id_utils.dart';

class ServiceDao {
  static const String collectionName = 'services';

  Future<List<Service>> getAll() async {
    return GlobalController.instance.services;
  }

  Future<List<Service>> getByArea(Area area) async {
    return GlobalController.instance.services
        .where((service) => service.area == area)
        .toList();
  }

  Future<void> insert(Service service) async {
    service.serviceId = IdUtils().generateId();
    GlobalController.instance.addService(service);
  }

  Future<void> update(Service service) async {
    GlobalController.instance.updateService(service);
  }

  Future<void> updateCBL(Service service) async {
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final document = await collection.document(service.serviceId!);
    final mutableDocument = document!.toMutable();
    mutableDocument.setData(service.toJson());
    await collection.saveDocument(mutableDocument);
    await database.close();
  }

  Future<List<Service>> getAllCBL() async {
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final query = const QueryBuilder()
        .select(SelectResult.all())
        .from(DataSource.collection(collection).as('service'));
    final result = await query.execute();
    final results = await result.allResults();
    List<Service> services = [];
    for (var instance in results) {
      try {
        final map = instance.toPlainMap();
        final converter = ServiceConvertHelper.fromJson(map);
        final serv = converter.service;
        services.add(serv);
      } catch (e) {
        print(e);
      }
    }
    await database.close();
    return services;
  }

  Future<List<Service>> getByAreaCBL(Area area) async {
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final query = const QueryBuilder()
        .select(SelectResult.all())
        .from(DataSource.collection(collection).as('service'))
        .where(Expression.property('area').equalTo(Expression.value(area)));
    final result = await query.execute();
    final results = await result.allResults();
    List<Service> services = [];
    for (var instance in results) {
      try {
        final map = instance.toPlainMap();
        final converter = ServiceConvertHelper.fromJson(map);
        final serv = converter.service;
        services.add(serv);
      } catch (e) {
        print(e);
      }
    }
    await database.close();
    return services;
  }

  Future<List<Service>> getInProgressForCurrentUser() async {
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final query = const QueryBuilder()
        .select(SelectResult.all())
        .from(DataSource.collection(collection).as('service'))
        .where(Expression.property('status')
            .equalTo(Expression.string('inProgress')));
    final result = await query.execute();
    final results = await result.allResults();
    List<Service> services = [];
    for (var instance in results) {
      try {
        final map = instance.toPlainMap();
        final converter = ServiceConvertHelper.fromJson(map);
        final serv = converter.service;
        services.add(serv);
      } catch (e) {
        print(e);
      }
    }
    await database.close();
    return services
        .where((service) =>
            service.team!.contains(GlobalController.instance.loggedUser))
        .toList();
  }

  Future<void> insertCBL(Service service) async {
    service.serviceId = IdUtils().generateId();
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final mutableDocument = MutableDocument(service.toJson());
    await collection.saveDocument(mutableDocument);
    mutableDocument.setString(mutableDocument.id, key: 'serviceId');
    await collection.saveDocument(mutableDocument);
    await database.close();
  }
/*
  Future<List<Service>> getAll() async {
    final database = await Database.openAsync(GlobalController.database);
    const sql = 'SELECT * FROM $collectionName';
    AsyncQuery query;
    try {
      query = await database.createQuery(sql);
    } catch (e) {
      return List<Service>.empty();
    }
    final result = await query.execute();
    final results = await result.allResults();
    List<Service> services = [];
    for (var doc in results) {
      print(doc.toPlainMap()[collectionName]);
      print(doc.toPlainMap());
      services.add(Service.fromJson(doc.toPlainMap()[collectionName] as Map));
    }
    return services;
  }

  Future<void> insert() async {
    final database = await Database.openAsync(GlobalController.database);
    final collection = await database.defaultCollection;
    final mutableDocument = MutableDocument();
    mutableDocument.setString(IdUtils().generateId(), key: 'id');
    mutableDocument.setString('title', key: 'title');
    mutableDocument.setString('desc', key: 'description');
    mutableDocument.setString('area', key: 'area');
    mutableDocument.setInteger(1, key: 'priority');
    mutableDocument.setDate(DateTime.now(), key: 'creationDate');
    mutableDocument.setDate(DateTime.now(), key: 'lastUpdateDate');
    mutableDocument.setDate(null, key: 'closeDate');
    await collection.saveDocument(mutableDocument);
    await database.close();
  }
  */
}
