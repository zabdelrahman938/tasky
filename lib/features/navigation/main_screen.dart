import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app_last_thing/features/tasks/completed_screen.dart';
import 'package:tasky_app_last_thing/features/home/home_screen.dart';
import 'package:tasky_app_last_thing/features/profile/profile_screen.dart';
import 'package:tasky_app_last_thing/features/tasks/to_do_screen.dart';

class MainScreen extends StatefulWidget {
const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
      final List<Widget>_screens = [
         HomeScreen(),
        ToDoScreen(),
        CompletedScreen(),
        ProfileScreen()
      ];

    int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (int? index){
            setState(() {
              _currentIndex=index??0;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: _buildSvgPicture( "assets/images/home1.svg",0),
               label:"Home"
            ),
            BottomNavigationBarItem(
                icon:_buildSvgPicture("assets/images/todo.svg",1),
                label:"ToDo"
            ),
            BottomNavigationBarItem(
                icon: _buildSvgPicture( "assets/images/done.svg",2),
                label:"Completed"
            ),
            BottomNavigationBarItem(
                icon: _buildSvgPicture( "assets/images/profile.svg",3),
                label:"Profile"
            ),


          ],
      ),
      body: _screens[_currentIndex],
    );
  }

  SvgPicture _buildSvgPicture(String path,int index) {
    return SvgPicture.asset(
               path,
                colorFilter: ColorFilter.mode(_currentIndex==index?Color(0xff15B86C):Color(0xffC6C6C6), BlendMode.srcIn),
              );
  }
}
