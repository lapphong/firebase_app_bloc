import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/modules/setting/widgets/setting_items_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../widgets/setting_widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Setting', style: TxtStyle.title),
                      const SizedBox(width: 100),
                      buildToggleSwitchMode(),
                      const BellButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SettingAccount(
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   RouteName.editProfilePage,
                      //   arguments: detail,
                      // );
                    },
                    fullName: 'Barly Vallendito',
                    userName: 'barlyvallendito',
                    assetName: AssetPath.imgAvatar,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const TitleOptionSettings(title: 'ACCOUNT SETTING'),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: 'Change Phone Number',
              urlIcon: AssetPath.iconUser,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: 'Password',
              urlIcon: AssetPath.iconPassword,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            const TitleOptionSettings(title: 'APPLICATION'),
            const SizedBox(height: 16),
            //buildListView(application, 0),
            buildSettingItemsArrow(
              title: 'Download Video',
              urlIcon: AssetPath.iconDownload,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.downloadVideoPage);
              },
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: 'My Favorite',
              urlIcon: AssetPath.iconMyFavorite,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.favoritePage)
              },
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: 'Language',
              urlIcon: AssetPath.iconLanguage,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.languagePage)
              },
            ),
            const SizedBox(height: 16),
            //buildListView(applicationToggle, 1),
            const TitleOptionSettings(
              height: 16,
              color: DarkTheme.greyScale800,
            ),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildToggleSwitchMode() {
    return Row(
      children: [
        const Image(image: AssetImage(AssetPath.iconDarkMode)),
        ToggleSwitchButton(
          value: true,
          onChanged: (value) => {},
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      context.read<AppBloc>().add(SignOutEvent());
    }
  }

  Widget buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: TextButton(
        onPressed: () => _confirmSignOut(context),
        child: Text(
          'Logout',
          style: TxtStyle.headline4.copyWith(color: DarkTheme.red),
        ),
      ),
    );
  }

  Widget buildSettingItemsArrow({
    required String title,
    required String urlIcon,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SettingItemsArrow(
        onTap: onTap,
        title: title,
        assetName: urlIcon,
      ),
    );
  }
}
