import 'package:flutter/material.dart';
import 'package:petrolops/src/controller/global_controller.dart';
import 'package:petrolops/src/model/service.dart';
import 'package:petrolops/src/model/user.dart';
import 'package:petrolops/src/view/page/home.dart';
import 'package:petrolops/src/view/page/login.dart';
import 'package:petrolops/src/view/page/service_details.dart';
import 'package:petrolops/src/view/page/service_form_edit_leader.dart';
import 'package:petrolops/src/view/page/service_form_edit_supervisor.dart';
import 'package:petrolops/src/view/page/service_form_edit_worker.dart';
import 'package:petrolops/src/view/page/service_form_new.dart';
import 'package:petrolops/src/view/page/service_form_select_team.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: GlobalController.instance,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: LoginPage.route,
            routes: {
              HomePage.route: (context) => const HomePage(),
              ServiceFormNewPage.route: (context) => const ServiceFormNewPage()
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case ServiceFormEditLeaderPage.route:
                  var service = settings.arguments as Service;
                  return MaterialPageRoute(builder: (context) {
                    return ServiceFormEditLeaderPage(service: service);
                  });

                case ServiceFormEditSupervisorPage.route:
                  var service = settings.arguments as Service;
                  return MaterialPageRoute(builder: (context) {
                    return ServiceFormEditSupervisorPage(service: service);
                  });

                case ServiceFormSelectTeamPage.route:
                  var arguments = settings.arguments as Map<String, dynamic>;
                  var service = arguments['service'] as Service;
                  var teamMembers = arguments['teamMembers'] as List<User>;
                  return MaterialPageRoute(builder: (context) {
                    return ServiceFormSelectTeamPage(
                      service: service,
                      teamMembers: teamMembers,
                    );
                  });

                case ServiceDetailsPage.route:
                  var service = settings.arguments as Service;
                  return MaterialPageRoute(builder: (context) {
                    return ServiceDetailsPage(service: service);
                  });

                case ServiceFormEditWorkerPage.route:
                  var service = settings.arguments as Service;
                  return MaterialPageRoute(builder: (context) {
                    return ServiceFormEditWorkerPage(service: service);
                  });

                default:
                  return MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  });
              }
            },
          );
        });
  }
}
