import 'dart:async';
import "dart:convert";
import 'dart:io';
import "shared.dart";
import 'package:dio/dio.dart';

var product_list = '''
    {
      "#001":
        {
          "product":
            {
              "author": "Cake Master 1",
              "image": "https://image.shutterstock.com/image-photo/small-cake-pink-icing-260nw-1828525400.jpg",
              "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
            },
          "ingredients":
            [
              "Milk: 2 Cups",
              "Suger: 2 Tb",
              "Floar: 1 Tb",
              "Vanilla: 1 Tb",
              "Choc: 3 pc",
              "ABC: 12",
              "DEF: 789",
              "GHI: asd"
            ],
          "nutritions":
            [
              "Energy: 2 Cups",
              "Suger: 2 Tb",
              "Fat: 1 Tb",
              "Vitamin: 1 Tb"
            ],
          "timing":
            [
              "Cook: 2 Cups",
              "Bake: 2 Tb",
              "Eat: 1 Tb"
            ]
        },
      "#002":
        {
          "product":
            {
              "author": "Cake Master 2",
              "image": "https://image.shutterstock.com/image-photo/small-cake-pink-icing-260nw-1828525400.jpg",
              "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
            },
          "ingredients":
            [
              "Milk: 2 Cups",
              "Suger: 2 Tb",
              "Floar: 1 Tb",
              "Vanilla: 1 Tb",
              "Choc: 3 pc",
              "ABC: 12",
              "DEF: 789",
              "GHI: asd"
            ],
          "nutritions":
            [
              "Energy: 2 Cups",
              "Suger: 2 Tb",
              "Fat: 1 Tb",
              "Vitamin: 1 Tb"
            ],
          "timing":
            [
              "Cook: 2 Cups",
              "Bake: 2 Tb",
              "Eat: 1 Tb"
            ]
        },
    }
    ''';

class firestore {
  static void retrieve() async {
    var product_001 = '''
    {
      "product":
        {
          "author": "Cake Master 1",
          "image": "https://image.shutterstock.com/image-photo/small-cake-pink-icing-260nw-1828525400.jpg",
          "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
        },
      "ingredients":
        [
          "Milk: 2 Cups",
          "Suger: 2 Tb",
          "Floar: 1 Tb",
          "Vanilla: 1 Tb",
          "Choc: 3 pc",
          "ABC: 12",
          "DEF: 789",
          "GHI: asd"
        ],
      "nutritions":
        [
          "Energy: 2 Cups",
          "Suger: 2 Tb",
          "Fat: 1 Tb",
          "Vitamin: 1 Tb"
        ],
      "timing":
        [
          "Cook: 2 Cups",
          "Bake: 2 Tb",
          "Eat: 1 Tb"
        ]
    }''';
    var product_002 = '''
        {
          "product":
            {
              "author": "Cake Master 2",
              "image": "https://image.shutterstock.com/image-photo/small-cake-pink-icing-260nw-1828525400.jpg",
              "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
            },
          "ingredients":
            [
              "Milk: 2 Cups",
              "Suger: 2 Tb",
              "Floar: 1 Tb",
              "Vanilla: 1 Tb",
              "Choc: 3 pc",
              "ABC: 12",
              "DEF: 789",
              "GHI: asd"
            ],
          "nutritions":
            [
              "Energy: 2 Cups",
              "Suger: 2 Tb",
              "Fat: 1 Tb",
              "Vitamin: 1 Tb"
            ],
          "timing":
            [
              "Cook: 2 Cups",
              "Bake: 2 Tb",
              "Eat: 1 Tb"
            ]
        }
    ''';

    var products = '''
        {
          "products": [
            {
              "id": "001",
              "name": "Cake 1",
              "image": "images/cake1.jpg",
            },
            {
              "id": "002",
              "name": "Cake 2",
              "image": "images/cake2.jpg",
            },
            {
              "id": "003",
              "name": "Cake 3",
              "image": "images/cake3.jpg",
            },
            {
              "id": "004",
              "name": "Cake 4",
              "image": "images/cake1.jpg",
            },
            {
              "id": "005",
              "name": "Cake 5",
              "image": "images/cake2.jpg",
            },
            {
              "id": "006",
              "name": "Cake 6",
              "image": "images/cake3.jpg",
            },
            {
              "id": "007",
              "name": "Cake 7",
              "image": "images/cake1.jpg",
            },
            {
              "id": "008",
              "name": "Cake 8",
              "image": "images/cake2.jpg",
            },
            {
              "id": "009",
              "name": "Cake 9",
              "image": "images/cake3.jpg",
            },
            {
              "id": "010",
              "name": "Cake 10",
              "image": "images/cake1.jpg",
            }
            ]
        }
    ''';

    Shared.addStringToSP("products", products);
    Shared.addStringToSP("001", product_001);
    Shared.addStringToSP("002", product_002);

    try {} catch (e) {
      print("Exception: " + e.toString());
    }
  }
}

class Products {
  static Future<dynamic> product() async {
    return Shared.getStringFromSP("prod_id").then((value) {
      String id = value.toString();
      return Shared.getStringFromSP(id).then((value) {
        String product_list = value.toString();
        print(id + product_list.toString());
        var products_list = '''{
            "product":
              {
                "author": "Cake Master 1",
                "image": "https://image.shutterstock.com/image-photo/small-cake-pink-icing-260nw-1828525400.jpg",
                "description": "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
              },
            "ingredients":
              [
                "Milk: 2 Cups",
                "Suger: 2 Tb",
                "Floar: 1 Tb",
                "Vanilla: 1 Tb",
                "Choc: 3 pc",
                "ABC: 12",
                "DEF: 789",
                "GHI: asd"
              ],
            "nutritions":
              [
                "Energy: 2 Cups",
                "Suger: 2 Tb",
                "Fat: 1 Tb",
              "Vitamin: 1 Tb"
            ],
          "timing":
            [
              "Cook: 2 Cups",
              "Bake: 2 Tb",
              "Eat: 1 Tb"
            ]
          }
    ''';
        return jsonDecode(product_list);
      });
    });
  }

  static Future<dynamic> products() async {
    return Shared.getStringFromSP("products").then((value) {
      String products = value.toString();
      print("products " + products.toString());
      return jsonDecode(products);
    });
  }
}
// 1 and jason structure
class Python {
  static Future<dynamic> products() async {
    return getHttp().then((value) {
      String Prod = "";
      String Product_List = '{"products": [';
      for (final String key in value.keys) {
        print('Key: ' + key);
        if (Product_List != '{"products": [') Product_List += ',';
        Product_List += '{"id": "' +
            key +
            '","name": "' +
            value[key]['Name'] +
            '","image": "' +
            value[key]['Image'] +
            '"}';
        Prod = '{"product": {"author":"' +
            value[key]['Author'] +
            '", "name":"' +
            value[key]['Name'] +
            '", "image":"' +
            value[key]['Image'] +
            '", "description":"' +
            (value[key]['Description']).toString() +
            '"},';
        Prod += '"ingredients": [';
        for (var val in value[key]['Ingredients']) {
          if (!Prod.endsWith('[')) Prod += ',';
          Prod += '"' + val.toString() + '"';
        }
        Prod += '], "nutritions": [';
        for (var val in value[key]['Nutritions']) {
          if (!Prod.endsWith('[')) Prod += ',';
          Prod += '"' + val.toString() + '"';
        }
        Prod += '], "timing": [';
        for (var val in value[key]['Timing']) {
          if (!Prod.endsWith('[')) Prod += ',';
          Prod += '"' + val.toString() + '"';
        }
        Prod += ']}';
        print("Prod ->  " + Prod);
        Shared.addStringToSP(key, Prod);
      }
      Product_List += ']}';
      print("Prod_List ->  " + Product_List);
      Shared.addStringToSP("products", Product_List);
      return jsonDecode(Product_List);
    });
  }

  static dynamic getHttp() async {
    try {
      var dio = Dio();
      dynamic response = await dio.get("http://10.0.2.2:5000/db");
      print("Res: " + response.toString());
      return jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
  }
}
