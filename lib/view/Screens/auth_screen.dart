import 'package:fashion_store/repositories/auth_repo/auth_network_repo.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Widgets/alert_message.dart';
import 'package:fashion_store/view/Widgets/default_buttons.dart';
import 'package:fashion_store/view_model/auth_view_model/auth_cubit.dart';
import 'package:fashion_store/view_model/auth_view_model/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen.dart';

/// must make it responsive as there are many problems on this screen
class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AuthCubit(authRepository: AuthNetworkRepository()),    // refer to Dependency injection as if I pass AuthNetworkRepository or AuthCacheRepository the result will be one
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/auth_banner.png"),fit: BoxFit.fill)),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 240,
                padding: const EdgeInsets.symmetric(vertical: 55),
                alignment: Alignment.bottomCenter,
                child: const Text("Login to continue process",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),),
              ),
              Container(
                height: 510,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                  color: fourthColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20.0),
                child: Column(
                  children:
                  [
                    const Expanded(
                        flex: 1,
                        child: Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17.5),))
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                _textFieldComponent(context: context,controller: nameController,hintTitle: 'UserName',iconData: Icons.person),
                                const SizedBox(height: 15,),
                                _textFieldComponent(context: context,controller: emailController,hintTitle: 'Email',iconData: Icons.email),
                                const SizedBox(height: 15,),
                                _textFieldComponent(context: context,controller: passwordController,hintTitle: 'Password',iconData: Icons.password,isSecure: true),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
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
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                                content: state is AuthLoadingState ? const CupertinoActivityIndicator(color: Colors.white,) : const Text("Login",style: TextStyle(fontSize: 17,color: Colors.white),),
                                onTap: () async
                                {
                                  await cubit.createUser(name: nameController.text, email: emailController.text,password: passwordController.text);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 15,),
                          _forgetPasswordItem(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        Icon(iconData,color: mainColor,size: 20,),
        const SizedBox(width: 15,),
        Expanded(
          child: defaultTextFormField(
              controller: controller,
              fillColor: Colors.transparent,
              inputBorder: const UnderlineInputBorder(),
              hint: hintTitle,
              obscureText: isSecure,
              hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)
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
}
