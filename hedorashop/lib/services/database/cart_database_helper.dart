import 'package:hedorashop/helpers/constants.dart';
import 'package:hedorashop/models/cart_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();

  static final CartDatabaseHelper db = CartDatabaseHelper._();

  static Database? _dbase;

  Future<Database> get dbase async {
    if (_dbase != null) {
      return _dbase!;
    }
    _dbase = await initDb();
    return _dbase!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $tableCartProduct (
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnProductId TEXT NOT NULL
      )
      ''');
    });
  }

  Future<List<CartProductModel>> getAllProduct() async {
    var dbClient = await dbase;
    List<Map> maps = await dbClient.query(tableCartProduct);

    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((e) => CartProductModel.fromJson(e)).toList()
        : [];
    return list;
  }

  insert(CartProductModel model) async {
    var dbClient = await dbase;
    await dbClient.insert(
      tableCartProduct,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateProduct(CartProductModel model) async {
    var dbClient = await dbase;
    return await dbClient.update(tableCartProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(String productId) async {
    Database _db = await dbase;
    await _db.delete(
      tableCartProduct,
      where: '$columnProductId = ?',
      whereArgs: [productId],
    );
  }

  deleteAllProducts() async {
    Database _db = await dbase;
    await _db.delete(tableCartProduct);
  }
}
