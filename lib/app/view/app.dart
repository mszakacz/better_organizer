import 'package:better_organizer/app/app.dart';
import 'package:flutter/material.dart';
import 'package:better_organizer/app/router/router.dart';
import 'package:better_organizer/contact_list/contact_list.dart';
import 'package:better_organizer/new_contact/new_contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_list_repository/contact_list_repository.dart';
import 'package:better_organizer/view_contact/view_contact.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.contactListRepository,
    required this.contactRepository,
  }) : super(key: key);
  final ContactListRepository contactListRepository;
  final ContactRepository contactRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ContactListRepository>.value(
            value: widget.contactListRepository),
        RepositoryProvider<ContactRepository>.value(
            value: widget.contactRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ContactListBloc(
                contactListRepository:
                    RepositoryProvider.of<ContactListRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ViewContactBloc(
                contactRepository:
                    RepositoryProvider.of<ContactRepository>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Better Organizer',
          home: const MainPage(
            title: 'Better Organizer',
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    ContactListPage(),
    Text(
      'Index 2: To Do List',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Better Organizer'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact List',
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'To Do List',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.lime,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
