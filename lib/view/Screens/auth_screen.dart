import 'package:fashion_store/repositories/auth_repo/auth_network_repo.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Widgets/default_alert_message_widget.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/auth_view_model/auth_cubit.dart';
import 'package:fashion_store/view_model/auth_view_model/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return BlocProvider(
      create: (context)=> AuthCubit(authRepository: AuthNetworkRepository()),    // refer to Dependency injection as if I pass AuthNetworkRepository or AuthCacheRepository the result will be one
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/auth_banner.png"),fit: BoxFit.fill)),
            child: Column(
              children: [
                Container(
                  height: (mediaQuery.size.height)*0.31,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 30.r),
                  child: Text("Login to continue process",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.5.sp,color: Colors.white),),
                ),
                Container(
                  height: (mediaQuery.size.height)*0.69,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                    color: fourthColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20.0),
                  child: LayoutBuilder(
                    builder: (context,constraints){
                      return Column(
                        children:
                        [
                          SizedBox(
                            height:constraints.maxHeight*0.18,
                            width:constraints.maxWidth,
                            child: Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17.5.sp),)),
                          ),
                          // const SizedBox(height: 20),
                          SizedBox(
                            height:constraints.maxHeight*0.82,
                            width:constraints.maxWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      _textFieldComponent(context: context,controller: nameController,hintTitle: 'UserName',iconData: Icons.person),
                                      SizedBox(height: 10.h,),
                                      _textFieldComponent(context: context,controller: emailController,hintTitle: 'Email',iconData: Icons.email),
                                      SizedBox(height: 10.h,),
                                      _textFieldComponent(context: context,controller: passwordController,hintTitle: 'Password',iconData: Icons.password,isSecure: true),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25.h,),
                                BlocConsumer<AuthCubit,AuthStates>(
                                  listener: (context,state){
                                    if ( state is AuthSuccessState ) Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
                                    if ( state is AuthErrorState )
                                    {
                                      var snackBar = alertMessage(message: "Error during login, try again later", messageColor: Colors.red);
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  builder: (context,state){
                                    AuthCubit cubit = BlocProvider.of<AuthCubit>(context);   // to use it on widgets
                                    return defaultButton(
                                      buttonColor: mainColor,
                                      minWidth: double.infinity,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                                      content: state is AuthLoadingState ?
                                          _loadingForLogin() :
                                          Text("Login",style: TextStyle(fontSize: 17.sp,color: Colors.white),),
                                        onTap: () async
                                      {
                                        await cubit.createUser(name: nameController.text, email: emailController.text,password: passwordController.text);
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 15.h,),
                                _forgetPasswordItem(),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldComponent({required BuildContext context,required TextEditingController controller,required IconData iconData,required String hintTitle,bool isSecure = false}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:
      [
        Icon(iconData,color: mainColor,size: 20),
        SizedBox(width: 15.w,),
        Expanded(
          child: defaultTextFormField(
              controller: controller,
              fillColor: Colors.transparent,
              inputBorder: const UnderlineInputBorder(),
              hint: hintTitle,
              obscureText: isSecure,
              hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13.sp)
          ),
        ),
      ],
    );
  }

  Widget _forgetPasswordItem(){
    return const Text.rich(
      TextSpan(
          children:
          [
            TextSpan(text: 'forget your password? '),
            TextSpan(text: 'Click here',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
          ]
      ),
    );
  }
  
  Widget _loadingForLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
        CupertinoActivityIndicator(radius:10.w,color: Colors.white),
        SizedBox(width: 15.w,),
        Text("Processing",style: TextStyle(fontSize: 17.sp,color: Colors.white),),
      ],
    );
  }
}
