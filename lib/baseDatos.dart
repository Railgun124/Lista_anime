import 'package:cloud_firestore/cloud_firestore.dart';

var baseRemota = FirebaseFirestore.instance;

class DB{
  static Future insertar(Map<String, dynamic> Anime) async{
    return await baseRemota.collection("Anime").add(Anime);
  }

  static Future eliminar(String id) async{
    return await baseRemota.collection("Anime").doc(id).delete();
  }

  static Future actualizar(String id) async {
    var query = await baseRemota.collection("Anime").get();

    for (var element in query.docs) {
      Map<String, dynamic> dato = element.data();
      dato.addAll({
        'id': element.id
      });

      if(dato['id']==id){
        if (dato['visto'] == false) {
          await baseRemota.collection("Anime").doc(id).update({'visto': true});
        } else {
          await baseRemota.collection("Anime").doc(id).update({'visto': false});
        }
      }
    }
  }


  static Future<List> mostrarAnimes()async{
    List temp = [];
    var query = await baseRemota.collection("Anime").get();

    query.docs.forEach((element) {
      Map<String,dynamic> dato = element.data();
      dato.addAll({
        'id':element.id
      });
      temp.add(dato);
    });
    return temp;
  }

}
