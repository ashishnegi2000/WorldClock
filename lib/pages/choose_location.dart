import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;

  List<WorldTime> Locations = [
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag:  'india.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag:  'uk.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = Locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print('choose location starts');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: Locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(Locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/${Locations[index].flag}',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
