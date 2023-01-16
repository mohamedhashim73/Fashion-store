import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/constants/colors.dart';
import '../../view_model/home_view_model/home_states.dart';
import 'display_products_for_specific_category_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"),elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context,state) {
            List categories = BlocProvider.of<HomeCubit>(context).categories;
            if( categories.isNotEmpty )
            {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio:0.8,crossAxisCount: 2,mainAxisSpacing: 5.h,crossAxisSpacing: 15.w),
                itemBuilder: (context,index){
                  return buildCategoryItem(categories:categories,index: index,context: context);
                }
            );
            }
            else
            {
              return const Center(child: CupertinoActivityIndicator(),);
            }
          }
        ),
      ),
    );
  }

  // widgets I used on this page
  Widget buildCategoryItem({required List categories,required int index,required BuildContext context}){
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayProductsForSpecificCategoryScreen(categoryID: categories[index].id,categoryName: categories[index].name,)));
      },
      child: LayoutBuilder(
        builder: (context,constraints) {
          return Column(
            children:
            [
              Expanded(child: Image.network(categories[index].image.toString(),height: constraints.maxHeight*0.7,width: double.infinity,fit: BoxFit.cover,)),
              SizedBox(height: constraints.maxHeight*0.1),
              SizedBox(height:constraints.maxHeight*0.2,child: Text(categories[index].name.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color:mainColor,fontWeight: FontWeight.bold,fontSize: 17.sp),))
            ],
          );
        }
      ),
    );
  }
}
