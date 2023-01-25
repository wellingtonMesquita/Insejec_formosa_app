import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final ScrollController _homeController = ScrollController();

  Widget meuLayoutWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 20, 1, 0),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [_circleLogo(), _listViewBody(context)],
      ),
    );
  }

  Widget _circleLogo() {
    return Center(
        child: CircleAvatar(
      backgroundColor: Colors.brown.shade800,
      radius: 50,
      //child: const Text('Insejec Formosa'),
    ));
  }

  Widget _listViewBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Expanded(
      child: ListView.separated(
          controller: _homeController,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Card(
                clipBehavior: Clip.hardEdge,
                color: const Color.fromRGBO(100, 100, 200, 0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: SizedBox(
                    width: width * 0.8,
                    height: height * 0.7,
                    child: const Text('Ministração 3/10/1997'),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
                thickness: 1,
              ),
          itemCount: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: meuLayoutWidget(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_new_rounded),
            label: 'Open Dialog',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          switch (index) {
            case 0:
              // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                _homeController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              }
              break;
            case 1:
              showModal(context);
              break;
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
