import 'package:fashion_store/shared/constants/colors.dart';
import 'package:flutter/material.dart';

Widget productItem({required List<dynamic> products,required int index}){
  return Container(
    clipBehavior: Clip.none,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black.withOpacity(0.5))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(0),
          alignment: AlignmentDirectional.topEnd,
          child: GestureDetector(
            onTap: ()
            {
              // here add add to favorite method
            },
            child: const Icon(Icons.favorite,color: secondColor,),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Image.network(products[index].images[0],fit: BoxFit.fill,width: double.infinity,),
              const SizedBox(height: 20,),
              Text(products[index].title,style: const TextStyle(fontWeight: FontWeight.bold,color: mainColor,fontSize: 16.5),overflow: TextOverflow.ellipsis,maxLines: 1,),
              const SizedBox(height: 7),
              Text("${products[index].price.toString()} \$",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
              const SizedBox(height: 7,),
              Row(
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
        ),
      ],
    ),
  );
}