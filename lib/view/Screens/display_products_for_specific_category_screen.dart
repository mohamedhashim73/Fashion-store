import 'package:fashion_store/main.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Screens/product_details_screen.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/default_search_bar_widget.dart';

// Todo: محتاج اعمل اما ارجع من الاسكرينه ده يصفر list بتاعتي عشان يجيب داتا جديده
class DisplayProductsForSpecificCategoryScreen extends StatelessWidget {
  final int categoryID;   // Todo: use this value to get all products for category which depended on its ID to make a request
  final String categoryName;
  final List<dynamic> products = [];
  final TextEditingController searchController = TextEditingController();
  DisplayProductsForSpecificCategoryScreen({super.key, required this.categoryID,required this.categoryName});
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    if( cubit.productsForSpecificCategory.isEmpty ) cubit.getProductsForSpecificCategory(limits: 20, offset: 25, categoryId: categoryID);  /// made this condition not to be calling with any refresh on the screen
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {},
      builder: (context,state){
        return Scaffold(
          appBar: _appBarItem(cubit: cubit, context: context),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                searchBarItem(
                    controller: searchController,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                    onChanged: (input) {},
                ),
                state is GetProductsForSpecificCategorySuccessState ?
                  Expanded(child: _productsView(cubit: cubit)) :
                  Expanded(child: Center(child: CupertinoActivityIndicator(radius: 12.5.h,color: mainColor,),)),
              ],
            ),
          ),
        );
      }
    );
  }


  PreferredSizeWidget _appBarItem({required HomeCubit cubit,required BuildContext context}){
    return AppBar(
      title: const Text("Category"),
      elevation: 0,
      leading: BackButton(
        onPressed: ()
        {
          cubit.productsForSpecificCategory.clear();    /// as if I go on this page again , will get new data with new category id so I clear latest data
          Navigator.pop(context);
        },),
    );
  }

  Widget _productItem({required List<dynamic> products,required int index,required BuildContext context}){
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: fourthColor,
          ),
          padding: EdgeInsets.symmetric(vertical: constraints.maxHeight*0.1,horizontal: constraints.maxWidth*0.05),
          height: 145.h,
          child: Row(
            children:
            [
              SizedBox(
                width: constraints.maxWidth*0.35,
                height: double.infinity,
                child: GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: products[index]))),
                    child: Hero(
                        tag: products[index].id,
                        child: Image.network(products[index].images[0].toString(),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)),)
              ),
              SizedBox(
                width: constraints.maxWidth*0.05,
              ),
              SizedBox(
                width: constraints.maxWidth*0.5,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Text(products[index].title.toString(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 15.5.sp),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 4.h,),
                    Text("${products[index].price.toString()} \$",style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.h,),
                    elevationButtons(),
                    SizedBox(height: 4.h,),
                    defaultButton(
                        onTap: () {},
                        height: 30.h,
                        content: const Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        buttonColor: mainColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        )
                    )
                  ],
              ))
            ],
          )
        );
      }
    );
  }

  Widget _productsView({required HomeCubit cubit}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(categoryName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: mainColor),),
          SizedBox(height: 2.5.h),
          Text("${cubit.productsForSpecificCategory.length} Products",style: TextStyle(color: Colors.grey,fontSize: 12.sp),),
          SizedBox(height: 12.h),
          Expanded(
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.productsForSpecificCategory.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.8,crossAxisCount: 1,mainAxisSpacing: 20,crossAxisSpacing: 20),
                itemBuilder: (context,index)
                {
                  return GestureDetector(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: cubit.productsForSpecificCategory[index]))),
                      child : _productItem(index: index,products: cubit.productsForSpecificCategory,context: context),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget elevationButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      const [
        Icon(Icons.star,size: 18,color: Colors.orange,),
        Icon(Icons.star,size: 18,color: Colors.orange,),
        Icon(Icons.star,size: 18,color: Colors.orange,),
        Icon(Icons.star,size: 18,color: Colors.white,),
        Icon(Icons.star,size: 18,color: Colors.white,),
      ],
    );
  }
}
