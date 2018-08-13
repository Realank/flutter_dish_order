import 'package:flutter/material.dart';
import 'package:flutter_dish_order/pages/OrderPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Center(child: LoginInput())
        ],
      ),
    );
  }
}

class LoginInput extends StatefulWidget {
  LoginInput({Key key}) : super(key: key);

  @override
  _LoginInputState createState() => new _LoginInputState();
}

/// State for [TextFieldExample] widgets.
class _LoginInputState extends State<LoginInput> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _pswController = new TextEditingController();
  @override
  void dispose() {
    print('dispose text field');
    _nameController.dispose();
    _pswController.dispose();
    super.dispose();
  }

  Widget textFieldWithController(TextEditingController controller, String placeholder) {
    return TextField(
        style: TextStyle(fontSize: 19.0, color: Colors.black),
        controller: controller,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            labelText: placeholder,
            border: new OutlineInputBorder(
              // 输入框的边框
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: 300.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          textFieldWithController(_nameController, 'Name'),
          Divider(
            color: Colors.transparent,
          ),
          textFieldWithController(_pswController, 'Password'),
          Divider(
            color: Colors.transparent,
            height: 50.0,
          ),
          new RaisedButton(
            onPressed: () {
              login(context, _nameController.text, _pswController.text);
            },
            child: new Text('登陆'),
          ),
        ],
      ),
    );
  }
}

void login(BuildContext context, String name, String password) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage()));
}
