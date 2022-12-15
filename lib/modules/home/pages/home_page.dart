import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                buildDeTailAccount(),
                buildTextFieldSearch(context),
                const SizedBox(height: 20),
                const Discount(),
                buildTitleContentHome(S.of(context).bestMentors, S.current.seeAll),
                const SizedBox(height: 14),
                //buildListMentors(),
                const SizedBox(height: 20),
                buildTitleContentHome(S.of(context).classPreview, S.current.seeAll),
                const SizedBox(height: 14),
                //buildGridViewPreview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldSearch(BuildContext context) {
    return TextFieldSearch(
      hintText: S.of(context).searchYourFocus,
      key: const Key('homePage_searchInput_textField'),
      onChange: (textSearch) => {},
      //debounce.run(() => context.read<SignInCubit>().emailChanged(email)),
      //errorText: state.email.invalid ? 'Email is valid' : null,
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarHome(url: state.user.profileImage),
                const BellButton(),
              ],
            ),
            const SizedBox(height: 20),
            Text(S.current.hi(state.user.name), style: TxtStyle.headline2),
            Text(
              S.of(context).welcomeBackToUdemy,
              style: TxtStyle.headline5.copyWith(color: DarkTheme.greyScale500),
            ),
          ],
        );
      },
    );
  }

  // GridView buildGridViewPreview() {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     shrinkWrap: true,
  //     mainAxisSpacing: 23,
  //     crossAxisSpacing: 23,
  //     childAspectRatio: 5 / 6.299,
  //     physics: const ScrollPhysics(),
  //     children: preview
  //         .map(
  //           (e) => ClassPreview(
  //             title: e.title,
  //             assetName: e.imageUrl,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  // SizedBox buildListMentors() {
  //   return SizedBox(
  //     height: 192,
  //     child: ListView.builder(
  //       itemCount: mentor.length,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return index == 0
  //             ? Mentor(
  //                 assetName: mentor[index].imageUrl,
  //                 name: mentor[index].name,
  //                 title: mentor[index].title,
  //                 onTap: () {},
  //               )
  //             : Padding(
  //                 padding: const EdgeInsets.only(left: 10.0),
  //                 child: Mentor(
  //                   assetName: mentor[index].imageUrl,
  //                   name: mentor[index].name,
  //                   title: mentor[index].title,
  //                   onTap: () {},
  //                 ),
  //               );
  //       },
  //     ),
  //   );
  // }

  Widget buildTitleContentHome(String textTitle, String textButton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTitle, style: TxtStyle.headline3),
        TextButton(
          onPressed: () => {},
          child: Text(
            textButton,
            style: TxtStyle.headline6.copyWith(color: DarkTheme.primaryBlue600),
          ),
        ),
      ],
    );
  }
}
