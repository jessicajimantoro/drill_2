import 'package:drill_2/src/dependency_injection.dart';
import 'package:drill_2/src/models/hero_model.dart';
import 'package:drill_2/src/view_models/home_view_model.dart';
import 'package:drill_2/src/widgets/custom_sliver_grid.dart';
import 'package:drill_2/src/widgets/custom_sliver_instrinsic_grid.dart';
import 'package:drill_2/src/widgets/horizontal_list_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel =
      DependencyInjection.container.resolve<HomeViewModel>();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List<HeroModel> _agiHeroes = [];
  List<HeroModel> _intHeroes = [];
  List<HeroModel> _strHeroes = [];

  List<HeroModel> _meleeHeroes = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await widget.viewModel.getAllHeroes();

      setState(() {
        _agiHeroes = widget.viewModel.getAgiHero(10);
        _intHeroes = widget.viewModel.getIntHero(10);
        _strHeroes = widget.viewModel.getStrHero(10);
        _meleeHeroes = widget.viewModel.getMeleeHero(page: _currentPage);
      });
    });

    _scrollController.addListener(() {
      double pixels = _scrollController.position.pixels;
      double maxExtent = _scrollController.position.maxScrollExtent - 100;

      if (pixels >= maxExtent) {
        setState(() {
          if (_meleeHeroes.length != _currentPage) {
            _currentPage++;
            _meleeHeroes.addAll(
              widget.viewModel.getMeleeHero(
                page: _currentPage,
              ),
            );
          }
        });
        // load next..
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Hero Banner'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(18.0),
            sliver: CustomSliverGrid(
              itemCount: _strHeroes.length,
              widget: (index) => [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index + 1 % 9)],
                      // child: Text('grid item $index'),
                    ),
                  ),
                ),
                Text(
                  _strHeroes[index].localizedName,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(18.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Section 1',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: HorizontalListView(
              height: 160.0,
              itemCount: _agiHeroes.length,
              widget: (int index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    color: Colors.yellow[100 * (index + 1 % 9)],
                    child: Center(
                      child: Text(
                        _agiHeroes[index].localizedName,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(18.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Section 2',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.pink[100 * (index + 1 % 9)],
                    ),
                  ),
                  title: Text(
                    _intHeroes[index].localizedName,
                  ),
                  subtitle: Text(_intHeroes[index].attackType),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Buy Now'),
                  ),
                ),
              ),
              childCount: _intHeroes.length,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(18.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Section 3',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CustomSliverIntrinsicGrid(
            crossAxisCount: 2,
            children: _meleeHeroes
                .map(
                  (e) => Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints.tightForFinite(),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Container(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Text(e.localizedName),
                        Text(e.primaryAttribute),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Buy Again'),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
