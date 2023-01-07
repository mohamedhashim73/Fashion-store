import 'package:fashion_store/view/Widgets/default_buttons.dart';
import 'package:fashion_store/view/Widgets/product_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/home_view_model/home_cubit.dart';
import '../../view_model/home_view_model/home_states.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> products = [];
  List<dynamic> filteredData = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    products = cubit.products;
    return Scaffold(
        appBar: isSearching ? searchBarItem(products: products) : appBarItem(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: BlocBuilder<HomeCubit,HomeStates>(
              builder: (context,state) {
                if( products.isNotEmpty )
                {
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredData.isNotEmpty ? filteredData.length : products.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6,crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 20),
                      itemBuilder: (context,index){
                        return productItem(index: index,products: filteredData.isNotEmpty ? filteredData : cubit.products);
                      }
                  );
                }
                else
                {
                  return const Center(child: CupertinoActivityIndicator());
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
      title: defaultTextFormField(
          hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
          controller: searchController,
          fillColor: Colors.transparent,
          hint: "search for product...",
          inputBorder: InputBorder.none,
          cursorColor: Colors.black,
          textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
          onChanged: (input)
          {
            addDataForFilteredData(input: input, products: products);
          },
          suffixIcon: GestureDetector(
            child: const Icon(Icons.clear,color: Colors.white,),
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
