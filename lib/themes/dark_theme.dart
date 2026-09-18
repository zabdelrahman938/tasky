import 'package:flutter/material.dart';

ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: Color(0xff181818),
    colorScheme: ColorScheme.dark(
      primaryContainer: Color(0xff282828)
    ),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff181818),
      centerTitle: false,
      iconTheme: IconThemeData(color: Color(0xfffffcfc)),
      titleTextStyle: TextStyle(color: Color(0xffFFFCFC),fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.w400),
    ),
    switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
                (state){
              if(state.contains(WidgetState.selected)){
                return Color(0xff15B86C);
              }
              return Color(0xffe6e0e9);
            }
        ),
        thumbColor: WidgetStateProperty.resolveWith(
                (state){
              if(state.contains(WidgetState.selected)){
                return Color(0xffe6e0e9);
              }
              return Color(0xff9E9E9E);
            }
        )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                Color(0xff15B86C)
            ),
            foregroundColor: WidgetStateProperty.all(
                Color(0xffFFFCFC)
            ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            )
          )
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff15B86C),
      foregroundColor: Color(0xffFFFCFC),
      extendedTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"
      )
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side:BorderSide(
          color: Color(0xff6E6E6E),
          width: 2
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff181818),
      unselectedItemColor: Color(0xffC6C6C6),
      selectedItemColor: Color(0xff15B86C),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
    displaySmall: TextStyle(
        color: Color(0xffFFFCFC),
        fontFamily: "Plus Jakarta Sans",
        fontSize: 16,
        fontWeight: FontWeight.w400
    ),
    displayMedium: TextStyle(
        color: Color(0xffFFFFFF),
        fontWeight: FontWeight.w400,
        fontFamily: "Plus Jakarta Sans",
        fontSize: 24
    ),
    displayLarge: TextStyle(
        color: Color(0xffFFFCFC),
        fontWeight:FontWeight.w400,
        fontSize: 28,
        fontFamily: "Plus Jakarta Sans"
    ),
      headlineSmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:Color(0xffA0A0A0),
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough,
        decorationThickness: 2,
        decorationColor: Color(0xffA0A0A0),
      ),
      // headlineLarge: TextStyle(
      //     fontFamily: "Poppins",
      //     fontSize: 14,
      //     fontWeight: FontWeight.w400,
      //     color:Color(0xffA0A0A0),
      //     overflow: TextOverflow.ellipsis,
      //     decoration:TextDecoration.lineThrough,
      //     decorationColor: Color(0xffA0A0A0),
      //     decorationThickness: 3
      // ),
      bodyMedium: TextStyle(
          color: Color(0xffC6C6C6),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 16
      ),
      labelSmall: TextStyle(
          color: Color(0xffFFFCFC),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"
      ),
      labelMedium: TextStyle(
          color: Color(0xffFFFCFC),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 16
      ),
      labelLarge: TextStyle(
          color: Color(0xffFFFCFC),
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 20
      ),
      titleSmall: TextStyle(
        color: Color(0xffC6C6C6),
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis
      ),
      titleMedium: TextStyle(
        color: Color(0xffFFFCFC),
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: TextStyle(
          color: Color(0xffFFFCFC),
          fontFamily: "Plus Jakarta Sans",
          fontWeight: FontWeight.w400,
          fontSize: 32
      ),

  ),
    iconTheme: IconThemeData(
      color: Color(0xffFFFCFC)
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
          color: Color(0xff6D6D6D),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 16
      ),
      filled: true,
      fillColor:Color(0xff282828),
      border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none
      ),
      errorBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(
      color: Colors.red
  ),
),

    ),
    textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
      selectionColor: Colors.black,
      selectionHandleColor: Colors.white,
  ),
    splashFactory: NoSplash.splashFactory,
    popupMenuTheme: PopupMenuThemeData(
        color: Color(0xff181818),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xff15B86C),width: 2)
      ),
    elevation: 2,
    shadowColor:Color(0xff15B86C),
    labelTextStyle:WidgetStateProperty.all(
        TextStyle(
            fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFCFC)
        )
    )

  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:WidgetStateProperty.all(Colors.white)
    )
  )




);