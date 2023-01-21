import 'package:fashion_store/main.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Screens/product_details_screen.dart';
import 'package:fashion_store/view/Screens/screen_with_no_data.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/product_model.dart';
import '../../view_model/favorites_orders_view_model/favorites_orders_states.dart';
import '../Widgets/default_search_bar_widget.dart';

class CartScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = FavoritesAndOrdersCubit.getInstance(context);
    return Builder(
        builder: (context) {
          cubit.getFavorites();    // Todo: get all products that on Favorites
          return BlocConsumer<FavoritesAndOrdersCubit,FavoritesAndOrdersStates>(
              listener: (context,state)
              {
                if( state is DeleteProductFromFavoritesSuccessState )  cubit.getFavorites();   // Todo: to update favorites data
              },
              builder: (context,state){
                return Scaffold(
                  appBar: _appBarItem(cubit: cubit, context: context),
                  body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Column(
                        children:
                        [
                          searchBarItem(
                            controller: searchController,
                            margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                            onChanged: (input)
                            {

                            },
                          ),
                          state is GetFavoritesLoadingState ?
                          Expanded(child: Center(child: CupertinoActivityIndicator(radius: 12.5.h,color: mainColor,),)) :
                          Expanded(child: _productsView(cubit: cubit,state: state,context: context)),
                        ],
                      )
                  ),
                );
              }
          );
        }
    );
  }


  PreferredSizeWidget _appBarItem({required FavoritesAndOrdersCubit cubit,required BuildContext context}){
    return AppBar(
      title: const Text("Cart"),
      elevation: 0,
      leading: BackButton(
        onPressed: ()
        {
          // cubit.productsForSpecificCategory.clear();    /// as if I go on this page again , will get new data with new category id so I clear latest data
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _productItem({required List<ProductModel> products,required int index,required BuildContext context,required FavoritesAndOrdersCubit cubit}){
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
                            tag: products[index].id!,
                            child: Image.network(products[index].images![0].toString(),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)),)
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
                          evaluationButtons(),
                          SizedBox(height: 4.h,),
                          defaultButton(
                              onTap: ()
                              {
                                cubit.removeProductFromFavorites(productID: products[index].id!);
                              },
                              height: 30.h,
                              content: const Text("Remove",style: TextStyle(color: Colors.white),),
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

  Widget _productsView({required FavoritesAndOrdersCubit cubit,required FavoritesAndOrdersStates state,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: cubit.favorites.isNotEmpty ?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text("Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: mainColor),),
          SizedBox(height: 2.5.h),
          Text("${cubit.favorites.length} Products",style: TextStyle(color: Colors.grey,fontSize: 12.sp),),
          SizedBox(height: 12.h),
          if( state is! DeleteProductFromFavoritesErrorState )
            Expanded(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.favorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.8,crossAxisCount: 1,mainAxisSpacing: 20,crossAxisSpacing: 20),
                  itemBuilder: (context,index)
                  {
                    return GestureDetector(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: cubit.favorites[index]))),
                      child : _productItem(index: index,products: cubit.favorites,context: context,cubit: cubit),
                    );
                  }
              ),
            ),
        ],
      ) :
      emptyDataItemView(context: context,screenTitle: "Cart"),    // Todo: will be shown when there is no data on Favorites (( screenTitle how it will be used => Your $screenTitle be empty! ))
    );
  }
}
