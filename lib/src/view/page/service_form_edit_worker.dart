import 'package:flutter/material.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/dao/service_dao.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/service_update.dart';
import 'package:petrolops/src/utils/id_utils.dart';
import 'package:petrolops/src/enum/status.dart';
import 'package:petrolops/src/view/component/base_button.dart';
import 'package:petrolops/src/view/component/loading.dart';
import 'package:petrolops/src/view/component/simple_form_container.dart';

class ServiceFormEditWorkerPage extends StatefulWidget {
  static const route = '/service/edit/worker';
  final Service service;

  const ServiceFormEditWorkerPage({super.key, required this.service});

  @override
  State<StatefulWidget> createState() {
    return ServiceFormEditWorkerPageState();
  }
}

class ServiceFormEditWorkerPageState extends State<ServiceFormEditWorkerPage> {
  final _titleTxtEdtController = TextEditingController();
  final _descriptionTxtEdtController = TextEditingController();
  final _updateDescriptionTxtEdtController = TextEditingController();
  final _formService = GlobalKey<FormState>();
  final _serviceDao = ServiceDao();

  late bool _loading = true;

  @override
  void initState() {
    super.initState();
    _setInitialValues();
  }

  Future<void> _update() async {
    final currentService = widget.service;
    currentService.status = Status.validation;
    final serviceUpdate = ServiceUpdate();
    serviceUpdate.description = _updateDescriptionTxtEdtController.text;
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

  void _setInitialValues() {
    setState(() {
      _titleTxtEdtController.text = widget.service.title!;
      _descriptionTxtEdtController.text = widget.service.description!;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        title: const Text('Atualizar serviço'),
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
                            'Descreva a solução implementada',
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
                        TextFormField(
                          maxLines: 5,
                          autocorrect: false,
                          controller: _updateDescriptionTxtEdtController,
                          decoration: const InputDecoration(
                              label:
                                  Text('Observações da solução implementada'),
                              hintText: 'Descrição da solução',
                              border: OutlineInputBorder()),
                          enableSuggestions: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe a descrição da solução";
                            }
                            return null;
                          },
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
                          child: const Text('Enviar para validação'),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
