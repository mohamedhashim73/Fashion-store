import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Widgets/default_buttons.dart';
import 'package:fashion_store/view/Widgets/product_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/home_view_model/home_cubit.dart';
import '../../view_model/home_view_model/home_states.dart';

class DisplayAllProductsScreen extends StatefulWidget {
  const DisplayAllProductsScreen({super.key});
  @override
  State<DisplayAllProductsScreen> createState() => DisplayAllProductsScreenState();
}

class DisplayAllProductsScreenState extends State<DisplayAllProductsScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredData = [];
  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeCubit>(context).getAllProducts(limits: 50, offset: 60);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
        appBar: isSearching ? searchBarItem(products: cubit.products) : appBarItem(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: BlocBuilder<HomeCubit,HomeStates>(
              builder: (context,state) {
                if( state is GetProductsSuccessState )
                {
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredData.isNotEmpty ? filteredData.length : cubit.products.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6,crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 20),
                      itemBuilder: (context,index){
                        return productItem(index: index,products: filteredData.isNotEmpty ? filteredData : cubit.products);
                      }
                  );
                }
                else
                {
                  return const Center(child: CupertinoActivityIndicator(color: mainColor,));
                }
              }
          ),
        )
    );
  }

  PreferredSizeWidget appBarItem(){
    return AppBar(
      title: const Text("Products"),
      elevation: 0,
      actions:
      [
        IconButton(
            onPressed: ()
            {
              setState(()
              {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  PreferredSizeWidget searchBarItem({required List<dynamic> products}){
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: defaultTextFormField(
          hintStyle: const TextStyle(color: mainColor,fontWeight: FontWeight.w500,fontSize: 16),
          controller: searchController,
          fillColor: Colors.transparent,
          hint: "search for product...",
          inputBorder: InputBorder.none,
          cursorColor: Colors.black,
          textStyle: const TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 18),
          onChanged: (input)
          {
            addDataForFilteredData(input: input, products: products);
          },
          suffixIcon: GestureDetector(
            child: const Icon(Icons.clear,color: mainColor,),
            onTap: ()
            {
              /// clear all inputs on textFormField
              setState(()
              {
                filteredData.clear();
                searchController.text = '';
              });
            },
          )
      ),
    );
  }

  void addDataForFilteredData({required String input,required List<dynamic> products}){
    setState(()
    {
      filteredData = products.where((element) => element.title.toLowerCase().startsWith(input)).toList();
    });
  }
}
