import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class CounterPage extends StatefulWidget {
  final Function()? onMenuIconClick;
  final Function()? onPageClick;

  CounterPage({
    this.onMenuIconClick,
    this.onPageClick,
  }) {
    assert(onMenuIconClick != null || onPageClick != null);
  }

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: widget.onPageClick,
        child: Scaffold(
          backgroundColor: ColorConstants.secondary,
          appBar: AppBar(
            backgroundColor: ColorConstants.secondary,
            leading: IconButton(
              onPressed: widget.onMenuIconClick,
              icon: Icon(
                Icons.menu,
                size: 35,
              ),
            ),
            title: Text("Flutter Naija"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstants.primary,
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
