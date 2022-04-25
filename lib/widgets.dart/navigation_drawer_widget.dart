import 'package:flutter/material.dart';
import 'package:near_laundry/screens/home_screen.dart';
import 'package:near_laundry/screens/user_profile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 15);

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.blue;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      hoverColor: hoverColor,
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const name = 'Nqobani Ndimande';
    const email = 'Nqobani@gmail.com';
    const profileImage = 'login.png';

    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 155, 50, 137),
        child: ListView(children: <Widget>[
          buildHeader(
              profileImage: profileImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfile(
                      name: name,
                      profileImage: profileImage,
                    ),
                  ))),
          const SizedBox(height: 48),
          buildMenuItem(
            text: 'Home',
            icon: Icons.home,
            onClicked: () => selectedItem(context, 0),
          ),
          buildMenuItem(
            text: 'Prices',
            icon: Icons.price_change,
            onClicked: () => selectedItem(context, 1),
          ),
          buildMenuItem(
            text: 'Themes',
            icon: Icons.color_lens_outlined,
            onClicked: () => selectedItem(context, 1),
          ),
          buildMenuItem(
            text: 'Settings',
            icon: Icons.settings,
          ),
          buildMenuItem(
            text: 'About us',
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 24),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          buildMenuItem(
            text: 'View Registered users',
            icon: Icons.people_alt,
          ),
        ]),
      ),
    );
  }

  buildHeader(
          {required String profileImage,
          required String name,
          required String email,
          required Future Function() onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/login.png')),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromARGB(30, 60, 16, 1),
                child: Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 128, 59, 255),
                ),
              )
            ],
          ),
        ),
      );
}
