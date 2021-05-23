import 'package:flutter/material.dart';
import 'package:learning/components/drawer.dart';
import 'package:learning/services/api.dart';
import 'package:sms/sms.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List recepients;
  var req = Api(
      "https://script.google.com/macros/s/AKfycbxhbivbbmoexLTU9-sQ9xxczXclaxLtqJHO54JA4m1v_GQ3vB9si0CeP_XPbw1TLqMxfg/exec");

  getallRecipients() async {
    setState(() {
      recepients = null;
    });
    var resp = await req.getMyData();
    setState(() {
      recepients = resp['data'];
    });
  }

  SmsSender sender = new SmsSender();

  void changeState(int index, String status) async {
    var res = await req.postData(recepients[index]['row'], status);
    print('$res');
    setState(() {
      recepients[index]['status'] = status;
      print('$index');
    });
  }

  void sendSms(int index) async {
    SmsMessage message = new SmsMessage(
        recepients[index]['receiver'], recepients[index]['text']);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        changeState(index, "Sent");
      } else if (state == SmsMessageState.Delivered) {
        changeState(index, "Delivered");
      } else {
        changeState(index, "Fail");
      }
    });
    sender.sendSms(message);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallRecipients();
  }

  @override
  Widget build(BuildContext context) {
    // User providerdata = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh_rounded),
              onPressed: () {
                getallRecipients();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < recepients.length; i++) {
            sendSms(i);
          }
        },
        tooltip: 'Send',
        child: Icon(Icons.send),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: recepients == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: recepients.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(recepients[index]['receiver']),
                  subtitle: Text(recepients[index]['text']),
                  trailing: Text(
                    recepients[index]['status'] ?? recepients[index]['status'],
                    style: TextStyle(
                        backgroundColor: Colors.black12,
                        color: recepients[index]['status'] == 'Fail'
                            ? Colors.red[300]
                            : Colors.green[400]),
                  ),
                ),
              ),
      ),
    );
  }
}
