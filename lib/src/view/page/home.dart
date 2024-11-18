import 'package:flutter/material.dart';
import 'package:petrolops/src/broker/broker_consumer.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/dao/service_dao.dart';
import 'package:petrolops/src/database/database_replicator.dart';
import 'package:petrolops/src/enum/status.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/enum/role.dart';
import 'package:petrolops/src/view/component/base_container.dart';
import 'package:petrolops/src/view/component/loading.dart';
import 'package:petrolops/src/view/component/simple_tile.dart';
import 'package:petrolops/src/view/page/service_details.dart';
import 'package:petrolops/src/view/page/service_form_edit_leader.dart';
import 'package:petrolops/src/view/page/service_form_edit_supervisor.dart';
import 'package:petrolops/src/view/page/service_form_edit_worker.dart';
import 'package:petrolops/src/view/page/service_form_new.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return ServicesPageState();
  }
}

class ServicesPageState extends State<HomePage> {
  final _serviceDao = ServiceDao();
  late List<Service> _services = [];
  bool _loading = false;
  final bool _canAddServices =
      GlobalController.instance.loggedUser!.role == Role.supervisor;
  late Function() _fetchServices;
  late Function(int) _editFormNavigation;

  @override
  void initState() {
    super.initState();
    _definePageBehavior();
  }

  Future<void> _definePageBehavior() async {
    setState(() {
      switch (GlobalController.instance.loggedUser!.role) {
        case Role.worker:
          _fetchServices = _getInProgressForCurrentUser;
          _editFormNavigation = _showEditFormWorker;
          break;
        case Role.supervisor:
          _fetchServices = _getAll;
          _editFormNavigation = _showEditFormSupervisor;
          break;
        case Role.leader:
          _fetchServices = _getByArea;
          _editFormNavigation = _showEditFormLeader;
          break;
        default:
          _fetchServices = _getAll;
          _editFormNavigation = _showServiceDetails;
      }
    });
    try {
      _fetchServices();

      await DatabaseReplicator().sync(_fetchServices);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAll() async {
    setState(() {
      _loading = true;
    });

    try {
      final results = await _serviceDao.getAllCBL();

      setState(() {
        _services = results;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _services = [];
        _loading = false;
      });
    }
  }

  Future<void> _getByArea() async {
    setState(() {
      _loading = true;
    });
    try {
      final results = await _serviceDao
          .getByAreaCBL(GlobalController.instance.loggedUser!.area!);

      setState(() {
        _services = results;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _services = [];
        _loading = false;
      });
    }
  }

  Future<void> _getInProgressForCurrentUser() async {
    setState(() {
      _loading = true;
    });
    try {
      final results = await _serviceDao.getInProgressForCurrentUser();

      setState(() {
        _services = results;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _services = [];
        _loading = false;
      });
    }
  }

  Future<void> _insert() async {
    Navigator.of(context).pushNamed(ServiceFormNewPage.route).then((onresult) {
      _fetchServices();
    });
  }

  Future<void> _showEditFormSupervisor(int index) async {
    final selectedService = _services[index];
    Navigator.of(context)
        .pushNamed(ServiceFormEditSupervisorPage.route,
            arguments: selectedService)
        .then((response) => _fetchServices());
  }

  Future<void> _showEditFormLeader(int index) async {
    final selectedService = _services[index];
    Navigator.of(context)
        .pushNamed(ServiceFormEditLeaderPage.route, arguments: selectedService)
        .then((response) => _fetchServices());
  }

  Future<void> _showEditFormWorker(int index) async {
    final selectedService = _services[index];
    Navigator.of(context)
        .pushNamed(ServiceFormEditWorkerPage.route, arguments: selectedService)
        .then((response) => _fetchServices());
  }

  Future<void> _showServiceDetails(int index) async {
    final selectedService = _services[index];
    Navigator.of(context)
        .pushNamed(ServiceDetailsPage.route, arguments: selectedService)
        .then((response) => _fetchServices());
  }

  Future<void> _triggerSync() async {
    try {
      //BrokerConsumer().consume();
      await _fetchServices();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        actions: _canAddServices
            ? [
                IconButton(
                    onPressed: () {
                      _triggerSync();
                    },
                    icon: const Icon(Icons.sync)),
                IconButton(
                  onPressed: () => _insert(),
                  icon: const Icon(Icons.add),
                )
              ]
            : [
                IconButton(
                    onPressed: () {
                      _triggerSync();
                    },
                    icon: const Icon(Icons.sync)),
              ],
        title: const Text('Serviços'),
      ),
      body: BaseContainer(
          child: _loading
              ? const Loading()
              : _services.isEmpty
                  ? const Center(
                      child: Text('Não há serviços cadastrados'),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => SimpleTile(
                            trailing: _services[index].status !=
                                        Status.canceled &&
                                    _services[index].status != Status.finished
                                ? IconButton(
                                    onPressed: () => _editFormNavigation(index),
                                    icon: const Icon(Icons.edit))
                                : null,
                            onTap: () => _showServiceDetails(index),
                            title: Text(
                              '${_services[index].status!.title} : ${_services[index].title!}',
                              maxLines: 10,
                            ),
                            subtitle: Text(_services[index].area!.name!),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5.0,
                          ),
                      itemCount: _services.length)),
    );
  }
}
