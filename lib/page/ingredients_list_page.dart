import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simplebar/model/ingredient.dart';
import '../provider/ingredients_notifier.dart';
import '../supplemental/ingredients_list.dart';
import 'page.dart';

class IngredientListPage extends StatefulWidget with PageWithTitle {
  IngredientListPage({this.title: ''});

  final String title;

  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_scrollable_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: IngredientGroup.values.length - 1,
      vsync: this,
    );
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ingredientsNotifier = context.watch<IngredientsPoolNotifier>();

    final tabs = IngredientGroup.values.skip(1).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: TabBar(
        indicatorColor: Theme.of(context).accentColor,
        controller: _tabController,
        isScrollable: true,
        tabs: [
          for (final tab in tabs)
            Tab(
                text: tab
                    .toString()
                    .replaceAll('IngredientGroup.', '')
                    .replaceAll('_', ' ')
                    .toUpperCase()),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final tab in tabs)
            ingredientsNotifier.loadIngredients(tab).length > 0
                ? IngredientsList(ingredientsNotifier.loadIngredients(tab))
                : Center(child: Text('There is nothing here now'))
        ],
      ),
    );
  }
}
