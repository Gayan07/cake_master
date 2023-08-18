// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import "functions.dart";
//
// class OpenIndividualProduct extends StatefulWidget {
//   final String product_name;
//
//   OpenIndividualProduct(this.product_name);
//
//   @override
//   IndividualProduct createState() => IndividualProduct(product_name);
// }
//
// class IndividualProduct extends State<OpenIndividualProduct> {
//   String prod_id;
//
//   IndividualProduct(String product_name) {
//     this.prod_id = product_name;
//     super.initState();
//   }
//
//   bool loading = true;
//   dynamic product = null;
//   List<String> ingredients = null;
//   List<String> nutritions = null;
//   List<String> timing = null;
//
//   @override
//   Widget build(BuildContext context) {
//     /*getProductDetails().then((value) {
//       setState(() {
//         loading = false;
//       });
//     });*/
//     debugPrint("Hi");
//     return CircularProgressIndicator();
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(prod_id),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: new Scaffold(
//         body: new SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           padding: const EdgeInsets.only(
//               left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
//           child: new Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 new Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       new Align(
//                           alignment: Alignment.centerLeft,
//                           child: Image.network(
//                             product['image'],
//                             fit: BoxFit.fill,
//                             width: MediaQuery.of(context).size.width / 1,
//                           )),
//                     ]),
//                 new Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: new EdgeInsets.only(
//                           left: 5.0, top: 20.0, right: 5.0, bottom: 20.0),
//                     ),
//                     Text(
//                       "Recipe by: " + product['author'],
//                       style: new TextStyle(
//                         fontSize: 14.0,
//                         color: const Color(0xFF000000),
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Roboto",
//                       ),
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//                 new Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Flexible(
//                         child: Container(
//                       padding: new EdgeInsets.only(
//                           left: 10.0, top: 10.0, right: 10.0, bottom: 25.0),
//                       child: Text(
//                         product['description'],
//                         style: new TextStyle(
//                           fontSize: 13.0,
//                           color: const Color(0xFF000000),
//                           fontWeight: FontWeight.w300,
//                           fontFamily: "Roboto",
//                         ),
//                       ),
//                     ))
//                   ],
//                 ),
//                 new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 5,
//                         child: Container(
//                             color: Colors.transparent,
//                             padding: new EdgeInsets.only(
//                                 left: 20.0,
//                                 top: 10.0,
//                                 right: 20.0,
//                                 bottom: 5.0),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   new Text(
//                                     "Nutritions\n",
//                                     style: new TextStyle(
//                                         fontSize: 15.0,
//                                         color: Colors.blueAccent,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: "Roboto"),
//                                   ),
//                                   for (var i in nutritions)
//                                     (Container(
//                                       padding: new EdgeInsets.only(
//                                           left: 0.0,
//                                           top: 0.0,
//                                           right: 0.0,
//                                           bottom: 5.0),
//                                       child: Text(
//                                         "• " + i.toString(),
//                                         style: new TextStyle(
//                                           fontSize: 13.0,
//                                           color: const Color(0xFF000000),
//                                           fontWeight: FontWeight.w300,
//                                           fontFamily: "Roboto",
//                                         ),
//                                       ),
//                                     )),
//                                   new Text(
//                                     "\nTiming\n",
//                                     style: new TextStyle(
//                                         fontSize: 15.0,
//                                         color: Colors.orangeAccent,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: "Roboto"),
//                                   ),
//                                   for (var i in timing)
//                                     (Container(
//                                       padding: new EdgeInsets.only(
//                                           left: 0.0,
//                                           top: 0.0,
//                                           right: 0.0,
//                                           bottom: 5.0),
//                                       child: Text(
//                                         "• " + i.toString(),
//                                         style: new TextStyle(
//                                           fontSize: 13.0,
//                                           color: const Color(0xFF000000),
//                                           fontWeight: FontWeight.w300,
//                                           fontFamily: "Roboto",
//                                         ),
//                                       ),
//                                     ))
//                                 ])),
//                       ),
//                       Expanded(
//                         flex: 5,
//                         child: Container(
//                           color: Colors.transparent,
//                           padding: new EdgeInsets.only(
//                               left: 20.0, top: 10.0, right: 20.0, bottom: 5.0),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 new Text(
//                                   "Ingredients\n",
//                                   style: new TextStyle(
//                                       fontSize: 15.0,
//                                       color: Colors.redAccent,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: "Roboto"),
//                                 ),
//                                 for (var i in ingredients)
//                                   (Container(
//                                     padding: new EdgeInsets.only(
//                                         left: 0.0,
//                                         top: 0.0,
//                                         right: 0.0,
//                                         bottom: 5.0),
//                                     child: Text(
//                                       "• " + i.toString(),
//                                       style: new TextStyle(
//                                         fontSize: 13.0,
//                                         color: const Color(0xFF000000),
//                                         fontWeight: FontWeight.w300,
//                                         fontFamily: "Roboto",
//                                       ),
//                                     ),
//                                   )),
//                               ]),
//                         ),
//                       ),
//                     ]),
//                 new Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                 )
//               ]),
//         ),
//       ),
//
//       // Bottom Menu Bar
//       bottomNavigationBar: new BottomNavigationBar(
//         onTap: (int index) {
//           if (index == 0) {
//           } else if (index == 1) {
//             _getFromGallery();
//           } else if (index == 2) {
//             _getFromCamera();
//           }
//         },
//         items: [
//           new BottomNavigationBarItem(
//             icon: const Icon(Icons.assignment),
//             label: 'Recipe',
//           ),
//           new BottomNavigationBarItem(
//             icon: const Icon(Icons.add_to_photos),
//             label: 'Upload',
//           ),
//           new BottomNavigationBarItem(
//             icon: const Icon(Icons.add_a_photo),
//             label: 'Capture',
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   getProductDetails() async {
//     product = Products.product();
//     ingredients = Products.ingredients();
//     nutritions = Products.nutritions();
//     timing = Products.timing();
//   }
//
//   /// Get from gallery
//   _getFromGallery() async {
//     PickedFile pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//       getHttp(imageFile);
//     }
//   }
//
//   /// Get from Camera
//   _getFromCamera() async {
//     PickedFile pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//       getHttp(imageFile);
//     }
//   }
//
//   void getHttp(File imageFile) async {
//     try {
//       var dio = Dio();
//       String prodUrl = product['image'];
//
//       /*FormData formData = new FormData.from({
//         "prodUrl": prodUrl,
//         "imageFile": new UploadFileInfo(new File(imageFile))
//       });*/
//       dynamic response = await dio.get("https://reqres.in/api/products/3");
//       return jsonDecode(response);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
