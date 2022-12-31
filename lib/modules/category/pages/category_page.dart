import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/assets_path.dart';
import '../../../generated/l10n.dart';
import '../../../models/models.dart';
import '../../../repositories/app_repository/app_base.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../../home/blocs/blocs.dart';
import '../cubits/cubits.dart';
import '../widgets/widgets.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryNameCubit>(
          create: (context) =>
              CategoryNameCubit(appBase: context.read<AppBase>()),
        ),
        BlocProvider<CategoryFilterCubit>(
          create: (context) => CategoryFilterCubit(
            categoryNameCubit: BlocProvider.of<CategoryNameCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<CategoryListProductCubit>(
          create: (context) => CategoryListProductCubit(
            appBase: context.read<AppBase>(),
            categoryFilterCubit: BlocProvider.of<CategoryFilterCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<CategoryFilteredCubit>(
          create: (context) => CategoryFilteredCubit(
            categoryListProductCubit:
                BlocProvider.of<CategoryListProductCubit>(context),
          ),
          lazy: false,
        ),
      ],
      child: const CategoryView(),
    );
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryNameCubit>().getAllCategoryName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleCategory(),
                buildTextFieldSearch(context),
                const SizedBox(height: 24),
                SizedBox(height: 36, child: buildListCategoryName()),
                const SizedBox(height: 24),
                Text(
                  '0 Result',
                  style: TxtStyle.headline3.copyWith(color: DarkTheme.red),
                ),
                buildListProductFiltered(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListProductFiltered() {
    return BlocBuilder<CategoryFilteredCubit, CategoryFilteredState>(
      builder: (context, state) {
        if (state.status == CategoryFilteredStatus.isEmpty) {
          return const CategoryEmptyPage();
        } else if (state.status == CategoryFilteredStatus.isLoading) {
          return Center(
              child: Column(
            children: const [
              SizedBox(height: 40),
              CupertinoActivityIndicator(
                color: DarkTheme.white,
              ),
            ],
          ));
        }
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: state.filteredProduct.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Divider(),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ItemsFilteredCategory(
                titleCourse: state.filteredProduct[index].title,
                teacherID: state.filteredProduct[index].teacherID,
                imgUrl: state.filteredProduct[index].image,
              ),
            );
          },
        );
      },
    );
  }

  Widget buildListCategoryName() {
    return BlocBuilder<CategoryNameCubit, CategoryNameState>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.list.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: filterButton(context, state.list[index], index),
            );
          },
        );
      },
    );
  }

  Widget filterButton(BuildContext context, Category categoryName, index) {
    return TextButton(
      onPressed: () =>
          context.read<CategoryFilterCubit>().changeFilter(categoryName, index),
      child: Text(
        categoryName.categoryName,
        style: TxtStyle.headline2.copyWith(
          color: context.watch<CategoryFilterCubit>().state.filterCategory ==
                  categoryName
              ? DarkTheme.primaryBlue600
              : DarkTheme.greyScale500,
        ),
      ),
    );
  }

  Widget buildTextFieldSearch(BuildContext context) {
    return TextFieldSearch(
      hintText: S.of(context).searchYourFocus,
      key: const Key('categoryPage_searchInput_textField'),
      onChange: (textSearch) => {},
      //debounce.run(() => context.read<SignInCubit>().emailChanged(email)),
    );
  }

  Widget buildTitleCategory() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Category', style: TxtStyle.title),
          SquareButton(
            bgColor: DarkTheme.greyScale800,
            edge: 40,
            radius: 10,
            child: ImageIcon(size: 13, AssetImage(AssetPath.iconBell)),
          ),
        ],
      ),
    );
  }
}