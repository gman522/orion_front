import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reporte_provider.g.dart';

@riverpod
class Categoria extends _$Categoria {
  @override
  String? build() => null;

  void setCategoria(String value) {
    state = value;
  }
}