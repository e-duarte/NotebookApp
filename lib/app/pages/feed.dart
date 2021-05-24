import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/services/scheduling_service.dart';
import 'package:notebook_app/app/widgets/card.dart';
import 'package:notebook_app/helpers/utils.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<Scheduling>>(
          future: SchedulingService().all(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('no connection'));
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("server is not avaliable"),
                  );
                } else {
                  List<Widget> schedulingCards = [
                    welcomeCard(),
                  ];
                  schedulingCards.addAll(snapshot.data
                      .map((scheduling) => CardItem(
                            manager: scheduling.manager.username,
                            managerSession:
                                Provider.of<Manager>(context).username,
                            managerName: scheduling.manager.name,
                            user: scheduling.user.name,
                            duration: Utils.duration(scheduling.createdAt),
                          ))
                      .toList());
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
    );
  }

  // String duration(DateTime createAt) {
  //   final duration = DateTime.now().difference(createAt).inMinutes;

  //   if (duration < 60) {
  //     return 'há ${DateTime.now().difference(createAt).inMinutes} min';
  //   } else if (duration >= 60) {
  //     return 'há ${DateTime.now().difference(createAt).inHours} horas';
  //   } else {
  //     return '';
  //   }
  // }

  Widget welcomeCard() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Bem-vindo',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              Provider.of<Manager>(context).username,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
