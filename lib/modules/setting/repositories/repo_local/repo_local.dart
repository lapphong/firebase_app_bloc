import 'dart:convert';

import 'package:firebase_app_bloc/assets/assets_path.dart';
import 'package:firebase_app_bloc/modules/setting/models/language.dart';
import 'package:flutter/material.dart';

class RepoLocal {
  static Future<List<Language>> getLanguage(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString(AssetPath.listLanguageJson);
    final body = json.decode(data);

    return body.map<Language>(Language.fromJson).toList();
  }
}
