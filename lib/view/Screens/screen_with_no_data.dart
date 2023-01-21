import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// Todo: This widget will be shown when there is no data on favorites or cart screen
Widget emptyDataItemView({required BuildContext context,required String screenTitle}){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              SvgPicture.asset('assets/images/empty_box.svg',color: Colors.grey,height: 115.h,width: 115.w,),
              SizedBox(height: 10.h,),
              Center(
                child: Text("Your $screenTitle list is empty!",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18.sp),),
              ),
              SizedBox(height:7.5.h,),
              Center(
                child: Text("Explore products and them to $screenTitle to show them here",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 11.sp),),
              ),
            ],
          ),
        ),
        defaultButton(
            contentPadding: EdgeInsets.symmetric(vertical: 9.h,horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            onTap: ()
            {
              Navigator.pushNamed(context,"all_products_screen");
            },
            content: Text("Explore Products",style: TextStyle(color: Colors.white,fontSize: 17.sp),)
        ),
      ],
    ),
  );
}