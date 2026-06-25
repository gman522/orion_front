class Subcategoria{
    final int id;
    final String nombre;
    final int categoriaId;

    Subcategoria({
        required this.id,
        required this.nombre,
        required this.categoriaId,
    });

    factory Subcategoria.fromJson(Map<String, dynamic>json){
        return Subcategoria(
            id: json["id"],
            nombre: json["nombre"],
            categoriaId: json["categoriaId"],
        );
    }

    Map<String, dynamic> toJson(){
        return{
            "id":id,
            "nombre": nombre,
            "categoriaId":categoriaId,
        };
    }
}