import 'package:fashion_store/main.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Screens/product_details_screen.dart';
import 'package:fashion_store/view/Widgets/default_buttons_widget.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/default_search_bar_widget.dart';

// Todo: محتاج اعمل اما ارجع من الاسكرينه ده يصفر list بتاعتي عشان يجيب داتا جديده
class DisplayProductsForSpecificCategoryScreen extends StatelessWidget {
  int categoryID;   /// use to get all products for category which depend on its ID
  String categoryName;
  List<dynamic> products = [];
  TextEditingController searchController = TextEditingController();
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                searchBarItem(
                    controller: searchController,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                    onChanged: (input)
                    {
                      /// implementation of search for a product
                    }),
                state is GetProductsForSpecificCategorySuccessState ?
                Expanded(child: _productsView(cubit: cubit)) :
                const Expanded(child: Center(child: CupertinoActivityIndicator(),)),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: fourthColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 12.0),
      height: 200,
      child: Row(
        children:
        [
          Expanded(
              flex:2,
              child: GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(model: products[index]))),
              child: Hero(
                tag: products[index].id,
                  child: Image.network(products[index].images[0].toString(),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)))),
          const SizedBox(width: 15,),
          Expanded(
              flex:3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
                  Text(products[index].title.toString(),style: const TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 15.5),overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 7,),
                  Text("${products[index].price.toString()} \$",style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2.5,),
                  elevationButtons(),
                  const SizedBox(height: 2.5,),
                  defaultButton(
                      onTap: ()
                      {
                        /// add to cart implementation method needed
                      },
                      content: const Text("Add to Cart",style: TextStyle(color: Colors.white),),
                    buttonColor: mainColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  )
                ],
              )
          ),
        ],
      )
    );
  }

  Widget _productsView({required HomeCubit cubit}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(categoryName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: mainColor),),
          const SizedBox(height: 2.5),
          Text("${cubit.productsForSpecificCategory.length} Products",style: const TextStyle(color: Colors.grey,fontSize: 12),),
          const SizedBox(height: 10),
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
