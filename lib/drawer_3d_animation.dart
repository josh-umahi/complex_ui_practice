import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'counter_page.dart';
import 'my_drawer.dart';

class Drawer3dApp extends StatefulWidget {
  const Drawer3dApp({Key? key}) : super(key: key);

  @override
  _Drawer3dAppState createState() => _Drawer3dAppState();
}

class _Drawer3dAppState extends State<Drawer3dApp>
    with SingleTickerProviderStateMixin {
  static const double maxSlide = 300;

  late AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void _toggleDrawer() => _animationController.isCompleted ? close() : open();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed;
    bool isDragCloseFromRight = _animationController.isCompleted;
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
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          onTap: _toggleDrawer,
          child: Stack(
            // TODO: Most important info is down here
            children: [
              Transform.translate(
                offset: Offset(maxSlide * (_animationController.value - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi / 2 * (1 - _animationController.value)),
                  alignment: Alignment.centerRight,
                  child: MyDrawer2(),
                ),
              ),
              Transform.translate(
                offset: Offset(maxSlide * _animationController.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-pi * (_animationController.value / 2)),
                  alignment: Alignment.centerLeft,
                  child: CounterPage(onMenuIconClick: _toggleDrawer),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyDrawer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: ColorConstants.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SafeArea(
            child: Theme(
              data: ThemeData(brightness: Brightness.dark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 25),
                  Text(
                    "Flutter",
                    style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 0.8,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Naija",
                    style: GoogleFonts.comfortaa(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 0.8,
                    ),
                  ),
                  MenuItem(
                    title: "Messages",
                    icon: Icons.markunread_rounded,
                  ),
                  MenuItem(
                    title: "Favorites",
                    icon: Icons.star_sharp,
                  ),
                  MenuItem(
                    title: "Map",
                    icon: Icons.map_rounded,
                  ),
                  MenuItem(
                    title: "Settings",
                    icon: Icons.settings,
                  ),
                  MenuItem(
                    title: "Profile",
                    icon: Icons.person,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
