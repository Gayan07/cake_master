import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "shared.dart";
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import "functions.dart";
import "appBar.dart";
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

// Starting point of all the Flutter applications
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Home",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Home Page"),
        ),
        onTap: () {
          print("test");
          Python.products();
          setState(() {});
        },
      ),
      body: Container(
        child: ProductsList(),
      ),
    );
  }
}

class ProductsList extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<ProductsList> {
  dynamic list_item = [];
  bool home_loding = false;

  _ProductsState() {
    getProducts();
  }

  getProducts() async {
    dynamic products_info = await Python.products();
    debugPrint("Res " + (products_info['products'].runtimeType).toString());
    for (dynamic asd in products_info['products']) {
      debugPrint("Ressss " + (asd['id']).toString());
    }
    list_item = products_info['products'];
    setState(() {
      home_loding = false;
    });
  }

  /*final list_item = [
    {"name": "Cake 1", "image": "images/cake1.jpg", "id": "001"},
    {"name": "Cake 2", "image": "images/cake2.jpg", "id": "002"},
    {"name": "Cake 3", "image": "images/cake3.jpg", "id": "003"},
    {"name": "Cake 4", "image": "images/cake4.jpg", "id": "004"},
    {"name": "Cake 5", "image": "images/cake5.jpg", "id": "005"},
    {"name": "Cake 6", "image": "images/cake6.jpg", "id": "006"},
    {"name": "Cake 7", "image": "images/cake1.jpg", "id": "007"},
    {"name": "Cake 8", "image": "images/cake2.jpg", "id": "008"},
    {"name": "Cake 9", "image": "images/cake3.jpg", "id": "009"},
    {"name": "Cake 10", "image": "images/cake4.jpg", "id": "010"},
    {"name": "Cake 11", "image": "images/cake5.jpg", "id": "011"},
    {"name": "Cake 12", "image": "images/cake6.jpg", "id": "012"},
  ];
   */

  @override
  Widget build(BuildContext context) {
    debugPrint("EEEEEEEEEEEEEE " + (list_item.runtimeType).toString());
    if (home_loding) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              LinearProgressIndicator(),
            ],
          ),
        ),
      );
    }
    return GridView.builder(
        itemCount: list_item.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Product(
            product_name: list_item[index]['name'],
            product_image: list_item[index]['image'],
            product_id: list_item[index]['id'],
          );
        });
  }
}

class Product extends StatelessWidget {
  final String product_name;
  final String product_image;
  final String product_id;

  Product({this.product_name, this.product_image, this.product_id});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product_name,
        child: Material(
            child: InkWell(
          onTap: () {
            Shared.addStringToSP("prod_id", product_id);
            //_navigateToNextScreen(context, product_name);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OpenIndividualProduct(product_id)));
          },
          child: GridTile(
              footer: Container(
                color: Colors.black12,
                child: ListTile(
                  leading: Text(
                    product_id,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.transparent),
                  ),
                  title: Text(
                    product_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              child: Image.network(
                product_image,
                fit: BoxFit.cover,
              )),
        )),
      ),
    );
  }
}

class OpenIndividualProduct extends StatefulWidget {
  final String product_id;

  OpenIndividualProduct(this.product_id);

  @override
  IndividualProduct createState() => IndividualProduct(product_id);
}

class IndividualProduct extends State<OpenIndividualProduct> {
  String product_id;

  IndividualProduct(String product_name) {
    this.product_id = product_name;
    super.initState();

    getProductDetails();
  }

  bool loading = true;
  dynamic product = null;
  List<dynamic> ingredients = null;
  List<dynamic> nutritions = null;
  List<dynamic> timing = null;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              LinearProgressIndicator(),
            ],
          ),
        ),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(product['name']),
        backgroundColor: Colors.redAccent,
      ),
      body: new Scaffold(
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Align(
                          alignment: Alignment.centerLeft,
                          child: Image.network(
                            product['image'],
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 1,
                          )),
                    ]),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.only(
                          left: 5.0, top: 20.0, right: 5.0, bottom: 20.0),
                    ),
                    Text(
                      "Recipe by: " + product['author'],
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        child: Container(
                      padding: new EdgeInsets.only(
                          left: 10.0, top: 10.0, right: 10.0, bottom: 25.0),
                      child: Text(
                        product['description'],
                        style: new TextStyle(
                          fontSize: 13.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ))
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                            color: Colors.transparent,
                            padding: new EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                right: 20.0,
                                bottom: 5.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    "Nutritions\n",
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto"),
                                  ),
                                  for (var i in nutritions)
                                    (Container(
                                      padding: new EdgeInsets.only(
                                          left: 0.0,
                                          top: 0.0,
                                          right: 0.0,
                                          bottom: 5.0),
                                      child: Text(
                                        "• " + i.toString(),
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    )),
                                  new Text(
                                    "\nTiming\n",
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.orangeAccent,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto"),
                                  ),
                                  for (var i in timing)
                                    (Container(
                                      padding: new EdgeInsets.only(
                                          left: 0.0,
                                          top: 0.0,
                                          right: 0.0,
                                          bottom: 5.0),
                                      child: Text(
                                        "• " + i.toString(),
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ))
                                ])),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: Colors.transparent,
                          padding: new EdgeInsets.only(
                              left: 20.0, top: 10.0, right: 20.0, bottom: 5.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "Ingredients\n",
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto"),
                                ),
                                for (var i in ingredients)
                                  (Container(
                                    padding: new EdgeInsets.only(
                                        left: 0.0,
                                        top: 0.0,
                                        right: 0.0,
                                        bottom: 5.0),
                                    child: Text(
                                      "• " + i.toString(),
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  )),
                              ]),
                        ),
                      ),
                    ]),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
              ]),
        ),
      ),

      // Bottom Menu Bar
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int index) {
          if (index == 0) {
          } else if (index == 1) {
            //_getFromGallery();
            _getFromGallery().then((imageFile) {
              if (imageFile != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        OpenFeedback(imageFile, product['image'])));
              }
            });
          } else if (index == 2) {
            //_getFromCamera();
            _getFromCamera().then((imageFile) {
              if (imageFile != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        OpenFeedback(imageFile, product['image'])));
              }
            });
          }
        },
        items: [
          new BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            label: 'Recipe',
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.add_to_photos),
            label: 'Upload',
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.add_a_photo),
            label: 'Capture',
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getProductDetails() async {
    dynamic product_info = await Products.product();
    debugPrint("N " + (product_info['ingredients'].runtimeType).toString());
    product = product_info['product'];
    ingredients = product_info['ingredients'];
    nutritions = product_info['nutritions'];
    timing = product_info['timing'];
    setState(() {
      loading = false;
    });
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
      //getHttp(imageFile);
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
      //getHttp(imageFile);
    }
  }

  /*void getHttp(File imageFile) async {
    try {
      String prodUrl = product['image'];
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse("http://192.168.8.152:5000/img");

      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('imageFile', stream, length,
          filename: basename(imageFile.path));
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.fields['prodUrl'] = prodUrl;
      var response = await request.send();
      print("Code: " + (response.statusCode).toString());
      response.stream.transform(utf8.decoder).listen((value) {
        print("Res " + value);
        return jsonDecode(response.toString());
      });
    } catch (e) {
      print("Error:::::::: " + e.toString());
    }
  }*/
}

class OpenFeedback extends StatefulWidget {
  final File imageFile;
  final String prodUrl;

  OpenFeedback(this.imageFile, this.prodUrl);

  @override
  Feedback createState() => Feedback(imageFile, prodUrl);
}

class Feedback extends State<OpenFeedback> {
  Feedback(File imageFile, String prodUrl) {
    super.initState();
    getFeedback(imageFile, prodUrl);
  }

  bool feedbackLoading = true;
  dynamic feedback;
// 2 body ekak
  getFeedback(File imageFile, String prodUrl) async {
    try {
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse("http://10.0.2.2:5000/img");

      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('imageFile', stream, length,
          filename: basename(imageFile.path));
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.fields['prodUrl'] = prodUrl;
      var response = await request.send();
      print("Response Code: " + (response.statusCode).toString());
      response.stream.transform(utf8.decoder).listen((value) {
        print("Res " + value);
        setState(() {
          feedback = jsonDecode(value);
          feedbackLoading = false;
        });
      });
    } catch (e) {
      print("Error:::::::: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (feedbackLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              LinearProgressIndicator(),
            ],
          ),
        ),
      );
    }
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: new Icon(Icons.check),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          }),
      body: new Scaffold(
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              left: 0.0, top: 50.0, right: 0.0, bottom: 0.0),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.only(
                          left: 5.0, top: 20.0, right: 5.0, bottom: 100.0),
                    ),
                    Text(
                      feedback['message'],
                      style: new TextStyle(
                        fontSize: 25.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Align(
                          alignment: Alignment.centerLeft,
                          child: Image.network(
                            feedback['image'],
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 1,
                          )),
                    ]),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        child: Container(
                      padding: new EdgeInsets.only(
                          left: 10.0, top: 50.0, right: 10.0, bottom: 25.0),
                      child: Text(
                        feedback['award'],
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ))
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.only(
                            left: 5.0, top: 20.0, right: 5.0, bottom: 100.0),
                      ),
                    ])
              ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
