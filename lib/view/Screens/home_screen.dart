import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/view/Screens/display_products_for_specific_category_screen.dart';
import 'package:fashion_store/view/Screens/product_details_screen.dart';
import 'package:fashion_store/view/Widgets/search_bar_item.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../view_model/home_view_model/home_states.dart';
import '../Widgets/displayBanners.dart';
import '../Widgets/product_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);  /// make an instance from cubit
    return Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
              [
                searchBarItem(
                    controller: searchController,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    onChanged: (input)
                    {
                      // Todo .. implementation of search for a product
                    }),
                const SizedBox(height: 15,),
                showBanners(controller: pageViewController,images: bannersImages),
                const SizedBox(height: 12.5,),
                showSmoothIndicator(),
                const SizedBox(height: 12.5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: mainColor),),
                    GestureDetector(onTap: (){Navigator.pushNamed(context, 'category_screen');}, child: const Text("View All",style: TextStyle(color: secondColor,fontSize:13,fontWeight: FontWeight.w500),))
                  ],
                ),
                const SizedBox(height: 15,),
                BlocBuilder<HomeCubit,HomeStates>(
                    builder: (context,state)
                    {
                      return cubit.categories.isNotEmpty ?
                            displayCategories(cubit: cubit,categories: cubit.categories,context: context) :
                            Container();
                    }
                    ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    const Text("Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: mainColor),),
                    GestureDetector(onTap: (){Navigator.pushNamed(context, 'all_products_screen');}, child: const Text("View All",style: TextStyle(color: secondColor,fontSize:13,fontWeight: FontWeight.w500),))
                  ],
                ),
                const SizedBox(height: 20,),
                BlocBuilder<HomeCubit,HomeStates>(
                  builder: (context,state) {
                    if( cubit.products.isNotEmpty  )
                      {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,   /// The same number that I put on when I call getProducts on MultiProvider on main.dart file
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6,crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 20),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: cubit.products[index]))),
                                  child: productItem(index: index,products: cubit.products));
                            }
                        );
                      }
                    else
                      {
                        return const Center(child: CupertinoActivityIndicator());
                      }
                  }
                ),
              ],
            ),
          ),
        )
    );
  }

  PreferredSizeWidget appBar(){
    return AppBar(
      title: SvgPicture.asset('assets/images/logo.svg',color: mainColor,height: 40,width: 40,),
      actions:
      [
        IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list_sharp))
      ],
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

  Widget displayCategories({required HomeCubit cubit,required List<dynamic> categories,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) => categoryItem(url: categories[index].image.toString(),categoryID: categories[index].id,categoryName: categories[index].name,context: context))
      ),
    );
  }

  Widget categoryItem({required String url,required int categoryID,required BuildContext context,required String categoryName}){
    return GestureDetector(
      onTap: ()
      {
        // Todo: here navigate to page that contain all products related to this category
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayProductsForSpecificCategoryScreen(categoryID: categoryID,categoryName: categoryName,)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url),fit: BoxFit.fill)
        ),
        height: 70,
        width: 70,
      ),
    );
  }
}
