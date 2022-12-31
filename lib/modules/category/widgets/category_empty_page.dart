import 'package:flutter/material.dart';

import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';

class CategoryEmptyPage extends StatelessWidget {
  const CategoryEmptyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: DarkTheme.primaryBlueButton900,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage(AssetPath.iconSearchCourse),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Empty Course', style: TxtStyle.headline3),
          const Text('Search your course again ', style: TxtStyle.headline5),
          const SizedBox(height: 32),
          Container(
            height: 52,
            width: 140,
            decoration: BoxDecoration(
              color: DarkTheme.primaryBlue600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Explore',
                style: TxtStyle.buttonMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
