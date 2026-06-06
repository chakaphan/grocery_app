import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController(
    text: "",
  );
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Hi, ",
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "My Name",
                        style: TextStyle(
                          color: color,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("My Name is pressed");
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                TextWidget(text: "Email@gmail.com", color: color, textSize: 18),
                const SizedBox(height: 20),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                _listTile(
                  title: "Address",
                  subtitle: "My subtitle",
                  icon: IconlyLight.profile,
                  onPressed: () async {
                    await _showAddressDialog();
                  },
                  color: color,
                ),
                _listTile(
                  title: "Orders",
                  icon: IconlyLight.bag,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: "Wishlist",
                  icon: IconlyLight.heart,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                      ctx: context,
                      routeName: WishlistScreen.routeName,
                    );
                  },
                  color: color,
                ),
                _listTile(
                  title: "Viewed",
                  icon: IconlyLight.show,
                  onPressed: () {},
                  color: color,
                ),
                _listTile(
                  title: "Forget Password",
                  icon: IconlyLight.unlock,
                  onPressed: () {},
                  color: color,
                ),
                SwitchListTile(
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  title: TextWidget(
                    text: themeState.getDarkTheme ? "Dark Mode" : "Light Mode",
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  secondary: Icon(
                    themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                ),
                _listTile(
                  title: "Logout",
                  icon: IconlyLight.logout,
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      tital: "Sign Out",
                      subtitle: "Do you wanna sign out?",
                      fct: () {},
                      context: context,
                    );
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          content: TextField(
            onChanged: (value) {
              /*print(
                "_addressTextController.text: ${_addressTextController.text}",
              );*/
            },
            controller: _addressTextController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: "Your Address"),
          ),
          actions: [TextButton(onPressed: () {}, child: const Text("Update"))],
        );
      },
    );
  }

  Widget _listTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(text: title, color: color, textSize: 22, isTitle: true),
      subtitle: subtitle != null
          ? TextWidget(text: subtitle, color: color, textSize: 18)
          : null,
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () => onPressed(),
    );
  }
}
