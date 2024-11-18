import 'package:flutter/material.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/dao/area_dao.dart';
import 'package:petrolops/src/dao/service_dao.dart';
import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/service_update.dart';
import 'package:petrolops/src/model/user.dart';
import 'package:petrolops/src/utils/id_utils.dart';
import 'package:petrolops/src/enum/status.dart';
import 'package:petrolops/src/view/component/base_button.dart';
import 'package:petrolops/src/view/component/loading.dart';
import 'package:petrolops/src/view/component/simple_form_container.dart';
import 'package:petrolops/src/view/component/simple_tile.dart';
import 'package:petrolops/src/view/page/service_form_select_team.dart';

class ServiceFormEditLeaderPage extends StatefulWidget {
  static const route = '/service/edit/leader';
  final Service service;

  const ServiceFormEditLeaderPage({super.key, required this.service});

  @override
  State<StatefulWidget> createState() {
    return ServiceFormEditLeaderPageState();
  }
}

class ServiceFormEditLeaderPageState extends State<ServiceFormEditLeaderPage> {
  final _titleTxtEdtController = TextEditingController();
  final _descriptionTxtEdtController = TextEditingController();
  final _formService = GlobalKey<FormState>();
  final _areaDao = AreaDao();
  final _serviceDao = ServiceDao();
  final _disabledStatus = [Status.open];

  late Area? _selectedArea;
  late Status _selectedStatus;
  late List<Area> _areas;
  late bool _loading = true;
  late List<User> _teamMembers;

  @override
  void initState() {
    super.initState();
    _setInitialValues();
    _getAreas();
  }

  Future<void> _update() async {
    final currentService = widget.service;
    currentService.area = _selectedArea;
    currentService.description = _descriptionTxtEdtController.text;
    currentService.title = _titleTxtEdtController.text;
    currentService.team = _teamMembers;
    currentService.status = _selectedStatus;
    final serviceUpdate = ServiceUpdate();
    serviceUpdate.description = "Informações atualizadas por líder";
    serviceUpdate.serviceUpdateId = IdUtils().generateId();
    serviceUpdate.updateAuthor = GlobalController.instance.loggedUser;
    serviceUpdate.updateDate = DateTime.now();
    currentService.updates!.add(serviceUpdate);
    try {
      await _serviceDao.updateCBL(currentService);
      Navigator.of(context).pop();
    } catch (e) {
      print('');
      print(e);
      print('');
    }
  }

  Future<void> _getAreas() async {
    setState(() {
      _loading = true;
    });
    final result = _areaDao.getAll();
    setState(() {
      _areas = result;
      _loading = false;
    });
  }

  void _setInitialValues() {
    setState(() {
      _selectedStatus = widget.service.status!;
      _selectedArea = widget.service.area;
      _titleTxtEdtController.text = widget.service.title!;
      _descriptionTxtEdtController.text = widget.service.description!;
      _teamMembers = widget.service.team == null
          ? List<User>.empty(growable: true)
          : widget.service.team!;
    });
  }

  Future<void> _selectTeamMembers() async {
    var result = await Navigator.pushNamed(
        context, ServiceFormSelectTeamPage.route,
        arguments: {'service': widget.service, 'teamMembers': _teamMembers});
    print(result);
    if (result != null) {
      setState(() {
        _loading = true;
        _teamMembers = result as List<User>;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        title: const Text('Atualizar serviço'),
      ),
      body: SimpleFormContainer(
          numFieds: 4,
          child: _loading
              ? const Loading()
              : Form(
                  key: _formService,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(10, 166, 166, 166),
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: ListView(
                      padding: const EdgeInsets.all(15),
                      children: [
                        const Center(
                          child: Text(
                            'Atualizar as informações do serviço',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          readOnly: true,
                          autocorrect: false,
                          controller: _titleTxtEdtController,
                          decoration: const InputDecoration(
                              label: Text('Título'),
                              hintText: 'Título da requisição',
                              border: OutlineInputBorder()),
                          enableSuggestions: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o título";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          readOnly: true,
                          autocorrect: false,
                          controller: _descriptionTxtEdtController,
                          decoration: const InputDecoration(
                              label: Text('Descrição'),
                              hintText: 'Descrição da requisição',
                              border: OutlineInputBorder()),
                          enableSuggestions: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe a descrição";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DropdownButton<Area>(
                          value: _selectedArea,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          onChanged: null,
                          items:
                              _areas.map<DropdownMenuItem<Area>>((Area area) {
                            return DropdownMenuItem<Area>(
                              value: area,
                              child: Text(area.name!),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DropdownButton<Status>(
                          value: _selectedStatus,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                          items: Status.values
                              .map<DropdownMenuItem<Status>>((Status status) {
                            return DropdownMenuItem<Status>(
                              value: status,
                              enabled: !_disabledStatus.contains(status),
                              child: Text(
                                status.title,
                                style: TextStyle(
                                    backgroundColor:
                                        _disabledStatus.contains(status)
                                            ? const Color.fromARGB(
                                                255, 163, 163, 163)
                                            : null),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SimpleTile(
                          title: Text(
                              '${_teamMembers.length} colaborador(es) selecionado(s)'),
                          trailing: IconButton(
                              onPressed: () {
                                _selectTeamMembers();
                              },
                              icon: const Icon(Icons.edit)),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        BaseButton(
                          onPressed: () {
                            if (_formService.currentState!.validate()) {
                              _update();
                            }
                          },
                          child: const Text('Salvar'),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
