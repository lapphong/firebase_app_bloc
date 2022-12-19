import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:firebase_app_bloc/modules/setting/blocs/blocs.dart';
import 'package:firebase_app_bloc/repositories/storage_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../assets/assets_path.dart';
import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/profile_repository.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../../authentication/authentication.dart';
import '../../widgets/setting_widgets.dart';
import 'package:formz/formz.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(
        profileRepository: context.read<ProfileRepository>(),
        storageRepository: context.read<StorageRepository>(),
        user: user,
      ),
      child: EditProfileView(user: user),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.user});
  final User user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  static final debounce = Debounce(milliseconds: 1000);
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        print('⚡⚡ co vao');
        context
            .read<EditProfileBloc>()
            .add(NameUnfocusedEvent(nameOld: widget.user.name));
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.imageSourceActionSheetIsVisible) {
          _showImageSourceActionSheet(context);
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
          context.read<ProfileCubit>().getProfile(uid: widget.user.id);
          snackBarSuccess(context);
        }
        if (state.status.isSubmissionFailure) {
          print("LỖI UPDATE:${state.errorMessage.toString()}");
          snackBarError(context, state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        return _buildBody(context);
      },
    );
  }

  Widget buildTextFieldName() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFieldName(
          initialValue: widget.user.name,
          key: const Key('editForm_nameInput_textField'),
          inputType: TextInputAction.done,
          autoFocus: true,
          nameFocusNode: _nameFocusNode,
          onChange: (name) => debounce.run(() => context
              .read<EditProfileBloc>()
              .add(NameChangedEvent(name: name))),
          errorText: state.name.invalid ? S.of(context).nameIsValid : null,
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTitleAndSave(context),
              TitleOptionSettings(title: S.of(context).editAvatar, height: 32),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: buildChangeAvatar(),
              ),
              TitleOptionSettings(
                  title: S.of(context).editInformation, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    buildTextFieldName(),
                    const SizedBox(height: 24),
                    buildTextFieldEmail(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChangeAvatar() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return BodyItemNetwork(
          height: 70,
          widthImg: 64,
          mid: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassicButton(
                  onTap: () =>
                      context.read<EditProfileBloc>().add(ChangeAvatarEvent()),
                  widthRadius: 2,
                  width: 117,
                  height: 32,
                  radius: 7,
                  color: DarkTheme.greyScale800,
                  colorRadius: DarkTheme.primaryBlue600,
                  child: Center(
                    child: Text(
                      S.of(context).changeAvatar,
                      style: TxtStyle.buttonSmall.copyWith(
                        color: DarkTheme.primaryBlue600,
                      ),
                    ),
                  ),
                ),
                Text(
                  S.of(context).editAvatarAreVisibleOnlyOnUdemy,
                  style: TxtStyle.headline6
                      .copyWith(color: DarkTheme.greyScale500),
                ),
              ],
            ),
          ),
          right: const Text(''),
          child: state.avatarPath != null
              ? Image.file(File(state.avatarPath!), fit: BoxFit.cover)
              : CachedNetworkImage(
                  imageUrl: widget.user.profileImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      const Image(image: AssetImage(AssetPath.imgLoading)),
                  errorWidget: (context, url, error) =>
                      const Image(image: AssetImage(AssetPath.imgError)),
                ),
        );
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    selectImageSource(imageSource) {
      context
          .read<EditProfileBloc>()
          .add(OpenImagePickerEvent(imageSource: imageSource));
    }

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        elevation: 0,
        isDismissible: false,
        backgroundColor: DarkTheme.greyScale800,
        context: context,
        builder: (context) => Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: DarkTheme.white),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            ListTile(
              leading: const Icon(Icons.photo_album, color: DarkTheme.white),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    }
  }

  Widget buildTextFieldEmail() {
    return TextFieldEmail(
      key: const Key('editForm_emailInput_textField'),
      initialValue: widget.user.email,
      enable: false,
      readOnly: true,
    );
  }

  Widget buildTitleAndSave(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleSetting(title: S.of(context).editProfile),
          BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              return ClassicButton(
                onTap: () =>
                    context.read<EditProfileBloc>().add(SaveProfileChanges()),
                width: 60,
                height: 32,
                radius: 12,
                widthRadius: 0,
                colorRadius: state.status.isSubmissionInProgress
                    ? DarkTheme.greyScale600
                    : DarkTheme.primaryBlue600,
                color: state.status.isSubmissionInProgress
                    ? DarkTheme.greyScale600
                    : DarkTheme.primaryBlue600,
                child: Center(
                    child: state.status.isSubmissionInProgress
                        ? const Text('...')
                        : const Text('Save')),
              );
            },
          ),
        ],
      ),
    );
  }

  void snackBarSuccess(BuildContext context) {
    return showSnackBar(
      context,
      S.of(context).snackBarSuccessfully(S.of(context).editProfile),
      Image.asset(AssetPath.iconUser),
    );
  }

  void snackBarError(BuildContext context, String e) {
    return showSnackBar(
      context,
      '${S.of(context).snackBarFailed(S.of(context).editProfile)} : $e',
      Image.asset(AssetPath.iconClose, color: DarkTheme.red),
    );
  }
}
