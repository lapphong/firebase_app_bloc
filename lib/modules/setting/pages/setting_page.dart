import 'package:firebase_app_bloc/blocs/blocs.dart';
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Setting', style: TxtStyle.title),
                        const SizedBox(width: 100),
                        buildToggleSwitchMode(),
                        const BellButton(),
                      ],
                    ),
                  ),
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
            //buildListView(accountSetting, 0),
            const TitleOptionSettings(title: 'APPLICATION'),
            const SizedBox(height: 16),
            //buildListView(application, 0),
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

  // check == 0 : item child ListView is arrow right
  // ListView buildListView(List<ModelSetting> list, int check) {
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: list.length,
  //     itemBuilder: (context, index) {
  //       return check == 0
  //           ? Padding(
  //               padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
  //               child: ItemsArrowSetting(
  //                 onTap: () => goToPage(context, index, list),
  //                 assetName: list[index].iconUrl,
  //                 title: list[index].title,
  //               ),
  //             )
  //           : Padding(
  //               padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
  //               child: ItemsToggleSetting(
  //                 onTap: () => chooseOption(context, index, list),
  //                 assetName: list[index].iconUrl,
  //                 title: list[index].title,
  //               ),
  //             );
  //     },
  //   );
  // }

  // void chooseOption(BuildContext context, int index, List<ModelSetting> list) {
  //   if (list == applicationToggle) {
  //     switch (index) {
  //       case 0:
  //         print('Notification');
  //         break;
  //       case 1:
  //         print('Dark mode');
  //         break;
  //     }
  //   }
  // }

  // goToPage(BuildContext context, int index, List<ModelSetting> list) {
  //   if (list == application) {
  //     switch (index) {
  //       case 0:
  //         Navigator.pushNamed(context, RouteName.downloadVideoPage);
  //         break;
  //       case 1:
  //         Navigator.pushNamed(context, RouteName.favoritePage);
  //         break;
  //       case 2:
  //         Navigator.pushNamed(context, RouteName.languagePage);
  //         break;
  //     }
  //   } else {
  //     switch (index) {
  //       case 0:
  //         print('change phone number');
  //         break;
  //       case 1:
  //         print('password');
  //         break;
  //     }
  //   }
  // }
}
