import 'package:firebase_app_bloc/modules/setting/models/language.dart';
import 'package:firebase_app_bloc/modules/setting/widgets/setting_widgets.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../repositories/repositories.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleSetting(title: 'Change Language'),
                buildListLanguage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Language>> buildListLanguage(BuildContext context) {
    return FutureBuilder(
      future: RepoLocal.getLanguage(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lang = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lang.length,
            itemBuilder: (context, index) {
              final langData = lang[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: ItemLanguage(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    print(index);
                  },
                  iconChecked: selectedIndex == index
                      ? const Image(
                          image: AssetImage(AssetPath.iconChecked),
                          color: DarkTheme.primaryBlue600,
                        )
                      : const Text(''),
                  style: selectedIndex == index
                      ? TxtStyle.headline4
                          .copyWith(color: DarkTheme.primaryBlue600)
                      : TxtStyle.headline4,
                  assetName: langData.urlIcon,
                  nameLang: langData.title,
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
