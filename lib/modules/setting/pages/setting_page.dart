import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/modules/setting/widgets/items_toggle_setting.dart';
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
                      Text(S.of(context).setting, style: TxtStyle.title),
                      const BellButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildDeTailAccount(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TitleOptionSettings(title: S.of(context).accountSetting),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.of(context).changePhoneNumber,
              urlIcon: AssetPath.iconUser,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.of(context).password,
              urlIcon: AssetPath.iconPassword,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            TitleOptionSettings(title: S.of(context).application),
            const SizedBox(height: 16),
            //buildListView(application, 0),
            buildSettingItemsArrow(
              title: S.of(context).downloadVideo,
              urlIcon: AssetPath.iconDownload,
              onTap: () {
                //Navigator.pushNamed(context, RouteName.downloadVideoPage);
              },
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.of(context).myFavorite,
              urlIcon: AssetPath.iconMyFavorite,
              onTap: () => Navigator.pushNamed(context, RouteName.favoritePage),
            ),
            const SizedBox(height: 16),
            buildSettingItemsArrow(
              title: S.of(context).language,
              urlIcon: AssetPath.iconLanguage,
              onTap: () => Navigator.pushNamed(context, RouteName.languagePage),
            ),
            const SizedBox(height: 16),
            buildSettingItemsSwitchDarkMode(),
            const SizedBox(height: 16),

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
          return const StatusError();
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

  Widget buildSettingItemsSwitchDarkMode() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final value = context.select((ThemeCubit bloc) => bloc.state.appTheme);

        onChangedFunction(value) {
          context.read<ThemeCubit>().changeTheme(value);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ItemsToggleSetting(
            assetName: AssetPath.iconDarkMode,
            title: 'Dark Mode',
            onValue: context.select((ThemeCubit bloc) => bloc.state.appTheme) ==
                    AppTheme.dark
                ? true
                : false,
            onChanged: (value) => onChangedFunction(value),
            onTap: () =>
                onChangedFunction(value != AppTheme.dark ? true : false),
          ),
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
          S.of(context).logout,
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
