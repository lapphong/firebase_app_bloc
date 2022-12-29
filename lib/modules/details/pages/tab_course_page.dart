import 'package:flutter/material.dart';

class TabCoursePage extends StatefulWidget {
  const TabCoursePage({super.key});

  @override
  State<TabCoursePage> createState() => _TabCoursePageState();
}

class _TabCoursePageState extends State<TabCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // buildListCourse(
                        //     courseItem, context),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
