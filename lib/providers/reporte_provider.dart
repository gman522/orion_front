import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reporte_en_construccion.dart';

class ReporteNotifier
    extends StateNotifier<ReporteEnConstruccion>{
        ReporteNotifier()
            : super(const ReporteEnConstruccion());

        void setCategoria(String categoria){
            state = state.copyWith(
                categoria: categoria,
            );
        }

        void setSubCategoria(String subcategoria){
            state = state.copyWith(
                subcategoria: subcategoria,
            );
        }

        void setComentario(String comentario){
            state = state.copyWith(
                comentario: comentario,
            );
        }

        void setImagen(String imagenPath){
            state = state.copyWith(
                imagenPath: imagenPath,
            );
        }

        void limpiar(){
            state = const ReporteEnConstruccion();
        }

        final reporteProvider =
            StateNotifierProvider<
                ReporteNotifier,
                ReporteEnConstruccion>(
            (ref) => ReporteNotifier(),
        );
    }