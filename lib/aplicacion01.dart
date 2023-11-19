import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'baseDatos.dart';
class App01 extends StatefulWidget {
  const App01({super.key});

  @override
  State<App01> createState() => _App01State();
}

class _App01State extends State<App01> {
  int _index = 0;
  final nombre = TextEditingController();
  final creador = TextEditingController();
  final notas = TextEditingController();
  final desc = TextEditingController();
  bool romance = false;
  bool misterio = false;
  bool recuentos_de_vida = false;
  bool sobrenatural = false;
  bool escolar = false;
  bool seinen = false;
  bool accion = false;
  bool drama = false;
  bool post_apocaliptico = false;
  bool fantasia = false;
  bool episodeo = true;
  bool visto = false;
  int cantidad = 1;
  String StrEpisodeo = "Episodio";
  String StrNo = "No";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Animes"),),
      body: dinamico(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.list),label: "Lista"),
        BottomNavigationBarItem(icon: Icon(Icons.add),label: "Agregar"),
      ],
        currentIndex: _index,
        onTap: (valor){
          setState(() {
            _index=valor;
          });
        },
      ),
    );
  }


  Widget dinamico(){
    switch (_index){
      case 0:{
        return FutureBuilder(
            future: DB.mostrarAnimes(),
            builder: (context, listaJSON){
              if(listaJSON.hasData){
                return ListView.builder(
                  itemCount: listaJSON.data?.length,
                  itemBuilder: (context, indice) {
                    List<dynamic> elementosNoVistos = [];
                    List<dynamic> elementosVistos = [];
                    if (listaJSON.data != null) {
                      for (var elemento in listaJSON.data!) {
                        if (elemento['visto'] == true) {
                          elementosVistos.add(elemento);
                        } else {
                          elementosNoVistos.add(elemento);
                        }
                      }
                    }
                    List<dynamic> listaCombinada = [...elementosNoVistos, ...elementosVistos];
                    return ListTile(
                      title: Text("${listaCombinada[indice]['nombre']}"),
                      subtitle: Text("Creador:${listaCombinada[indice]['creador']}\n"
                          "Genero:${listaCombinada[indice]['genero']}\n"
                          "${listaCombinada[indice]['tipo']}:${listaCombinada[indice]['cantidad']}\n"
                          "Descripcion:${listaCombinada[indice]['descripcion']}\n"
                          "Notas:${listaCombinada[indice]['notas']}\n"),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text("Acciones"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    DB.eliminar("${listaCombinada[indice]['id']}").then((value) {
                                      setState(() {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se borró con éxito")));
                                      });
                                    });
                                  },
                                  child: Text("Eliminar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    DB.actualizar(listaCombinada[indice]['id']).then((value) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Actualizado")));
                                    });
                                  },
                                  child: Text("Marcar visto"),
                                )
                              ],
                            );
                          });
                        },
                        icon: Icon(Icons.list),
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator(
              ),);
            });
      }
      case 1:{
        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.all(40),
            children: [
              Text("Nombre"),
              TextField(controller: nombre,),
              Text("Creador"),
              TextField(controller: creador,),
              Text("Genero"),
              CheckboxListTile(value: romance,
                onChanged: (bool? value){
                  setState(() {
                    romance = value!;
                  });
                },title: Text("Romance"),),
              CheckboxListTile(value: misterio,
                onChanged: (bool? value){
                  setState(() {
                    misterio = value!;
                  });
                },title: Text("Misterio"),),
              CheckboxListTile(value: recuentos_de_vida,
                onChanged: (bool? value){
                  setState(() {
                    recuentos_de_vida = value!;
                  });
                },title: Text("Recuentos de vida"),),
              CheckboxListTile(value: sobrenatural,
                onChanged: (bool? value){
                  setState(() {
                    sobrenatural = value!;
                  });
                },title: Text("Sobrenatural"),),
              CheckboxListTile(value: escolar,
                onChanged: (bool? value){
                  setState(() {
                    escolar = value!;
                  });
                },title: Text("Escolar"),),
              CheckboxListTile(value: seinen,
                onChanged: (bool? value){
                  setState(() {
                    seinen = value!;
                  });
                },title: Text("Seinen"),),
              CheckboxListTile(value: drama,
                onChanged: (bool? value){
                  setState(() {
                    drama = value!;
                  });
                },title: Text("Drama"),),
              CheckboxListTile(value: accion,
                onChanged: (bool? value){
                  setState(() {
                    accion = value!;
                  });
                },title: Text("Acción"),),
              CheckboxListTile(value: post_apocaliptico,
                onChanged: (bool? value){
                  setState(() {
                    post_apocaliptico = value!;
                  });
                },title: Text("Post apocaliptico"),),
              CheckboxListTile(value: fantasia,
                onChanged: (bool? value){
                  setState(() {
                    fantasia = value!;
                  });
                },title: Text("Fantasia"),),

              Text("Tipo: ${StrEpisodeo}"),
              Switch(
                // This bool value toggles the switch.
                value: episodeo,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    episodeo = value;
                    if(episodeo==true){
                      StrEpisodeo="Episodio";
                    }else{
                      StrEpisodeo="Pelicula";
                    }
                  });},
              ),
              Text("Cantidad de capitulos/peliculas"),
              CounterButton(count: cantidad,
                  onChange: (int val){
                    setState(() {
                      if(val<=0){
                        val=1;
                      }
                      cantidad=val;
                    });
                  }, loading: false),
              Text("Descripción"),
              TextField(
                controller: desc,
                maxLines: 8,
                decoration: InputDecoration.collapsed(hintText: "Introduce una descripción"),
              ),
              Text("Notas"),
              TextField(
                controller: notas,
                maxLines: 8,
                decoration: InputDecoration.collapsed(hintText: "Introduce notas personales"),
              ),
              Text("Visto ${StrNo}"),
              Switch(
                // This bool value toggles the switch.
                value: visto,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    visto = value;
                    if(visto==true){
                      StrNo="si";
                    }else{
                      StrNo="no";
                    }
                  });},
              ),
              ElevatedButton(onPressed: (){
                String strGenero = "";
                if(romance==true){
                  strGenero="${strGenero+"Romance,"}";
                }
                if(misterio==true){
                  strGenero="${strGenero+"Misterio,"}";
                }
                if(recuentos_de_vida==true){
                  strGenero="${strGenero+"Recuentos de vida,"}";
                }
                if(sobrenatural==true){
                  strGenero="${strGenero+"Sobrenatural,"}";
                }
                if(escolar==true){
                  strGenero="${strGenero+"Escolar,"}";
                }
                if(seinen==true){
                  strGenero="${strGenero+"Seinen,"}";
                }
                if(drama==true){
                  strGenero="${strGenero+"Drama,"}";
                }
                if(accion==true){
                  strGenero="${strGenero+"Accion,"}";
                }
                if(post_apocaliptico==true){
                  strGenero="${strGenero+"Post apocaliptico,"}";
                }
                if(fantasia==true){
                  strGenero="${strGenero+"Fantasia,"}";
                }

                var tJSON = {
                  "nombre": nombre.text,
                  "creador": creador.text,
                  "genero":strGenero,
                  "tipo": StrEpisodeo,
                  "cantidad": cantidad,
                  "descripcion": desc.text,
                  "notas": notas.text,
                  "visto": visto
                };
                DB.insertar(tJSON).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Insertado con exito")));
                });
                nombre.text="";
                creador.text="";
                cantidad=1;
                desc.text="";
                notas.text="";
                visto=false;
              }, child: Text("Guardar"))

            ],
          ),
        );
      }
      default:{
        return Center();
      }
    }
  }
}
