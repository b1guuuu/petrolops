import 'package:petrolops/src/dao/area_dao.dart';
import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/model/user.dart';

class UserDao {
  List<User> users = List.empty(growable: true);

  UserDao() : users = UserDao.getUsers();

  static List<User> getUsers() {
    var areas = AreaDao().getAll();
    return [
      User.fromJson(
        {
          'userId': 'user_1',
          'name': 'Amilcar Cristina',
          'role': 'supervisor',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 720398,
          'area': areas[0].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_2',
          'name': 'Mafalda Maciel',
          'role': 'leader',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 932514,
          'area': areas[0].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_3',
          'name': 'Fabio Teles',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 838231,
          'area': areas[0].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_4',
          'name': 'Estela Viegas',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 83702,
          'area': areas[0].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_5',
          'name': 'Rute Ramalho',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 867134,
          'area': areas[0].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_6',
          'name': 'Tomás Romão',
          'role': 'supervisor',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 2501,
          'area': areas[1].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_7',
          'name': 'Dora Bessa',
          'role': 'leader',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 122520,
          'area': areas[1].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_8',
          'name': 'David Leão',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 692760,
          'area': areas[1].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_9',
          'name': 'Nelson Moura',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 702021,
          'area': areas[1].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_10',
          'name': 'Catia Gomes',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 720041,
          'area': areas[1].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_11',
          'name': 'Hélder Queirós',
          'role': 'supervisor',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 922016,
          'area': areas[2].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_12',
          'name': 'Carlos de Olíveira',
          'role': 'leader',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 192781,
          'area': areas[2].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_13',
          'name': 'Renata Augusto',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 554311,
          'area': areas[2].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_14',
          'name': 'Gustavo Guimarães',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 990437,
          'area': areas[2].toJson()
        },
      ),
      User.fromJson(
        {
          'userId': 'user_15',
          'name': 'Elóisa Castro',
          'role': 'worker',
          'password': 'password',
          'passwordSalt': 'passwordSalt',
          'registration': 942510,
          'area': areas[2].toJson()
        },
      ),
    ];
  }

  List<User> getByArea(Area area) {
    return users.where((user) => user.area == area).toList();
  }
}
