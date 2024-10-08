import 'package:flutter/material.dart';
import 'package:ready_custom_widgets/feature/bottom_nav_bar/custom_navbar.dart';
import 'package:ready_custom_widgets/feature/drawer_menu/custom_drawer_menu.dart';
import 'package:ready_custom_widgets/feature/hidden_drawer_menu/hidden_drawer.dart';
import 'package:ready_custom_widgets/feature/loading_bar/custom_loading_bar.dart';
import 'package:ready_custom_widgets/feature/lottie_animations/lottie_animations.dart';
import 'package:ready_custom_widgets/feature/register_screen/custom_login.dart';
import 'package:ready_custom_widgets/feature/second_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:ready_custom_widgets/feature/slidable_widget/slidable_widget.dart';

class WidgetsList extends StatefulWidget {
  const WidgetsList({super.key});

  @override
  State<WidgetsList> createState() => _WidgetsListState();
}

class _WidgetsListState extends State<WidgetsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Center(
            child: Text(
          'All Custom Widgets',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        // backgroundColor: const Color(0xff7695FF),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _CustomListTile(
                title: 'Drawer Menu',
                subTitle: 'Gradiyan renk geçişli menü',
                isVerifiy: true,
                goWidget: DrawerMenuScreen()),
            _CustomListTile(
                title: 'Login Screen',
                subTitle: 'Kişiselleştirmeye hazır giriş yapma ekranı',
                isVerifiy: true,
                goWidget: CustomLoginView()),
            _CustomListTile(
                title: 'Loading Bar Widget',
                subTitle: 'Özel bekleme animasyonları',
                isVerifiy: true,
                goWidget: LoadingBar()),
            _CustomListTile(
                title: 'Bottom Nav Bar',
                subTitle: 'Custom BottomNavBar with google_nav_bar package',
                isVerifiy: true,
                goWidget: CustomBottomNavBar()),
            _CustomListTile(
                title: 'Hidden Drawer Menu',
                subTitle: 'Gizlenebilir özel menü tasarımı.',
                isVerifiy: true,
                goWidget: HiddenDrawer()),
            _CustomListTile(
                title: 'Bottom Nav Bar (Basic) ',
                subTitle: 'İndex mantığı ile. Basit alt menü. ',
                isVerifiy: true,
                goWidget: CustomBottomNavBarSecond()),
            _CustomListTile(
                title: 'Slidable Widget',
                subTitle: 'Kaydırılabilir ve özelleştirilebilir liste',
                isVerifiy: true,
                goWidget: CustomSlidabeWidget()),
            _CustomListTile(
                title: 'Animation',
                subTitle: 'Lottie hazır animasyon.',
                isVerifiy: false,
                goWidget: LottieAnimationView())
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isVerifiy;
  final Widget goWidget;

  const _CustomListTile({
    // ignore: unused_element (super.key)
    super.key,
    required this.title,
    required this.subTitle,
    required this.isVerifiy,
    required this.goWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(subTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        leading: Icon(
            isVerifiy ? Icons.verified : Icons.contact_support_outlined,
            size: 35,
            color:
                isVerifiy ? const Color(0xff007AFF) : const Color(0xffFF3B30)),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                const begin = Offset(1.0, 0.0); // Sağdan sola kayma
                const end = Offset.zero; // Son konum
                const curve = Curves.easeInOut; // Animasyonun eğrisi

                var tween = Tween(begin: begin, end: end);
                var offsetAnimation =
                    animation.drive(tween.chain(CurveTween(curve: curve)));

                return SlideTransition(
                  position: offsetAnimation,
                  child: goWidget,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
