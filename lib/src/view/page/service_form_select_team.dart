import 'package:flutter/material.dart';
import 'package:petrolops/src/dao/user_dao.dart';
import 'package:petrolops/src/enum/role.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/user.dart';
import 'package:petrolops/src/view/component/base_container.dart';
import 'package:petrolops/src/view/component/loading.dart';
import 'package:petrolops/src/view/component/simple_tile.dart';

class ServiceFormSelectTeamPage extends StatefulWidget {
  static const route = '/service/edit/team';
  final Service service;
  final List<User> teamMembers;

  const ServiceFormSelectTeamPage(
      {super.key, required this.service, required this.teamMembers});

  @override
  State<StatefulWidget> createState() {
    return ServiceFormSelectTeamPageState();
  }
}

class ServiceFormSelectTeamPageState extends State<ServiceFormSelectTeamPage> {
  final _searchTxtEdtController = TextEditingController();
  final _userDao = UserDao();

  late bool _loading = true;
  late List<User> _areaMembers;
  late List<User> _areaMembersFiltered;
  late List<User> _teamMembers;
  bool _enableSearch = false;

  @override
  void initState() {
    super.initState();
    _getAreaMembers();
    _setInitialValues();
  }

  Future<void> _getAreaMembers() async {
    final result = _userDao
        .getByArea(widget.service.area!)
        .where((user) => user.role == Role.worker)
        .toList();
    setState(() {
      _areaMembers = result;
    });
  }

  void _setInitialValues() {
    setState(() {
      _teamMembers = widget.teamMembers;
      _areaMembersFiltered = _areaMembers;
      _loading = false;
      _searchTxtEdtController.addListener(() {
        _filterAreaMembers();
      });
    });
  }

  void _toggleTeamMember(int index) {
    setState(() {
      if (_teamMembers.contains(_areaMembersFiltered[index])) {
        _teamMembers.remove(_areaMembersFiltered[index]);
      } else {
        _teamMembers.add(_areaMembersFiltered[index]);
      }
    });
  }

  void _filterAreaMembers() {
    setState(() {
      if (_searchTxtEdtController.text.trim().isEmpty) {
        _areaMembersFiltered = _areaMembers;
      } else {
        _areaMembersFiltered = _areaMembers
            .where((user) => user.name!
                .toUpperCase()
                .contains(_searchTxtEdtController.text.toUpperCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(100, 166, 166, 166),
          title: _enableSearch
              ? TextFormField(
                  autocorrect: false,
                  controller: _searchTxtEdtController,
                  decoration: const InputDecoration(
                      hintText: 'Digite o nome do colaborador'),
                  enableSuggestions: false,
                )
              : const Text('Selecionar time'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _enableSearch = !_enableSearch;
                    _searchTxtEdtController.text = "";
                    _filterAreaMembers();
                  });
                },
                icon: Icon(_enableSearch ? Icons.clear : Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_teamMembers);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: BaseContainer(
            child: _loading
                ? const Loading()
                : _areaMembersFiltered.isEmpty
                    ? const Center(
                        child: Text(
                            'Nenhum colaborador para os filtros definidos.'),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => SimpleTile(
                              onTap: () => _toggleTeamMember(index),
                              leading: Checkbox.adaptive(
                                  value: _teamMembers
                                      .contains(_areaMembersFiltered[index]),
                                  onChanged: (value) {
                                    _toggleTeamMember(index);
                                  }),
                              title: Text(
                                _areaMembersFiltered[index].name!,
                                maxLines: 10,
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5.0,
                            ),
                        itemCount: _areaMembersFiltered.length)));
  }
}
