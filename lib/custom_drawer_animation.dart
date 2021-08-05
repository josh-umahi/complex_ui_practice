import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFF5C87F7);
const secondaryColor = Color(0xFF275181);

class CustomDrawerApp extends StatefulWidget {
  const CustomDrawerApp({Key? key}) : super(key: key);

  @override
  _CustomDrawerAppState createState() => _CustomDrawerAppState();
}

class _CustomDrawerAppState extends State<CustomDrawerApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void _toggle() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _onDragStart(DragStartDetails details) {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _onDragEnd(DragEndDetails details) {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        double slide = (deviceWidth / 2) * _animationController.value;
        double scale = 1 - (_animationController.value * 0.3);

        return GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: Stack(
            children: [
              CustomDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: _animationController.isCompleted
                    ? CounterPage(onPageClick: _toggle)
                    : CounterPage(onMenuIconClick: _toggle),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: primaryColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuItem({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 35),
        Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: secondaryColor,
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
            backgroundColor: primaryColor,
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
