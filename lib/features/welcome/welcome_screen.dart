import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/constance/storage_key.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_textFormField_widget.dart';
import 'package:tasky_app_last_thing/features/home/home_screen.dart';
import 'package:tasky_app_last_thing/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
   WelcomeScreen({super.key});
  final TextEditingController _controller=TextEditingController();
  final GlobalKey<FormState> _key =GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSvgPictureWidget(path: "assets/images/Logo.svg", withColorFilter: false),
                                 // SvgPicture.asset("assets/images/Logo.svg"),
                                  SizedBox(width: 16,),
                                  Text(
                                      "Tasky",
                                    style:Theme.of(context).textTheme.displayLarge

                                  )
                                ],
                              ),
                              SizedBox(height: 108,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Welcome To Tasky ",
                                    style: Theme.of(context).textTheme.displayMedium

                                  ),
                                  SizedBox(width: 8,),
                                  SvgPicture.asset("assets/images/waving-hand.svg")
                                ],
                              ),
                              SizedBox(height: 8,),
                              Text(
                                  "Your productivity journey starts here.",
                                style: Theme.of(context).textTheme.displaySmall
                              ),
                              SizedBox(height: 28,),
                              CustomSvgPictureWidget(path: "assets/images/pana.svg", withColorFilter: false,width:215 ,height:200 ,),

                              SizedBox(height: 28,),
                        ],
                      ),
                    ),
                    CustomTextFormFieldWidget(
                      controller: _controller,
                      title: "Full Name",
                      hintText: "e.g. Sarah Khalid",
                      maxLines: 1,
                      validator: (String? value){
                        if(value==null||value.trim().isEmpty){
                          return "please enter your user name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24,),
                    ElevatedButton.icon(
                        onPressed: ()async{
                         if(_key.currentState!.validate()){
                       await PreferenceManager().setString(StorageKey.username, _controller.text);
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MainScreen()));
                         }else{
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("please enter your user name"))
                           );
                         }
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff15B86C),
                        foregroundColor: Color(0xffFFFCFC),
                        fixedSize: Size(MediaQuery.of(context).size.width, 44)
                      ),
                      label: Text("Let’s Get Started"),
                    )
                  ],
                ),
              ),
          ),
          ),
      )
    );
  }
}
