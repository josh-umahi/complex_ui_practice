import 'package:complex_ui_practice/my_drawer.dart';
import 'package:flutter/material.dart';

import 'counter_page.dart';

class CustomDrawerApp extends StatefulWidget {
  const CustomDrawerApp({Key? key}) : super(key: key);

  @override
  _CustomDrawerAppState createState() => _CustomDrawerAppState();
}

class _CustomDrawerAppState extends State<CustomDrawerApp>
    with SingleTickerProviderStateMixin {
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;

  late AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void _toggleDrawer() => _animationController.isCompleted ? close() : open();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        double slide = maxSlide * _animationController.value;
        double scale = 1 - (_animationController.value * 0.3);

        return GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: Stack(
            children: [
              MyDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: _animationController.isCompleted
                    ? CounterPage(onPageClick: _toggleDrawer)
                    : CounterPage(onMenuIconClick: _toggleDrawer),
              ),
            ],
          ),
        );
      },
    );
  }
}
