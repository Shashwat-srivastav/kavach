import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suraksha_kavach/gaurdianinfo.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import "package:velocity_x/velocity_x.dart";
import 'gaurdianinfo.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suraksha Kavach',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const LoginPage(),
    );
  }
}

//----------------------------------------------------------------------------------------------------------
//QR code
class QRGenerator extends StatelessWidget {
  final String s;
  const QRGenerator({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Container(
      child: InkWell(
        child: Center(
          child: QrImage(
            data: s,
            size: 320,
            version: QrVersions.auto,
            gapless: false,
          ),
        ),
      ),
    )));
  }
}

//------------------------------------------------------------------------------------------------------------
//Google Map
const String API_KEY = "AIzaSyD_6M5LwdYq96HnHD28WcQ6Zgfx1dd6nd8";
const LatLng destination = LatLng(28.535517, 77.391029);

class Direction extends StatefulWidget {
  const Direction({super.key});

  @override
  State<Direction> createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: GoogleMap(
        initialCameraPosition: CameraPosition(target: destination),
        markers: {
          Marker(markerId: MarkerId("destination"), position: destination)
        },
      )),
    );
  }
}

//-------------------------------------------------------------------------------------------------------------
//police List
class PoliceStation extends StatefulWidget {
  const PoliceStation({super.key});

  @override
  State<PoliceStation> createState() => _PoliceStationState();
}

class _PoliceStationState extends State<PoliceStation> {
  @override
  void initState() {
    loadData();
  }

  loadData() async {
    final String dataJson =
        await rootBundle.loadString("lib/assets/files/dataPolice.json");
    final pol = jsonDecode(dataJson);
    var p = pol["police"];
    MyPolice.details =
        List.from(p).map<police>((d) => police.fromMap(d)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              "Police Station"
                  .text
                  .headline2(context)
                  .bold
                  .make()
                  .pLTRB(0, 50, 0, 50),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: MyPolice.details.length,
                  itemBuilder: (context, index) {
                    final police h = MyPolice.details[index];
                    return InkWell(
                      child: Card(
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          color: Color.fromARGB(255, 231, 197, 236),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Placeholder().h(20).w10(context),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  h.name.text.semiBold.gray400
                                      .headline6(context)
                                      .make(),
                                  h.contact.text.make(),
                                  h.url.text.make()
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Direction()));
                                },
                                child: Icon(
                                  color: Colors.blueGrey,
                                  CupertinoIcons.arrow_right_square,
                                  size: 50,
                                ),
                              )
                            ],
                          )).h(80),
                    ).w24(context).pLTRB(5, 20, 5, 0);
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------------------------------------
//hospital list
bool f = false;

class HospitalList extends StatefulWidget {
  const HospitalList({super.key});

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  void initState() {
    loaddata();
  }

  loaddata() async {
    final String dataJ =
        await rootBundle.loadString("lib/assets/files/dataHospital.json");
    final datadar = jsonDecode(dataJ);
    var d = datadar["hospital"];
    MyHospital.details =
        List.from(d).map<hospital>((d) => hospital.fromMap(d)).toList();
    setState(() {
      f = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              "Hospital"
                  .text
                  .headline2(context)
                  .bold
                  .make()
                  .pLTRB(0, 50, 0, 50),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: MyHospital.details.length,
                  itemBuilder: (context, index) {
                    final hospital h = MyHospital.details[index];
                    return InkWell(
                      child: Card(
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          color: Color.fromARGB(255, 231, 197, 236),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Placeholder().h(20).w10(context),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  h.name.text.semiBold.gray400
                                      .headline6(context)
                                      .make(),
                                  h.contact.text.make(),
                                  h.url.text.make()
                                ],
                              ),
                              Icon(
                                CupertinoIcons.arrow_right_square,
                                size: 50,
                              )
                            ],
                          )).h(80),
                    ).w24(context).pLTRB(5, 20, 5, 0);
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------------------------------------
//Gaurdian
class Gaurdian extends StatefulWidget {
  const Gaurdian({super.key});

  @override
  State<Gaurdian> createState() => _GaurdianState();
}

class _GaurdianState extends State<Gaurdian> {
  @override
  void initState() {
    loaddata();
  }

  loaddata() async {
    final String dataJson =
        await rootBundle.loadString("lib/assets/files/data.json");
    final datadart = jsonDecode(dataJson);
    var da = datadart["gaurdian"];
    MyGaurd.details =
        List.from(da).map<gaurdian>((da) => gaurdian.fromMap(da)).toList();
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GaurdianCreate()));
            }),
        backgroundColor: Colors.pink[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              "Guardian"
                  .text
                  .headline2(context)
                  .bold
                  .make()
                  .pLTRB(0, 50, 0, 50),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // gridDelegate:
                  //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: MyGaurd.details.length,
                  itemBuilder: (context, index) {
                    final gaurdian gaurd = MyGaurd.details[index];
                    return InkWell(
                      child: Card(
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          color: Color.fromARGB(255, 231, 197, 236),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Placeholder().h(20).w10(context),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  gaurd.name.text.semiBold.gray400
                                      .headline6(context)
                                      .make(),
                                  gaurd.age.text.make(),
                                  gaurd.contact.text.make(),
                                  gaurd.mail.text.make()
                                ],
                              )
                            ],
                          )).h(80),
                    ).w24(context).pLTRB(5, 20, 5, 0);
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

//twilio integration
class SendSmsTwilio extends StatefulWidget {
  final String title;
  const SendSmsTwilio({super.key, required this.title});

  @override
  State<SendSmsTwilio> createState() => _SendSmsTwilioState();
}

class _SendSmsTwilioState extends State<SendSmsTwilio> {
  late TwilioFlutter twilio;
  @override
  void initState() {
    twilio = TwilioFlutter(
        accountSid: 'AC459301fb0a89bc2c978967e16ad2490c',
        authToken: 'd6011acdf30ef1aefc09173a2b334d77',
        twilioNumber: '+16813956194');
    super.initState();
  }

  void sendSms() async {
    twilio.sendSMS(
        toNumber: '+919450702570',
        messageBody: 'Hii everyone this our team stealth squad.');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Icon(CupertinoIcons.arrow_right),
        onTap: () {
          sendSms();
        },
      ),
    );
  }
}
//response page

//--------------------------------------------------------------------------------------------------------------
//Profile
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onDoubleTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SendSmsTwilio(title: "helo")));
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(CupertinoIcons.qrcode),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRGenerator(
                            s: "Our team name is stealth squad" +
                                "hello " +
                                n)));
              }),
          backgroundColor: Colors.pink[50],
          // appBar: AppBar(),
          body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Placeholder().h10(context).w20(context),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Gaurdian()));
                },
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  color: Color.fromARGB(255, 231, 197, 236),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Placeholder().h10(context).w10(context).p12(),
                        "Guardian".text.headline4(context).gray500.make().p16()
                      ]),
                ).h(100).w(500),
              ).pLTRB(0, 20, 0, 0),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PoliceStation()));
                },
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  color: Color.fromARGB(255, 231, 197, 236),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Placeholder().h10(context).w10(context).p12(),
                        "Police".text.headline4(context).gray500.make().p16()
                      ]),
                ).h(100).w(500),
              ).pLTRB(0, 20, 0, 0),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HospitalList()));
                },
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  color: Color.fromARGB(255, 231, 197, 236),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Placeholder().h10(context).w10(context).p12(),
                        "Hospital".text.headline4(context).gray500.make().p16()
                      ]),
                ).h(100).w(500),
              ).pLTRB(0, 20, 0, 0),
            ]).pLTRB(0, 50, 0, 0),
          ),

          // drawer: SafeArea(
          //   child: Container(
          //     margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
          //     color: Color.fromARGB(255, 231, 197, 236),
          //     child: Column(
          //       children: ["Gaurdian".text.make()],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------------
//Gaurdian creation
class GaurdianCreate extends StatelessWidget {
  const GaurdianCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        persistentFooterAlignment: AlignmentDirectional.center,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Create Guardian"
                  .text
                  .headline3(context)
                  .make()
                  .pLTRB(0, 100, 0, 0),
              Card(
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  color: Color.fromARGB(255, 231, 197, 236),
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Name"),
                      ).pLTRB(20, 50, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Age"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Contact"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Mail ID"),
                      ).pLTRB(20, 5, 10, 20),
                      Placeholder().h10(context).w20(context),
                      ElevatedButton.icon(
                              onPressed: () {},
                              icon: Row(children: <Widget>[
                                Icon(CupertinoIcons.check_mark)
                              ]),
                              label: "check".text.make())
                          .pLTRB(0, 20, 0, 20)
                    ],
                  )).h(520).pLTRB(20, 70, 20, 30)
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------
//medical info
class Medical extends StatelessWidget {
  const Medical({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Medical Info"
                    .text
                    .headline4(context)
                    .make()
                    .pLTRB(0, 50, 0, 0),
                Card(
                    elevation: 10,
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    color: Color.fromARGB(255, 231, 197, 236),
                    child: Column(children: [
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Blood Group"),
                      ).pLTRB(20, 50, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Organs Donated"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Alergies"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Sugar Level"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: "Blood Pressure Level"),
                      ).pLTRB(20, 5, 10, 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Diseases"),
                      ).pLTRB(20, 5, 10, 20),
                      ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Disclaimer()));
                              },
                              child: Icon(CupertinoIcons.qrcode))
                          .pLTRB(0, 50, 0, 30)
                    ])).pLTRB(20, 50, 20, 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------------------------------------
//SignUp
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Placeholder().h10(context).w20(context).p(10)
              //  Image.asset("lib/assets/images/register.jpg").h(60),

              ),
          // Placeholder().h20(context).w32(context).pLTRB(0, 0, 0, 50),
          Card(
              elevation: 10,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Color.fromARGB(255, 231, 197, 236),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Name"),
                  ).pLTRB(20, 5, 10, 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Age"),
                  ).pLTRB(20, 5, 10, 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Contact"),
                  ).pLTRB(20, 5, 10, 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Mail ID"),
                  ).pLTRB(20, 5, 10, 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ).pLTRB(20, 5, 10, 20),
                  ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Medical()));
                          },
                          child: "Sign Up".text.make())
                      .pLTRB(0, 50, 0, 0)
                ],
              )).h(500),
        ],
      ),
    ));
  }
}

//-----------------------------------------------------------------------------------------------------
//login page
String n = "";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Placeholder().h10(context).w20(context).p(10)
              // Image.asset("lib/assets/images/Mobile-login.jpg")
              ),
          // Placeholder().h20(context).w32(context).pLTRB(0, 0, 0, 50),
          Card(
              elevation: 10,
              margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
              color: Color.fromARGB(255, 231, 197, 236),
              child: Column(children: [
                TextFormField(
                        onChanged: (value) {
                          n = value;
                        },
                        decoration: InputDecoration(
                            hintText: "ID",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))))
                    .pLTRB(20, 30, 10, 30),
                TextFormField(
                  cursorColor: Colors.black12,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  obscureText: true,
                ).pLTRB(20, 20, 10, 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Disclaimer()));
                            },
                            child: "Log in".text.make())
                        .py32(),
                    ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: "Sign Up".text.bold.make())
                        .py32()
                  ],
                ),
              ])),
        ],
      ),
    ));
  }
}

//------------------------------------------------------------------------------------------------------------------
//Disclaimer page
class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              "Disclaimer"
                  .text
                  .capitalize
                  .bold
                  .center
                  .headline3(context)
                  .make(),
              Card(
                // child: Placeholder().h(550).w(400),
                elevation: 20,
                child:
                    "Follow Indian cyber security laws and regulations: Make sure to comply with all Indian cyber security laws and regulations when developing Android applications. These include the Indian IT Act, which provides legal recognition to electronic documents and digital signatures, and the Cyber Crime Investigation Manual, which provides guidelines for investigating cyber crimes."
                        .text
                        .headline6(context)
                        .center
                        .fade
                        .make()
                        .p(20),
                color: Color.fromARGB(255, 231, 197, 236),
                shadowColor: Color.fromARGB(255, 221, 8, 79),
                // margin: EdgeInsets.fromLTRB(20, 100, 20, 60),
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ).h(400).pLTRB(10, 40, 10, 0),
              ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Text("Next"))
                  .w(70)
                  .p(50)
            ]),
          ),
        ),
      ),
    );
  }
}
