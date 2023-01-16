import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Screens/auth_screen.dart';
import 'package:fashion_store/view/Widgets/default_alert_message_widget.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/profile_view_model/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/profile_view_model/profile_states.dart';

class ProfileScreen extends StatelessWidget{
  bool isDark = false;

  ProfileScreen({super.key});
  @override
  Widget build(context){
    ProfileCubit cubit = BlocProvider.of<ProfileCubit>(context);
    return Builder(
      builder: (context) {
        if( cubit.userModel == null ) cubit.getUserInfo();   // as if I log out will get the new info
        return Scaffold(
          appBar: AppBar(title: const Text("Profile"),),
          body: BlocConsumer<ProfileCubit,ProfileStates>(
            listener:(context,state){},
              builder: (context,state){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Expanded(
                        flex: 3,
                        child: cubit.userModel != null ?
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    child: const Icon(Icons.person,size: 60,color: mainColor,),
                                  ),
                                  const SizedBox(height: 20,),
                                  Text(cubit.userModel!.name.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                ],
                              ) :
                            const CupertinoActivityIndicator(color: mainColor,)
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children:
                          [
                            _buttonItem(iconData: Icons.person,title: "Update Data",onTap: (){
                              Navigator.pushNamed(context, 'update_screen');
                            }),
                            const SizedBox(height: 15,),
                            _buttonItem(iconData: Icons.shopping_cart,title: "Orders",onTap: (){}),
                            const SizedBox(height: 15,),
                            _buttonItem(iconData: Icons.favorite,title: "Favorite",onTap: (){}),
                            const SizedBox(height: 15,),
                            _buttonItem(
                                iconData: Icons.logout,
                                title: "Log out",
                                onTap: ()
                                {
                                  cubit.logOut().then((value)
                                  {
                                    if( value == true )
                                      {
                                        cubit.userModel = null;
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
                                      }
                                    else
                                    {
                                      alertMessage(message: "Something went wrong during log out, please try again later!", messageColor: Colors.red);
                                    }
                                  });
                                }
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
          )
        );
      }
    );
  }

  Widget _buttonItem({required dynamic onTap,required String title,required IconData iconData}){
    return defaultButton(
        height: 45,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        minWidth:double.infinity,
        onTap: onTap,
        buttonColor: fourthColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Icon(iconData,color: Colors.black.withOpacity(0.5),size: 22,),
            const SizedBox(width: 15,),
            Text(title,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: mainColor),)
          ],
        )
    );
  }
}