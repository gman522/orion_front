class IncidenteRequest{
    final String categoria;
    final String subcategoria;
    final String comentario;
    final String? imagen;

    IncidenteRequest({
        required this.categoria,
        required this.subcategoria,
        required this.comentario,
        this.imagen,
    });

    Map<String, dynamic> toJson(){
        return{
            "categoria": categoria,
            "subcategoria": subcategoria,
            "comentario": comentario,
            "imagen": imagen,
        };
    }
}