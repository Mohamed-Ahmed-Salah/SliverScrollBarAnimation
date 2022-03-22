import 'package:first_flutter_challenge/controller/sliver_scroll_controller.dart';
import 'package:first_flutter_challenge/widgets/background_sliver.dart';
import 'package:first_flutter_challenge/widgets/list_item_header_sliver.dart';
import 'package:first_flutter_challenge/widgets/my_header_title.dart';
import 'package:first_flutter_challenge/widgets/sliver_body_items.dart';
import 'package:first_flutter_challenge/widgets/sliver_header_data.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_challenge/controller/sliver_scroll_controller.dart';

class HomeSliverWithTab extends StatefulWidget {
  const HomeSliverWithTab({Key? key}) : super(key: key);

  @override
  _HomeSliverWithTabState createState() => _HomeSliverWithTabState();
}

class _HomeSliverWithTabState extends State<HomeSliverWithTab> {
  final bloc = SliverScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Scrollbar(
            child: ValueListenableBuilder(
              valueListenable: bloc.globalOffsetValue,
              builder: (_,double valueCurrentScroll, __) {
                print(' hinaaaaaa  $valueCurrentScroll');
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: bloc.scrollControllerGlobally,
                  slivers: [
                     _flexibleSpaceBarHeader(valueScroll: valueCurrentScroll,),
                    SliverPersistentHeader(
                      delegate: _headerSlive(bloc: bloc),
                      pinned: true,

                    ),
                    for (var i = 0; i < bloc.listCategory.length; i++) ...[
                      SliverPersistentHeader(
                        delegate: MyHeaderTitle(
                          (visble) {bloc.refreshHeader(i, visble,  i>0 ?i-1:null );},
                          bloc.listCategory[i].category,
                        ),
                      ),
                      SliverBodyItems(listItems: bloc.listCategory[i].products),
                    ],
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

class _flexibleSpaceBarHeader extends StatelessWidget {
  const _flexibleSpaceBarHeader({Key? key,required this.valueScroll}) : super(key: key);

  final double valueScroll;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      pinned: valueScroll<90 ?true :false,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundSliver(),
            Positioned(
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite, size: 30)),
              top: size.height * 0.05+(-1*valueScroll/2),
              right: size.width * 0.05,
            ),
            Positioned(
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
              top: size.height * 0.05+(-1*valueScroll/2),
              left: size.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

const _maxHeaderExtent = 100.0;

class _headerSlive extends SliverPersistentHeaderDelegate {
  _headerSlive({required this.bloc});

  final SliverScrollController bloc;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    /*print('shrink $shrinkOffset');
   print('percent $percent');*/

    // TODO: implement build
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _maxHeaderExtent,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.elasticIn,
                          opacity: shrinkOffset > 0.1 ? 1.0 : 0.0,
                          child: const Icon(Icons.arrow_back)),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(shrinkOffset > 0.1 ? 0.0 : -0.1, 0.0),
                        curve: Curves.easeIn,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Mohamed\'s Restuarant',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: shrinkOffset > 0.1
                        ? Column(
                            children: [
                              Expanded(
                                child: ListItemHeaderSliver(
                                  bloc: bloc,
                                ),
                              ),
                            ],
                          )
                        : const SliverHeaderData(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
