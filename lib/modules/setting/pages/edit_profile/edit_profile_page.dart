import 'package:firebase_app_bloc/modules/setting/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../../../repositories/profile_repository.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/debounce.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../../authentication/authentication.dart';
import '../../widgets/setting_widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;
  static final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(
        profileRepository: context.read<ProfileRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(child: _buildBody()),
      ),
    );
  }

  Widget buildTextFieldName(String displayLastName) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFieldName(
          initialValue: user.name,
          key: const Key('editForm_nameInput_textField'),
          onChange: (name) => debounce.run(() => context
              .read<EditProfileBloc>()
              .add(NameChangedEvent(name: name))),
          errorText: state.name.invalid ? 'Name is valid' : null,
        );
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitleAndSave(),
          const TitleOptionSettings(title: 'EDIT AVATAR', height: 32),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: buildChangeAvatar(),
          ),
          const TitleOptionSettings(title: 'EDIT INFORMATION', height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildTextFieldName(user.name),
                const SizedBox(height: 24),
                buildTextFieldEmail(user.email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChangeAvatar() {
    return BodyItemNetwork(
      assetName: user.profileImage,
      height: 64,
      widthImg: 64,
      mid: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassicButton(
              widthRadius: 2,
              width: 117,
              height: 32,
              radius: 7,
              color: DarkTheme.greyScale800,
              colorRadius: DarkTheme.primaryBlue600,
              child: Center(
                child: Text(
                  'Change Avatar',
                  style: TxtStyle.buttonSmall.copyWith(
                    color: DarkTheme.primaryBlue600,
                  ),
                ),
              ),
            ),
            Text(
              'Edit avatar are visible only on ontari.',
              style: TxtStyle.headline6.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        ),
      ),
      right: const Text(''),
    );
  }

  Widget buildTextFieldEmail(String displayEmail) {
    return TextFieldEmail(
      key: const Key('editForm_emailInput_textField'),
      initialValue: user.email,
      enable: false,
      readOnly: true,
    );
  }

  Widget buildTitleAndSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleSetting(title: 'Edit Profile'),
          ClassicButton(
            onTap: () {},
            width: 60,
            height: 32,
            radius: 12,
            widthRadius: 0,
            colorRadius: DarkTheme.primaryBlue600,
            color: DarkTheme.primaryBlue600,
            child: const Center(child: Text('Save')),
          ),
        ],
      ),
    );
  }
}
