import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data:ModalRoute.of(context).settings.arguments;
    print(data);
    String bgImage = data['isDayTime'] == null ? 'unknown_error.jpg' :(data['isDayTime'] == 'true' ? 'day.png' : 'night.png');
    Color bgColor = data['isDayTime'] == null ? Colors.black12: (data['isDayTime']=='true' ? Colors.blue[400] : Colors.indigo[900]);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        if(result != null){
                          setState(() {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'isDayTime': result['isDayTime'],
                              'flag': result['flag']
                            };
                            bgImage = data['isDayTime'] == null ? 'unknown_error.jpg' :(data['isDayTime'] == 'true' ? 'day.png' : 'night.png');
                            bgColor = data['isDayTime'] == null ? Colors.black12: (data['isDayTime']=='true' ? Colors.blue[400] : Colors.indigo[900]);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[350],
                      ),
                      label: Text(
                        'edit location',
                        style: TextStyle(
                          color: Colors.grey[350],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      children: [
                        Text(
                          data['location'],
                          style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      data['time'],
                      style: data['isDayTime'] != null ? TextStyle(
                        fontSize: 70.0,
                        wordSpacing: 10.0,
                        letterSpacing: 3.0,
                        color: Colors.white,
                      ): TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          Navigator.pushReplacementNamed(context, '/');
        },
        backgroundColor: Colors.indigo[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 40,
        ),
        notchMargin: 5.0,
        color: Colors.white10,
        // elevation: 0.0,
        shape: CircularNotchedRectangle(),
      ),
      backgroundColor: bgColor,
    );
  }
}
