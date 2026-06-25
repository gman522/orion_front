import '../models/subcategoria.dart';

class MockSubcategorias{
    static List<Subcategoria> porCategoria(int categoriaId){
        switch (categoriaId){
            case 1:
                return[
                    Subcategoria(
                        id: 1,
                        nombre: "Lesiones / accidentes",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 2,
                        nombre: "Malestar agudo",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 3,
                        nombre: "Salud mental / emocional",
                        categoriaId: categoriaId,
                    ),
                ];

            case 2:
                return[
                    Subcategoria(
                        id: 4,
                        nombre: "Riesgo estructural",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 5,
                        nombre: "Servicios básicos",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 6,
                        nombre: "Evacuación / desastre natural",
                        categoriaId: categoriaId,
                    ),
                ];

            case 3:
                return[
                    Subcategoria(
                        id: 7,
                        nombre: "Violencia interpersonal",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 8,
                        nombre: "Delitos / conductas ilícitas",
                        categoriaId: categoriaId,
                    ),
                    Subcategoria(
                        id: 9,
                        nombre: "Amenazas críticas",
                        categoriaId: categoriaId,
                    ),
                ];

            default:
                return[
                    Subcategoria(
                        id: 999,
                        nombre: "Sin categoría disponible",
                        categoriaId: categoriaId,
                    ),
                ];
        }
    }
}