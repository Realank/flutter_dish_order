import 'package:flutter/material.dart';
import '../business/DishesList.dart';
import '../views/CountButtonView.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import '../resources/theme.dart';
import 'dart:async';

typedef void IndexSelectCallBack(int index);

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderPage'),
      ),
      body: OrderPageContent(),
    );
  }
}

class OrderPageContent extends StatefulWidget {
  @override
  OrderPageContentState createState() => new OrderPageContentState();
}

class OrderPageContentState extends State<OrderPageContent> {
  final sectionTableController = SectionTableController();

  int selectedIndex;
  bool scrollingOrderList = false;
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    sectionTableController.sectionTableViewScrollTo = (section, row, scrollDown) {
      if (scrollingOrderList == false) {
        print('scroll to index');
        setState(() {
          selectedIndex = section;
        });
      }
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          //left menu type
          width: 100.0,
          child: Container(
            color: Colors.blue,
            child: TypeList(
              selectedIndex: selectedIndex,
              indexSelected: (index) {
                scrollingOrderList = true;
                setState(() {
                  selectedIndex = index;
                  sectionTableController.animateTo(index, -1).then((finish) {
                    scrollingOrderList = false;
                  });
                });
              },
            ),
          ),
        ),
        Expanded(
            //right dishes list
            child: OrderList(
          controller: sectionTableController,
        )),
      ],
    );
  }
}

class TypeList extends StatefulWidget {
  TypeList({this.controller, this.indexSelected, this.selectedIndex = 0});
  final controller;
  final selectedIndex;
  final IndexSelectCallBack indexSelected;
  @override
  TypeListState createState() => new TypeListState();
}

class TypeListState extends State<TypeList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var types = dishTypesList();
    return ListView.builder(itemBuilder: (context, index) {
      if (index >= types.length) {
        return null;
      }
      String title = types[index];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 60.0,
            color: index == widget.selectedIndex ? Colors.white : Colors.grey,
            child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  widget.indexSelected(index);
                },
                child: Center(
                  child: Text(title),
                )),
          ),
          Container(
            height: 1.0,
            color: Colors.grey,
          )
        ],
      );
    });
  }
}

class OrderList extends StatefulWidget {
  OrderList({this.controller});
  final controller;
  @override
  OrderListState createState() => new OrderListState();
}

class OrderListState extends State<OrderList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void cellSelected(BuildContext context, Dish dish) {
    print('selected ${dish.name}');
    showDialog(
      context: context,
      builder: (_) => Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                color: Colors.grey.shade100,
                width: 300.0,
                height: 350.0,
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                      width: 300.0,
                      height: 200.0,
                      child: _buildImage(dish),
                    ),
                    _buildPopupFooter(dish)
                  ]),
                )),
          )),
    );
  }

  Widget _buildPopupFooter(Dish dish) {
    return Container(
//      height: 120.0,
      padding: EdgeInsets.all(10.0),
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitleRow(dish),
          Container(
            color: Colors.transparent,
            height: 5.0,
          ),
          Text(dish.desc,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0)),
        ],
      ),
    );
  }

  Widget _buildImage(Dish dish) {
    return Stack(
      fit: StackFit.expand,
//      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          dish.imgUrl,
          fit: BoxFit.cover,
        ),
        Positioned(
            right: 8.0,
            bottom: 8.0,
            child: CountButtonView(
              initialCount: orderedCountForDish(dish),
              onChange: (count) {
                orderDish(dish, count);
              },
            )),
      ],
    );
  }

  Widget _buildTitleRow(Dish dish) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          dish.name,
          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black, fontSize: 19.0),
        ),
        Text('¥${dish.price} / ${dish.unit}',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 19.0))
      ],
    );
  }

  Widget _buildCellFooter(Dish dish) {
    return Container(
      height: 90.0,
      padding: EdgeInsets.all(10.0),
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitleRow(dish),
          Text(
            dish.desc,
            maxLines: 2,
            softWrap: true,
//              style: Theme.of(context)
//                  .textTheme
//                  .body1
//                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0)
          ),
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, Dish dish) {
    return Center(
      child: FlatButton(
        onPressed: () {
          cellSelected(context, dish);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            width: 250.0,
            height: 250.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: 250.0,
                  height: 160.0,
                  child: _buildImage(dish),
                ),
                _buildCellFooter(dish)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SectionTableView(
        sectionCount: dishTypesList().length,
        numOfRowInSection: (section) {
          return dishesInType(dishTypesList()[section]).length;
        },
        cellAtIndexPath: (section, row) {
          return _buildCell(context, dishesInType(dishTypesList()[section])[row]);
        },
        divider: Container(
          height: 3.0,
          color: Colors.transparent,
        ),
        headerInSection: (section) {
          return Container(
            color: Colors.grey,
            height: 30.0,
            child: Center(
              child: Text(dishTypesList()[section]),
            ),
          );
        },
        dividerHeight: () => 3.0,
        sectionHeaderHeight: (section) => 30.0,
        cellHeightAtIndexPath: (section, row) => 250.0,
        controller: widget.controller,
      ),
    );
  }
}
