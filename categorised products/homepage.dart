import '../model/categoryicons.dart';
import '../pagelink/product_linker.dart';
import '../pagelink/catagory_linker.dart';
import '../screen/listproduct.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import '../model/products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

CategoryLinker C_Provider;
ProductLinker P_Provider;

class _HomePageState extends State<HomePage> {
  Widget _CategoryDesign(String image) {
    return CircleAvatar(
      maxRadius: 45,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 50,
        child: Image(
          image: NetworkImage(image),
        ),
      ),
    );
  }

  MediaQueryData mediaQuery;

  Widget _ImageSlider() {
    return Container(
        height: 130,
        child: Carousel(
          dotColor: Colors.black,
          autoplay: true,
          dotSize: 5,
          images: [
            AssetImage("images/web_fornt2.png"),
            AssetImage("images/web_front.PNG"),
          ],
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.blueAccent.withOpacity(0.5),
          borderRadius: true,
        ));
  }

  Widget _MouseIcon() {
    List<CategoryIcons> MouseIcon = C_Provider.getMouseIcon;
    List<Product> Mouse = C_Provider.getMouseList;
    return Row(
        children: MouseIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Mouse",
                snapShot: Mouse,
              ),
            ),
          );
        },
        child: _CategoryDesign(
          e.image,
        ),
      );
    }).toList());
  }

  Widget _KeyBoardIcon() {
    List<CategoryIcons> KeyBoardIcon = C_Provider.getKeyboardIcon;
    List<Product> Keyboard = C_Provider.getKeyboardList;
    return Row(
        children: KeyBoardIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Keyboard",
                snapShot: Keyboard,
              ),
            ),
          );
        },
        child: _CategoryDesign(
          e.image,
        ),
      );
    }).toList());
  }

  Widget _HeadSetIcon() {
    List<CategoryIcons> HeadsetIcon = C_Provider.getHeadSetIcon;
    List<Product> Headset = C_Provider.getHeadSetList;
    return Row(
        children: HeadsetIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "HeadSet",
                snapShot: Headset,
              ),
            ),
          );
        },
        child: _CategoryDesign(
          e.image,
        ),
      );
    }).toList());
  }

  Widget _MonitorIcon() {
    List<CategoryIcons> MonitorIcon = C_Provider.getMonitorIcon;
    List<Product> Monitor = C_Provider.getMonitorList;
    return Row(
        children: MonitorIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Monitor",
                snapShot: Monitor,
              ),
            ),
          );
        },
        child: _CategoryDesign(
          e.image,
        ),
      );
    }).toList());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 55,
          child: Row(
            children: <Widget>[
              _MouseIcon(),
              _HeadSetIcon(),
              _KeyBoardIcon(),
              _MonitorIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
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
      ],
    );
  }

  Widget _ExtraItem() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Extra Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    C_Provider.getMouseData();
    C_Provider.getMonitorData();
    C_Provider.getKeyboardData();
    C_Provider.getHeadSetData();
    C_Provider.getMouseIconData();
    C_Provider.getKeyboardIcontData();
    C_Provider.getMonitorIcontData();
    C_Provider.getHeadSetIconData();
  }

  @override
  Widget build(BuildContext context) {
    C_Provider = Provider.of<CategoryLinker>(context);
    P_Provider = Provider.of<ProductLinker>(context);
    getCallAllFunction();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blueAccent[700],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
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
                    height: 40,
                  ),
                  _ImageSlider(),
                  SizedBox(
                    height: 60,
                  ),
                  _buildCategory(),
                  SizedBox(
                    height: 60,
                  ),
                  _buildFeature(),
                  SizedBox(
                    height: 250,
                  ),
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
