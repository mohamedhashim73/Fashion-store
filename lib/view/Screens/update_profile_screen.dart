import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Widgets/default_alert_message_widget.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/profile_view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/profile_view_model/profile_states.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: BlocConsumer<ProfileCubit,ProfileStates>(
            listener:(context,state){
              if( state is UpdateUserDataErrorState )
                {
                  alertMessage(message: state.error, messageColor: Colors.red);
                }
              if( state is UpdateUserDataSuccessState )
                {
                  Navigator.pushReplacementNamed(context, 'profile_screen');
                }
            },
            builder: (context,state){
              return Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    expansionTileComponent(expansionTileTitle: "Change Email", textFieldHint: "new email", controller: emailController),
                    const SizedBox(height: 20,),
                    expansionTileComponent(expansionTileTitle: "Change Name", textFieldHint: "new name", controller: nameController),
                    const SizedBox(height: 20,),
                    ExpansionTile(
                      title: const Text("Change Password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                      backgroundColor: Colors.transparent,
                      collapsedIconColor: mainColor,
                      collapsedTextColor: mainColor,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 12.5),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      collapsedBackgroundColor: fourthColor,
                      children:
                      [
                        defaultTextFormField(
                            controller: passwordController,
                            hint:"New Password",
                            inputBorder: const OutlineInputBorder()
                        ),
                        const SizedBox(height: 15),
                        defaultTextFormField(
                            controller: confirmPasswordController,
                            hint:"Confirm Password",
                            validateMethod: (val)
                            {
                               return confirmPasswordController.text != passwordController.text && passwordController.text.isNotEmpty ? "Password on two Fields must be the same" : null;
                            },
                            inputBorder: const OutlineInputBorder()
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    defaultButton(
                      onTap: ()
                      {
                        // Todo: method for update user data
                        if( formKey.currentState!.validate() && ( passwordController.text.isNotEmpty || nameController.text.isNotEmpty || emailController.text.isNotEmpty))
                        {
                          cubit.updateUserData(
                              name: nameController.text.isNotEmpty ? nameController.text : null,
                              password: passwordController.text.isNotEmpty ? passwordController.text : null,
                              email: emailController.text.isNotEmpty ? emailController.text : null,
                          );
                        }
                      },
                      buttonColor: mainColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                      content: Text(state is UpdateUserDataLoadingState ? "Loading..." : "Confirm Update",style: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),),
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  // Todo: use it with name and email as if every one of this have only one textField
  Widget expansionTileComponent({required String expansionTileTitle,required String textFieldHint,required TextEditingController controller}){
    return ExpansionTile(
      title: Text(expansionTileTitle,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
      backgroundColor: Colors.transparent,
      collapsedIconColor: mainColor,
      collapsedTextColor: mainColor,
      tilePadding: const EdgeInsets.symmetric(horizontal: 12.5),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      collapsedBackgroundColor: fourthColor,
      children:
      [
        defaultTextFormField(
            controller: controller,
            hint: textFieldHint,
            inputBorder: const OutlineInputBorder()
        ),
      ],
    );
  }
}
