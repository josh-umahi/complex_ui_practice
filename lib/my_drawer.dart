import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: ColorConstants.primary,
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