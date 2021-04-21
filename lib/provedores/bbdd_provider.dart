import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:lector_qr/modelos/scan_modelo.dart';
export 'package:lector_qr/modelos/scan_modelo.dart';

class BdProvider {
  static Database _database; //obtenemos la istancia de la base de datos
  static final BdProvider db =
      BdProvider._(); //instancia de mi clase personalizada
  //._ indica un constructor privado ej BdProvider._Private()
  BdProvider._(); //construyo constructor privado de esta clase

  Future<Database> get getDatabase async {
    //poder acceder al objeto _database
    if (_database != null) return _database;
    _database = await iniciarBD(); //creo metodo para iniciar base datos

    return _database; //aqui ya me retorna la bbdd ya inicializada
  }

  Future<Database> iniciarBD() async {
    //AQUI SE INICIARA LA BBDD

    //obtener Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScanDB.db'); //nombre de la BBDD
    print(path);

    //CREAR BASE DE DATOS
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, //db abre la bbdd
        onCreate: (Database db, int version) async {
      //nombre de la tabla
      await db.execute('''
        CREATE TABLE Scaner(   
          id INTEGER PRIMARY KEY,     
          tipo TEXT,
          valor TEXT
        )        
        ''');
    });
  }

//UNA MANERA PARA INSERTAR UNO POR UNO

  Future<int> nuevoScanFilas(ScanModelo scanModelo) async {
    final id = scanModelo.id;
    final tipo = scanModelo.tipo;
    final valor = scanModelo.valor;

    final db = await getDatabase; // verifica la base de datos
    //inserta datos
    final res = await db.rawInsert('''
    INSERT INTO Scaner($id, '$tipo', '$valor')
    VALUES (id, tipo, valor)
    ''');
    return res;
  }

  //OTRA MANERA USANDO TOJSON PARA INSERTAR
  Future<int> nuevoScan(ScanModelo scanModelo) async {
    final db = await getDatabase;
    final res = await db.insert(
        'Scaner',
        scanModelo
            .toJson()); //ayuda a insetar todos los datos siempre y cuand0 esten en la bbdd

    //es el ID del ultimo registro
    print(res);
    return res;
  }

  Future<ScanModelo> seleccionarByID(int id) async {
    final db = await getDatabase;
    final res = await db.query('Scaner', where: 'id= ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModelo.fromJson(res.first) : null;
  }

  //DIFERENTES METODOS PARA SELECCIONAR DATOS DE LA BASE DE DATOS

  Future<List<ScanModelo>> seleccionarTodo() async {
    final db = await getDatabase;
    final res = await db.query('Scaner');

    return res.isNotEmpty
        ? res.map((s) => ScanModelo.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModelo>> seleccionarPorTipo(String tipo) async {
    final db = await getDatabase;
    final res = await db.rawQuery('''
      SELECT * FROM Scaner WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((s) => ScanModelo.fromJson(s)).toList()
        : [];
  }

  //ACTUALIZACION DE REGISTROS
  Future<int> actualizarScan(ScanModelo nuevoScan) async {
    final db = await getDatabase;
    final res = await db.update('Scaner', nuevoScan.toJson(),
        where: 'id=?', whereArgs: [nuevoScan.id]);

    return res;
  }

  //ELIMINAR LOS DATOS

  Future<int> eliminarScan(int id) async {
    final db = await getDatabase;
    final res = await db.delete('Scaner', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> eliminarTodoScan() async {
    final db = await getDatabase;
    final res = await db.rawDelete('''
      DELETE FROM Scaner
    ''');
    return res;
  }
}
