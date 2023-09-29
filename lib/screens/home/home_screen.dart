import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/widgets/home/profile_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");
    final user = ref.watch(userProvider);
    final isGuest = !user!.isAuthenticated;
    final usePage = useState(0);

    void onPageChanged(int index) {
      usePage.value = index;
    }

    return Scaffold(
        appBar: AppBar(actions: [
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                icon: CircleAvatar(
                  backgroundImage: isGuest
                      ? const AssetImage(Constants.defaultAvatarPath)
                          as ImageProvider<Object>?
                      : NetworkImage(user.profileImagePath),
                ),
                onPressed: () => showEndDrawer(context),
              ),
            );
          })
        ]),
        endDrawer: const ProfileDrawer(),
        body: Constants.tabPages[usePage.value],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: const FaIcon(
            FontAwesomeIcons.droplet,
            color: MyColors.pinkColor,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: StylishBottomBar(
            currentIndex: usePage.value,
            onTap: onPageChanged,
            hasNotch: true,
            items: [
              BottomBarItem(
                  icon: const Icon(Icons.home), title: const Text("Home")),
              BottomBarItem(
                  icon: const Icon(Icons.map_outlined),
                  title: const Text("Map"))
            ],
            option: AnimatedBarOptions(
                iconSize: 30.0, iconStyle: IconStyle.animated)));
  }
}
