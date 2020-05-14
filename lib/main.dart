import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Watch",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  TabController tb;
  int hour=0;
  int min=0;
  int sec=0;
  String timetodispaly="";
  bool started=true;
  bool stoped=true;
  int timefortimer;
  bool canceltimer=false;
  final dur=const Duration(seconds: 1);

  @override
  void initState(){
    tb=TabController(length: 2, vsync: this);
    super.initState();
  }

  void start()
  {
    setState(() {
      started=false;
      stoped=false;
    });
      timefortimer=((hour*3600)+(min*60)+sec);
      Timer.periodic(dur, (Timer t){
          setState(() {
            if(timefortimer<1 || canceltimer==true)
            {
              t.cancel();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>HomePage()
              ));
            }
            else if(timefortimer<60)
              {
                timetodispaly=timefortimer.toString();
                timefortimer=timefortimer-1;
              }else if(timefortimer<3600){
              int m=timefortimer~/60;
              int s=timefortimer-(60*m);
              timetodispaly=m.toString()+":"+s.toString();
              timefortimer=timefortimer-1;
            }
            else{
              int h=timefortimer~/3600;
              int t=timefortimer-(3600*h);
              int m=t~/60;
              int s=t-(60*m);
              timetodispaly=h.toString()+":"+m.toString()+":"+s.toString();
              timefortimer=timefortimer-1;
            }
          });
      });
  }
  void stop()
  {
    setState(() {
      started=true;
      stoped=true;
      canceltimer=true;
      timetodispaly="";
    });
  }

  Widget timer()
  {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text("HH",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              hour=val;
                            });
                          }
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text("MM",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              min=val;
                            });
                          }
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text("SS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60.0,
                          onChanged: (val){
                            setState(() {
                              sec=val;
                            });
                          }
                      )
                    ],
                  ),
                ],
              )
          ),
         Expanded(
            flex: 1,
            child: Text("$timetodispaly",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started?start :null,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 12.0),
                  child: Text("Start",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ), RaisedButton(
                  onPressed: stoped?null :stop,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 12.0),
                  child: Text("Stop",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
/////-------------------------------------////////////////
  /////////////////////////////-------------------------///////////////////////
  //////////////////////////////  stop watch //////////////////////////////////

  bool startispressed=true;
  bool stopispressed=true;
  bool resetispressed=true;

  String stoptimetodisplay="00:00:00";
  var swatch=Stopwatch();
  final durx =const Duration(seconds: 1);
  void startTimer()
  {
    Timer(durx, keepruning);
  }
  void keepruning()
  {
    if(swatch.isRunning)
      {
        startTimer();
      }
    setState(() {
      stoptimetodisplay=swatch.elapsed.inHours.toString().padLeft(2,"0")+":"+(swatch.elapsed.inMinutes%60).toString().padLeft(2,"0")+":"
                         +(swatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
    });
  }


  void stratStopwatch()
  {
    setState(() {
      stopispressed=false;
      startispressed=false;
    });
    swatch.start();
    startTimer();
  }
  void stopStopWatch()
  {
    setState(() {
      stopispressed=true;
      resetispressed=false;
    });
    swatch.stop();
  }
  void resetStopWatch()
  {
    setState(() {
      startispressed=true;
      resetispressed=true;
    });
    swatch.reset();
  }


  Widget stopwatch()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text("$stoptimetodisplay",
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
              )
          ),
          Expanded(
            flex: 4,
              child: Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed:stopispressed?null: stopStopWatch,
                          padding: EdgeInsets.symmetric(horizontal: 20.0
                              ,vertical: 14.0),
                          color: Colors.red,
                          child: Text("Stop",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed:resetispressed?null: resetStopWatch,
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 20.0
                              ,vertical: 14.0),
                          child: Text("Reset",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    RaisedButton(
                      onPressed:startispressed?stratStopwatch :null,
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 20.0
                      ,vertical: 14.0),
                      child: Text("start",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ) ,
              )
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("Awatch"),
        bottom: TabBar(
            tabs:<Widget>[
              Text("Timer"),
              Text("StopWatch"),
            ],
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.only(
            bottom: 10.0
          ),
          unselectedLabelColor: Colors.blue[100],
          controller: tb,
        ),
      ),
      body: TabBarView(
          children:<Widget>[
            timer(),//coustome widget
            stopwatch(),
          ],
        controller: tb,
      ),
    );
  }

}

