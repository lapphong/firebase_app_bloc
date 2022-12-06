import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../../authentication/authentication.dart';
import '../widgets/setting_widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;

  Widget buildTextFieldName(String displayLastName) {
    return TextFieldName(
      initialValue: user.name,
      key: const Key('editForm_nameInput_textField'), onChange: (name) => {},
      //debounce.run(() => context.read<SignUpCubit>().nameChanged(name)),
      //errorText: state.name.invalid ? 'Name is valid' : null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
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
              ),
              const TitleOptionSettings(
                title: 'EDIT AVATAR',
                height: 32,
                color: DarkTheme.primaryBlueButton,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BodyItemNetwork(
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
                          style: TxtStyle.headline6.copyWith(
                            color: DarkTheme.greyScale500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  right: const Text(''),
                ),
              ),
              const TitleOptionSettings(
                title: 'EDIT INFORMATION',
                height: 32,
                color: DarkTheme.primaryBlueButton,
              ),
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
        ),
      ),
    );
  }
}
