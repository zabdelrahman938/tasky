import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: Color(0xffF6F7F9),
    colorScheme: ColorScheme.light(
        primaryContainer: Color(0xffFFFFFF)
    ),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xffF6F7F9),
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xff161F1B)),
      titleTextStyle: TextStyle(color: Color(0xff161F1B),fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.w400),
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
        trackOutlineColor: WidgetStateProperty.resolveWith((state){
          if(state.contains(WidgetState.selected)){
            return Colors.transparent;

          }
          return Color(0xff9E9E9E);
        }),
        thumbColor: WidgetStateProperty.resolveWith(
                (state){
              if(state.contains(WidgetState.selected)){
                return Colors.white;

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
          color: Color(0xffD1DAD6),
          width: 2
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xffF6F7F9),
      unselectedItemColor: Color(0xff3A4640),
      selectedItemColor: Color(0xff15B86C),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
        displaySmall: TextStyle(
            color: Color(0xff161F1B),
            fontFamily: "Plus Jakarta Sans",
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),
        displayMedium: TextStyle(
            color: Color(0xff161F1B),
            fontWeight: FontWeight.w400,
            fontFamily: "Plus Jakarta Sans",
            fontSize: 24
        ),
        displayLarge: TextStyle(
            color: Color(0xff161F1B),
            fontWeight:FontWeight.w400,
            fontSize: 28,
            fontFamily: "Plus Jakarta Sans"
        ),
       headlineSmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color:Color(0xff6A6A6A),
          overflow: TextOverflow.ellipsis,
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2,
          decorationColor: Color(0xff6A6A6A),
        ),
       // headlineLarge: TextStyle(
       //      fontFamily: "Poppins",
       //      fontSize: 14,
       //      fontWeight: FontWeight.w400,
       //      color:Color(0xff6A6A6A),
       //      overflow: TextOverflow.ellipsis,
       //      decoration:TextDecoration.lineThrough,
       //      decorationColor: Color(0xff6A6A6A),
       //      decorationThickness: 3
       //  ),
        bodyMedium: TextStyle(
            color: Color(0xff3A4640),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontSize: 16
        ),
        labelSmall: TextStyle(
            color: Color(0xff161F1B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"
        ),
      labelMedium: TextStyle(
          color: Color(0xff161F1B),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 16
      ),
        labelLarge: TextStyle(
            color: Color(0xff161F1B),
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontSize: 20
        ),
      titleSmall:TextStyle(
        color: Color(0xff3A4640),
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,

      ) ,
      titleMedium: TextStyle(
        color: Color(0xff161F1B),
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,

      ),
        titleLarge: TextStyle(
            color: Color(0xff161F1B),
            fontFamily: "Plus Jakarta Sans",
            fontWeight: FontWeight.w400,
            fontSize: 32
        )
    ),
    iconTheme: IconThemeData(
      color: Color(0xff161F1B)
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
          color: Color(0xff9E9E9E),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 16
      ),
      filled: true,
      fillColor:Color(0xffFFFFFF),
      border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:BorderSide(
            color: Color(0xffD1DAD6),

          )
      ),
      enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:BorderSide(
              color: Color(0xffD1DAD6)
          )
      ),
      focusedBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(16),
         borderSide:BorderSide(
             color: Color(0xffD1DAD6)
         )
    ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: Colors.red,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.white,
      selectionHandleColor: Colors.black
    ),
    splashFactory: NoSplash.splashFactory,
    popupMenuTheme: PopupMenuThemeData(
        color: Color(0xffF6F7F9),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0xff15B86C),width: 2),
      ),
      elevation: 2,
      shadowColor: Color(0xff15B86C),
        labelTextStyle:WidgetStateProperty.all(
            TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              color: Color(0xff161F1B)
            )
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:WidgetStateProperty.all(Colors.black)
        )
    )
);