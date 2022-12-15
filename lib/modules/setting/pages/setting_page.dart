import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../generated/l10n.dart';
import '../../../routes/route_name.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../blocs/blocs.dart';
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
                      Text(S.current.setting, style: TxtStyle.title),
                      const SizedBox(width: 100),
                      buildToggleSwitchMode(),
                      const BellButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildDeTailAccount(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TitleOptionSettings(title: S.current.accountSetting),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.current.changePhoneNumber,
              urlIcon: AssetPath.iconUser,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.current.password,
              urlIcon: AssetPath.iconPassword,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            TitleOptionSettings(title: S.current.application),
            const SizedBox(height: 16),
            //buildListView(application, 0),
            buildSettingItemsArrow(
              title: S.current.downloadVideo,
              urlIcon: AssetPath.iconDownload,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.downloadVideoPage);
              },
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.current.myFavorite,
              urlIcon: AssetPath.iconMyFavorite,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.favoritePage)
              },
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.current.language,
              urlIcon: AssetPath.iconLanguage,
              onTap: () => Navigator.pushNamed(context, RouteName.languagePage),
            ),
            const SizedBox(height: 16),
            //buildListView(applicationToggle, 1),
            const TitleOptionSettings(height: 16),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeTailAccount() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.profileStatus == ProfileStatus.error) {
          showAlertDialog(
            context,
            title: 'ERROR',
            content: state.error.toString(),
            defaultActionText: 'OK',
          );
        }
      },
      builder: (context, state) {
        if (state.profileStatus == ProfileStatus.initial) {
          return Container();
        } else if (state.profileStatus == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.profileStatus == ProfileStatus.error) {
          return const ProfileStatusError();
        }
        return SettingAccount(
          onTap: () => Navigator.of(context).pushNamed(
            RouteName.editProfilePage,
            arguments: state.user,
          ),
          fullName: state.user.name,
          userName: state.user.id,
          assetName: state.user.profileImage,
        );
      },
    );
  }

  Widget buildToggleSwitchMode() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            const Image(image: AssetImage(AssetPath.iconDarkMode)),
            ToggleSwitchButton(
              value: context.watch<ThemeCubit>().state.appTheme == AppTheme.dark
                  ? true
                  : false,
              onChanged: (value) =>
                  context.read<ThemeCubit>().changeTheme(value),
            ),
          ],
        );
      },
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
          S.current.logout,
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
