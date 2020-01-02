import 'package:flutter/material.dart';
import 'trackchange.dart';
import 'gateopening.dart';
import 'Schedule.dart';
import 'menu1.dart';
import '../bt_command.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String sensorValue = "N/A";

	bool ledState = false;

	@override
	initState() {
		
		super.initState();
		BTController.init(onData);
		scanDevices();
	}

	void onData(dynamic str) { setState(() { sensorValue = str; }); }

	void switchLed() {

		setState(() { ledState = !ledState; });
		BTController.transmit(ledState ? '0' : '1');
	}

	Future<void> scanDevices() async {

		BTController.enumerateDevices()
			.then((devices) { onGetDevices(devices); });
	}

	void onGetDevices(List<dynamic> devices) {

		Iterable<SimpleDialogOption> options = devices.map((device) {

			return SimpleDialogOption(
				child: Text(device.keys.first),
				onPressed: () { selectDevice(device.values.first); },
			);
		});

		// set up the SimpleDialog
		SimpleDialog dialog = SimpleDialog(
			title: const Text('Choose a device'),
			children: options.toList(),
		);

  		// show the dialog
		showDialog(
			barrierDismissible: false,
			context: context,
			builder: (BuildContext context) { return dialog; }
		);
	}

	selectDevice(String deviceAddress) {

		Navigator.of(context, rootNavigator: true).pop('dialog');
		BTController.connect(deviceAddress);
	}
  
  
  @override
  Widget build(BuildContext context) {
    Color color = ledState ? Colors.deepPurpleAccent : Colors.white24;
		TextTheme theme = Theme.of(context).textTheme;

		return Scaffold(
			appBar: AppBar(title: Text("TITLE TEST")),
			body: Container(
				decoration: BoxDecoration(color: Colors.black),
			  	child: Center(
			  		child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text('Sensor Value', style: theme.display1.copyWith(color: Colors.white)),
							Text(sensorValue, style: theme.display2.copyWith(color: Colors.white)),
						],
					)

			  	),
			),
			floatingActionButton: FloatingActionButton(
				backgroundColor: color,
				onPressed: switchLed,
				tooltip: 'Increment',
				child: Icon(Icons.power_settings_new),
			), 
		);
  }

  Widget _welcometext(){
    return Center(
     child: Padding(
       padding: EdgeInsets.all(10),
       child: Center(
         child:Text(
            "WELCOME TO TRAIN AUTOMATED CONTROL SYSTEM",
            style: TextStyle(fontSize: 25.0),
       ),
       ),
     ),
    );
  }

  Widget _button(String btntext, int option){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: ButtonTheme(
          minWidth: 200.0,
          height: 100.0,
          child: RaisedButton(
              child: Text(btntext),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              textColor: Colors.white,
              onPressed: () => _homeToTrackChange(option),
            ),
          ),
      )
    );
  }

  Future _homeToTrackChange(int option){
        if(option == 1){
          return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MENU()),//GateOpening()),
          );
        }else if(option == 2){
          return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrackChange()),
        );
        }else{
          return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListPage(title: 'Lessons')),
          );
        }
        
    }

  _changeText() {
    setState(() {
      
    });
  }
}
