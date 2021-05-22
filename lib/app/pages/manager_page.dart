import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/services/scheduling_service.dart';
import 'package:notebook_app/app/widgets/card.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: Text(
          nameAndLastName(arguments['managerName']),
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Scheduling>>(
            future: SchedulingService().all(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('it has appeare some error'));
                  } else {
                    List<Widget> schedulingCards = [
                      profileCard(arguments['manager'],
                          arguments['managerName'], arguments['managerRole']),
                    ];

                    print(snapshot.data);

                    schedulingCards
                        .addAll(snapshot.data.map((scheduling) => CardItem(
                              manager: arguments['manager'],
                              managerSession: arguments['manager'],
                              managerName: arguments['managerName'],
                              user: scheduling.user.name,
                              duration: duration(scheduling.createdAt),
                            )));
                    return ListView.builder(
                      itemCount: schedulingCards.length,
                      itemBuilder: (context, index) {
                        // return;
                        return schedulingCards[index];
                      },
                    );
                  }
              }
            }),
      ),
    );
  }

  String nameAndLastName(managerName) =>
      managerName.split(' ')[0] + ' ' + managerName.split(' ').last;

  String duration(DateTime createAt) =>
      '${DateTime.now().difference(createAt).inMinutes} min atrás';

  Widget profileCard(manager, managerName, managerRole) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Center(
          child: Column(
            children: [
              UserIcon(
                username: managerName,
                size: 0.12,
                fontSize: 45.0,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(managerName),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(manager),
                  Container(
                    width: 20,
                    child: Center(
                      child: Text('|'),
                    ),
                  ),
                  Text(managerRole),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
