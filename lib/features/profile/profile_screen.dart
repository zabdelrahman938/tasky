import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/core/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app_last_thing/main.dart';
import 'package:tasky_app_last_thing/features/profile/user_details_screen.dart';
import 'package:tasky_app_last_thing/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
 const  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
String username="Guest";
String motivationQuote="One task at a time. One step closer.";

String? userImage;

@override
  void initState() {
    super.initState();
    _loadUserDetails();
  }
_loadUserDetails()async{
  setState(() {
    username= PreferenceManager().getString("username")??"Guest";
    motivationQuote= PreferenceManager().getString("motivationQuote")??"One task at a time. One step closer.";
    userImage=PreferenceManager().getString("user_image");
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        leading: SvgPicture.asset("assets/images/arrow_back.svg"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundImage: userImage==null?
                          AssetImage("assets/images/person.png"):
                          FileImage(File(userImage!)),
                          backgroundColor: Colors.transparent,
                          radius: 60,
                        ),
                        GestureDetector(
                          onTap: ()async{
                         showImageSourceDialog(context,(XFile file){
                           _saveImage(file);
                           setState(() {
                             userImage=file.path;
                           });
                         });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.primaryContainer,
                              shape:BoxShape.circle
                            ),
                            child: Icon(Icons.camera_alt_outlined),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:8 ,),
                    Text(
                      username,
                      style:Theme.of(context).textTheme.labelLarge

                    ),
                    Text(
                    motivationQuote,
                      style:Theme.of(context).textTheme.titleSmall

                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Text(
                "Profile Info",
                style:Theme.of(context).textTheme.labelLarge

              ),
              SizedBox(height: 16,),
              ListTile(
                onTap: ()async{
       final result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>UserDetailsScreen()));
       if(result!=null&&result==true){
         _loadUserDetails();
       }
                },
              leading: CustomSvgPictureWidget(path: "assets/images/profile.svg", withColorFilter: true),
                title: Text(
                  "User Details",
                  style:Theme.of(context).textTheme.titleMedium

                ),
                trailing:CustomSvgPictureWidget(path: "assets/images/arrow-right.svg", withColorFilter: true)
              ),
              Divider(color: Color(0xff6E6E6E),thickness: 2,endIndent: 25,indent: 15,),
              ListTile(
                leading: CustomSvgPictureWidget(path: "assets/images/helal.svg", withColorFilter: true),
                title: Text(
                  "Dark Mode",
                  style:Theme.of(context).textTheme.titleMedium

                  ),
                trailing:ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                  return Switch(
                    inactiveTrackColor: Color(0xffFFFFFF),
                      value:value == ThemeMode.dark ,
                   onChanged: (bool value)async{
                        ThemeController.toggleTheme();
                   });
                    }
                )
              ),
              Divider(color: Color(0xff6E6E6E),thickness: 2,endIndent: 25,indent: 15,),
              ListTile(
                onTap: ()async{
                  PreferenceManager().remove("username");
                  PreferenceManager().remove("motivationQuote");
                  PreferenceManager().remove("tasks");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context)=>WelcomeScreen()),
                      //delete any route
                      (Route <dynamic>route)=>false,
                  );
                },
                leading: CustomSvgPictureWidget(path: "assets/images/exit.svg", withColorFilter: true),
                title: Text(
                  "Log Out",
                    style:Theme.of(context).textTheme.titleMedium

                ),
                trailing:CustomSvgPictureWidget(path: "assets/images/arrow-right.svg", withColorFilter: true)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveImage(XFile file) async{
 final appDir= await getApplicationDocumentsDirectory();
 final newFile= await File(file.path).copy("${appDir.path}/ ${file.name}");
await PreferenceManager().setString("user_image", newFile.path);
  }
}
void showImageSourceDialog(BuildContext context,Function(XFile)selectedFile){
   showDialog(context: context, builder: (BuildContext context){
     return SimpleDialog(
       title: Text("Choose Camera Source",style: Theme.of(context).textTheme.titleMedium,),
       children: [
         SimpleDialogOption(
           onPressed: ()async{
             XFile? image= await ImagePicker().pickImage(source: ImageSource.camera);
             if(image !=null){
               selectedFile(image);
             }
             Navigator.pop(context);
         },
           padding: EdgeInsets.all(16),
           child: Row(
             children: [
               Icon(Icons.camera_alt_outlined),
               SizedBox(width: 8,),
               Text("Camera"),
             ],
           ),
         ),
         SimpleDialogOption(
           onPressed: ()async{
             XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery);
             if(image !=null){
               selectedFile(image);
             }
             Navigator.pop(context);
           },
           padding: EdgeInsets.all(16),

           child: Row(
             children: [
               Icon(Icons.photo_library),
               SizedBox(width: 8,),
               Text("Gallery"),
             ],
           ),
         )
       ],
     );
   });
}