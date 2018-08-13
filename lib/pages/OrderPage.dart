import 'package:flutter/material.dart';
import '../business/DishesList.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderPage'),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(child: OrderList()),
        ],
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  void cellSelected(BuildContext context, Dish dish) {
    print('selected ${dish.name}');
    showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: Theme.of(context),
            child: Center(
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
        });
  }

  Widget _buildPopupFooter(Dish dish) {
    return Container(
//      height: 120.0,
      padding: EdgeInsets.all(10.0),
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildTitleRow(dish),
          Text(
            dish.desc,
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Dish dish) {
    return Image.network(
      dish.imgUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTitleRow(Dish dish) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          dish.name,
          style: TextStyle(color: Colors.black, fontSize: 19.0, decoration: TextDecoration.none),
        ),
        Text(
          '¥${dish.price } / ${dish.unit}',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w800,
              fontSize: 19.0,
              decoration: TextDecoration.none),
        )
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
        children: <Widget>[
          _buildTitleRow(dish),
          Text(
            dish.desc,
            maxLines: 2,
            softWrap: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, int index) {
    if (index >= dishes.length) {
      return null;
    }
    Dish dish = dishes[index];
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FlatButton(
          onPressed: () {
            cellSelected(context, dish);
          },
          child: SizedBox(
            width: 250.0,
            height: 250.0,
            child: Column(
              children: <Widget>[Expanded(child: _buildImage(dish)), _buildCellFooter(dish)],
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
      child: ListView.builder(itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return _buildCell(context, index ~/ 2);
        } else {
          return Container(
            height: 10.0,
            color: Colors.transparent,
          );
        }
      }),
    );
  }
}
