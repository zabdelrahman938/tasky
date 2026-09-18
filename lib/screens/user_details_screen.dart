import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/services/preference_manager.dart';
import 'package:tasky_app_last_thing/widgets/custom_textFormField_widget.dart';

class UserDetailsScreen extends StatefulWidget {
 const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
final TextEditingController usernameController=TextEditingController();

final TextEditingController motivationQuoteController=TextEditingController();

final GlobalKey<FormState>_key=GlobalKey();
@override
  void initState() {
    super.initState();
    _fillUserDetails();
  }
_fillUserDetails()async{
  usernameController.text =  PreferenceManager().getString("username")??"Guest";
  motivationQuoteController.text =  PreferenceManager().getString("motivationQuote")??"One task at a time. One step closer.";

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                controller: usernameController,
                title: "User Name",
                hintText: "Zeinab",
                maxLines: 1,
                validator: (String? value){
               if(value==null||value.trim().isEmpty){
                 return"Please Enter Your User Name";
               }
               return null;
              },),
              SizedBox(height: 20,),
              CustomTextFormFieldWidget(
                controller: motivationQuoteController,
                title: "Motivation Quote",
                hintText: "One task at a time. One step closer.",
                maxLines: 5,
                validator: (String? value){
                  if(value==null||value.trim().isEmpty){
                    return"Please Enter Your Motivation Quote";
                  }
                  return null;
                },),
              Spacer(),
              ElevatedButton(
                onPressed: ()async{
                  if(_key.currentState!.validate()){
                   await  PreferenceManager().setString("username", usernameController.text);
                   await  PreferenceManager().setString("motivationQuote", motivationQuoteController.text);
                   Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize:Size( MediaQuery.of(context).size.width, 45),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,fontSize: 14),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
