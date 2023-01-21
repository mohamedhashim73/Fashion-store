import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Todo: بالنسبه للمتغير ده usedFromHomeScreen عامله عشان لو هستدعي الداله ده في صفحه عرض المنتجات هيعمل أكشن معين عند الضغط علي favorite icon
Widget productItem({required List<dynamic> products,required int index,required BuildContext context,bool usedFromHomeScreen = true}){
  return LayoutBuilder(
    // Todo: for responsive padding take => 0.05*2 = 0.1 favorite Icon take => 0.9 last item take => 0.76
    builder: (context,constraints){
      final cubit = FavoritesAndOrdersCubit.getInstance(context);
      return Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth*0.075,vertical: constraints.maxHeight*0.05),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black.withOpacity(0.5))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: constraints.maxHeight*0.1,
              alignment: AlignmentDirectional.topEnd,
              child: StatefulBuilder(
                  builder: (context,setState) {
                    return GestureDetector(
                      child: cubit.favoritesStatus[products[index].id] == true ? const Icon(Icons.favorite,color: mainColor) : const Icon( Icons.favorite_border,color: mainColor),
                      onTap:()
                      {
                        // Todo: Add Item to Favorite or remove it ( Firestore )
                        setState(()
                        {
                          if( cubit.favoritesStatus[products[index].id] == true )    // This mean that this place on Favorites as it has a value
                          {
                            cubit.removeProductFromFavorites(productID: products[index].id);       // pass place id
                            cubit.favoritesStatus[products[index].id] = false;
                            if( usedFromHomeScreen == false ) BlocProvider.of<HomeCubit>(context).getAllProducts(limits: 10, offset: 80, context: context);    // Todo: عاملها عشان لو ف صفحه عرض كل المنتجات ضفت منتج للمفضله او حذفته تتحدث الداتا في صفحه HomeScreen .... خلي بالك داخل الميثود ده فيه استدعاء getFavorites
                          }
                          else
                          {
                            cubit.addProductToFavorites(model: products[index]);
                            cubit.favoritesStatus[products[index].id] = true;
                            if( usedFromHomeScreen == false ) BlocProvider.of<HomeCubit>(context).getAllProducts(limits: 10, offset: 80, context: context);    // Todo: عاملها عشان لو ف صفحه عرض كل المنتجات ضفت منتج للمفضله او حذفته تتحدث الداتا في صفحه HomeScreen
                          }
                        });
                      },
                    );
                  }
              ),
            ),
            SizedBox(height: constraints.maxWidth*0.05,),  // 0.05 0.05 0.7 0.1 0.08
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight*0.73,
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (ctx,constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Image.network(products[index].images[0],fit: BoxFit.fill,width: double.infinity,height: constraints.maxHeight*0.55,),
                    SizedBox(height: constraints.maxHeight*0.1,),
                    SizedBox(
                      height: constraints.maxHeight*0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text(products[index].title,style: TextStyle(fontWeight: FontWeight.bold,color: mainColor,fontSize: 16.5.sp),overflow: TextOverflow.ellipsis,maxLines: 1,),
                          SizedBox(height: constraints.maxHeight*0.03,),
                          Text("${products[index].price.toString()} \$",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                          SizedBox(height: constraints.maxHeight*0.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            const [
                              Icon(Icons.star,size: 18,color: Colors.orange,),
                              Icon(Icons.star,size: 18,color: Colors.orange,),
                              Icon(Icons.star,size: 18,color: Colors.orange,),
                              Icon(Icons.star,size: 18,color: Colors.white,),
                              Icon(Icons.star,size: 18,color: Colors.white,),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
}