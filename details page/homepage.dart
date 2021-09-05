import 'package:amadershop/screen/cartpage.dart';



import '../pagelink/product_linker.dart';

import '../screen/detailpage.dart';

import '../widgets/singeproduct.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../model/products.dart';
import '../widgets/notification_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

ProductLinker P_Provider;



class _HomePageState extends State<HomePage> {


  Widget _buildFeature() {
    List<Product> featureProduct;

    featureProduct = P_Provider.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Featured",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: P_Provider.getFeatureHomeList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _ExtraItem() {
    List <Product> ExtraItems = P_Provider.getExtraIteamsList;
    return Column(
      children: [
        Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Extra Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(

                    child: Text("See More", style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: P_Provider.ExtraHome.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image, price: e.price, name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {

    P_Provider.getFeatureData();
    P_Provider.getExtraIteamsData();
    P_Provider.getFeatureHomeData();
    P_Provider.getExtraHomeData();
    P_Provider.getUserData();
  }

  @override
  Widget build(BuildContext context) {

    P_Provider = Provider.of<ProductLinker>(context);
    getCallAllFunction();


    return Scaffold(
      key: _key,


      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(color:Colors.black,),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.greenAccent[700],
        leading: IconButton(icon:Icon(Icons.menu,color: Colors.black,),
            onPressed: (){
              _key.currentState.openDrawer();
            }
        ),
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.black),
              onPressed:(){

              }),
          IconButton(icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black),
              onPressed:(){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => CartPage()));
              } ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(
                    height: 30,
                  ),
                  _buildFeature(),
                  _ExtraItem(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
