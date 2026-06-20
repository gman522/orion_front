class ReporteEnConstruccion{
    final String? categoria;
    final String? subcategoria;
    final String? comentario;
    final String? imagenPath;

    const ReporteEnConstruccion({
        this.categoria,
        this.subcategoria,
        this.comentario,
        this.imagenPath,
    });

    ReporteEnConstruccion copyWith({
        String? categoria,
        String? subcategoria,
        String? comentario,
        String?imagenPath,
    }){
        return ReporteEnConstruccion(
            categoria: categoria ?? this.categoria,
            subcategoria: subcategoria ?? this.subcategoria,
            comentario: comentario ?? this.comentario,
            imagenPath: imagenPath ?? this.imagenPath,
        );
    }
}