import 'package:first_flutter_challenge/models/product_category.dart';
import 'package:flutter/material.dart';

class SliverBodyItems extends StatelessWidget {
  final List<Product> listItems;

  const SliverBodyItems({Key? key, required this.listItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = listItems[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                product.description,
                                maxLines: 4,
                                style: TextStyle(
                                     fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                product.price,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              product.image,
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                if(index ==listItems.length-1)...[
                  const SizedBox(height: 32,),
                  Container(
                    height: 0.5,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ],
            ),
          );
        },
        childCount: listItems.length,
      ),
    );
  }
}
