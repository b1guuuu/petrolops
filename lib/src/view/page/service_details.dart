import 'package:flutter/material.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/view/component/base_container.dart';
import 'package:petrolops/src/view/component/simple_tile.dart';

class ServiceDetailsPage extends StatelessWidget {
  static const route = '/service/details';
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 166, 166, 166),
        title: const Text('Informações do serviço'),
      ),
      body: BaseContainer(
          child: ListView(
        children: [
          SimpleTile(
              title: Text(
            'Título: ${service.title}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: Text(
              'Descrição: ${service.description}',
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: Text(
              'Status: ${service.status!.title}',
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: Text(
              'Área: ${service.area!.name}',
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: Text(
              'Supervisor: ${service.supervisor!.name}',
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: const Text(
              'Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: service.team == null
                  ? []
                  : service.team!.map<Widget>((teamMember) {
                      return SimpleTile(
                        title: Text(teamMember.name!),
                      );
                    }).toList(),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SimpleTile(
            title: const Text(
              'Atualizações',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: service.updates == null
                  ? []
                  : service.updates!.map<Widget>((update) {
                      return SimpleTile(
                        title: Text(update.description!),
                        subtitle: Text(
                            '${update.updateAuthor!.name} - ${update.updateDate!.toLocal().toString()}'),
                      );
                    }).toList(),
            ),
          ),
        ],
      )),
    );
  }
}
