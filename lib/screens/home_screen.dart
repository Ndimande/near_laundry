import 'package:flutter/material.dart';
import 'package:near_laundry/models/booking.dart';
import 'package:near_laundry/screens/login_screen.dart';
import 'package:near_laundry/screens/registered_users_screen.dart';
import 'package:near_laundry/screens/sliding_images_screen.dart';
import 'package:near_laundry/widgets.dart/view_orders_widget.dart';
import '../providers/database_helper.dart';
import '../widgets.dart/navigation_drawer_widget.dart';
import 'chat_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  int currentIdex = 0;
  void _logout() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
    setState(() {});
  }

  void _registeredUserScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegistereUsersScreen(),
      ),
    );
    setState(() {});
  }

  void _getOrders() async {
    List<Booking> bookings = await DatabaseHelper.instance.getAllBookings();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewOrdersWidget(
          list: bookings,
        ),
      ),
    );
    setState(() {});
  }

  Widget _dotMenu() {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            autofocus: true,
            leading: const Icon(
              Icons.supervised_user_circle_rounded,
              color: Colors.cyan,
            ),
            title: const Text('Registered Users'),
            onTap: _registeredUserScreen,
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: _getOrders,
            leading: const Icon(
              Icons.dock_rounded,
              color: Colors.cyan,
            ),
            title: const Text('Your Bookings'),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.cyan,
            ),
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(
              Icons.help_outline,
              color: Colors.red,
            ),
            title: Text('Help'),
          ),
        ),
      ],
    );
  }

  final List<Widget> _pages = <Widget>[
    const SlidingImagesScreen(),
    const MapScreen(),
    const ChatScreen(),
    const Center(child: Text('Contacts')),
  ];
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: const NavigationDrawerWidget(),
          appBar: AppBar(
            elevation: 0,
            title: const Center(child: Text('')),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _dotMenu(),
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 155, 50, 137),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 9,
            currentIndex: currentIdex,
            type: BottomNavigationBarType.shifting,
            onTap: (newValue) {
              setState(() {
                currentIdex = newValue;
              });
            },
            selectedItemColor: Colors.purple,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  tooltip: 'Book for your laundry here!',
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.drive_eta_rounded,
                    color: Colors.black,
                  ),
                  tooltip: 'Track your driver!',
                  label: 'Track Driver'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Colors.black,
                  ),
                  tooltip: 'Chat with admin!',
                  label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  tooltip: 'Contact us!',
                  label: 'Contacts'),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: _pages.elementAt(currentIdex), //New
            ),
          ),
        ),
      );
}
