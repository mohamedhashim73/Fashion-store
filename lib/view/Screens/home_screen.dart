import 'package:fashion_store/shared/network/cache_helper.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/view/Screens/display_products_for_specific_category_screen.dart';
import 'package:fashion_store/view/Screens/product_details_screen.dart';
import 'package:fashion_store/view/Widgets/default_search_bar_widget.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../view_model/home_view_model/home_states.dart';
import '../Widgets/default_displayBanners_widget.dart';
import '../Widgets/default_product_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    HomeCubit cubit = HomeCubit.getInstance(context: context);  // Todo: make an instance from cubit
    return Builder(
      builder: (context)
      {
        if( cubit.products.isEmpty ) cubit.getAllProducts(limits: 50, offset: 100, context: context);
        return Scaffold(
            appBar: appBar(context),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children:
                  [
                    searchBarItem(
                        width: mediaQuery.size.width,
                        height: 45.h,
                        controller: searchController,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                        onChanged: (input)
                        {
                          // Todo .. implementation of search for a product
                        }
                        ),
                    SizedBox(height: 12.5.h,),
                    showBanners(controller: pageViewController,images: bannersImages,height: 135.h),
                    SizedBox(height: 12.5.h,),
                    showSmoothIndicator(),
                    SizedBox(height: 10.h,),
                    _itemWithViewAllComponent(title: "Categories",context: context,pushNamedTitle: "category_screen"),   // contain a row with two texts first .. categories second .. view all categories
                    SizedBox(height: 11.h,),
                    BlocBuilder<HomeCubit,HomeStates>(
                        builder: (context,state)
                        {
                          return cubit.categories.isNotEmpty ?
                          displayCategories(cubit: cubit,categories: cubit.categories,context: context) :
                          Container();
                        }),
                    SizedBox(height: 11.h,),
                    _itemWithViewAllComponent(title: "Products",context: context,pushNamedTitle: "all_products_screen"),
                    SizedBox(height: 15.h,),
                    BlocBuilder<HomeCubit,HomeStates>(
                        builder: (context,state)
                        {
                          return cubit.products.isNotEmpty ?
                            _productsComponentsView(homeCubit: cubit):
                            const Center(child: CupertinoActivityIndicator());
                        }
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }

  // Todo: If there are Data on Products, this will be shown
  Widget _productsComponentsView({required HomeCubit homeCubit}){
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,   // Todo: The same number that I pass for getAllProducts method that on HomeCubit (( limits ))
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6,crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 20),
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: homeCubit.products[index]))),
            child: productItem(index: index,products: homeCubit.products,context: context),
            // Todo: بالنسبه للمتغير ده usedFromHomeScreen عامله عشان لو هستدعي الداله ده في صفحه عرض المنتجات هيعمل أكشن معين عند الضغط علي favorite icon
          );
        }
    );
  }

  PreferredSizeWidget appBar(BuildContext context){
    return AppBar(
      title: SvgPicture.asset('assets/images/logo.svg',color: mainColor,height: 40,width: 40,),
    );
  }

  Widget showSmoothIndicator(){
    return SmoothPageIndicator(
      controller: pageViewController,
      count: 3,
      effect: const WormEffect(
        dotHeight: 12.5,
        activeDotColor: secondColor,
        dotWidth: 12.5,
        type: WormType.thin,
      ),
    );
  }

  // Todo: this for The Row which will over categories and products view ( products - view all ) || ( categories - view all )
  Widget _itemWithViewAllComponent({required String title,required String pushNamedTitle,required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
      [
        Text(title,style : TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: mainColor),),
        GestureDetector(onTap: (){Navigator.pushNamed(context, pushNamedTitle);}, child: Text("View All",style: TextStyle(color: secondColor,fontSize:13.sp,fontWeight: FontWeight.w500),))
      ],
    );
  }

  Widget displayCategories({required HomeCubit cubit,required List<dynamic> categories,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7).r,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4,(index){
            return categoryItem(
                url: categories[index].image.toString(),
                cubit: cubit,
                categoryID: categories[index].id,
                categoryName: categories[index].name,
                context: context
            );
          })
      ),
    );
  }

  Widget categoryItem({required String url,required int categoryID,required BuildContext context,required String categoryName,required HomeCubit cubit}){
    return GestureDetector(
      onTap: ()
      {
        cubit.productsForSpecificCategory.clear();   // to get new data when I go to it
        // Todo: here navigate to page that contain all products related to this category
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayProductsForSpecificCategoryScreen(categoryID: categoryID,categoryName: categoryName,)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url),fit: BoxFit.fill)
        ),
        height: 65.h,
        width: 65.w,
      ),
    );
  }
}
