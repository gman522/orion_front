class IncidenteRequest{
    final int subcategoriaId;
    final String? descripcion;
    final String estado;
    final String prioridad;

    IncidenteRequest({
        required this.subcategoriaId,
        this.descripcion,
        this.estado = "pendiente",
        this.prioridad = "alta",
    });

    Map<String, dynamic> toJson(){
        return{
            "subcategoriaId": subcategoriaId,
            "descripcion": descripcion,
            "estado": estado,
            "prioridad": prioridad,
        };
    }
}