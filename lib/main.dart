import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<SocialMediaUsers> _treemapData;
  @override
  void initState() {
    _treemapData = getTreemapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfTreemap(
          dataCount: _treemapData.length,
          levels: [
            TreemapLevel(groupMapper: (int index) {
              return _treemapData[index].country;
            }, labelBuilder: (BuildContext context, TreemapTile tile) {
              return Padding(
                  padding: EdgeInsets.all(2.5), child: Text(tile.group));
            }, tooltipBuilder: (BuildContext context, TreemapTile tile) {
              return Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Text(
                      'Country: ${tile.group}\nSocial media: ${tile.weight}M',
                      style: TextStyle(color: Colors.white)));
            })
          ],
          weightValueMapper: (int index) {
            return _treemapData[index].usersInMillions;
          },
          legend: TreemapLegend(position: TreemapLegendPosition.bottom)),
    ));
  }

  List<SocialMediaUsers> getTreemapData() {
    return <SocialMediaUsers>[
      SocialMediaUsers('India', 'Facebook', 25.4),
      SocialMediaUsers('USA', 'Instagram', 19.11),
      SocialMediaUsers('Japan', 'Facebook', 13.3),
      SocialMediaUsers('Germany', 'Instagram', 10.65),
      SocialMediaUsers('France', 'Twitter', 7.54),
      SocialMediaUsers('UK', 'Instagram', 4.93)
    ];
  }
}

class SocialMediaUsers {
  SocialMediaUsers(this.country, this.socialMedia, this.usersInMillions);
  final String country;
  final String socialMedia;
  final double usersInMillions;
}
