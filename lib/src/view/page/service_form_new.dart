import 'package:flutter/material.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/dao/area_dao.dart';
import 'package:petrolops/src/dao/service_dao.dart';
import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/service_update.dart';
import 'package:petrolops/src/utils/id_utils.dart';
import 'package:petrolops/src/enum/status.dart';
import 'package:petrolops/src/view/component/base_button.dart';
import 'package:petrolops/src/view/component/loading.dart';
import 'package:petrolops/src/view/component/simple_form_container.dart';

class ServiceFormNewPage extends StatefulWidget {
  static const route = '/service/new';

  const ServiceFormNewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ServiceFormNewPageState();
  }
}

class ServiceFormNewPageState extends State<ServiceFormNewPage> {
  final _titleTxtEdtController = TextEditingController();
  final _descriptionTxtEdtController = TextEditingController();
  final _formService = GlobalKey<FormState>();
  final _areaDao = AreaDao();
  final _serviceDao = ServiceDao();
  late Area? _selectedArea;
  late List<Area> _areas;
  late bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getAreas();
  }

  Future<void> _insert() async {
    final newService = Service();
    newService.area = _selectedArea;
    newService.description = _descriptionTxtEdtController.text;
    newService.status = Status.open;
    newService.title = _titleTxtEdtController.text;
    final serviceUpdate = ServiceUpdate();
    serviceUpdate.description = "Criação da solicitação";
    serviceUpdate.serviceUpdateId = IdUtils().generateId();
    serviceUpdate.updateAuthor = GlobalController.instance.loggedUser;
    serviceUpdate.updateDate = DateTime.now();
    newService.updates = [serviceUpdate];
    newService.supervisor = GlobalController.instance.loggedUser;
    try {
      await _serviceDao.insertCBL(newService);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAreas() async {
    final result = await _areaDao.getAll();
    setState(() {
      _areas = result;
      _selectedArea = result.first;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        title: const Text('Formulário Serviços'),
      ),
      body: SimpleFormContainer(
          numFieds: 3,
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
                            'Insira as informações do novo serviço',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
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
                          onChanged: (value) {
                            setState(() {
                              _selectedArea = value;
                            });
                          },
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
                        BaseButton(
                          onPressed: () {
                            if (_formService.currentState!.validate()) {
                              _insert();
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
