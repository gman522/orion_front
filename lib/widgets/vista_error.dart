import 'package:flutter/material.dart';

class VistaError extends StatelessWidget{
    final String mensaje;
    final VoidCallback? onRetry;

    const VistaError({
        super.key,
        required this.mensaje,
        this.onRetry,
    });

    @override
    Widget build(BuildContext context){
        return Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                        ),
                        const SizedBox(height: 10),
                        Text(
                            mensaje,
                            textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        if (onRetry != null)
                            ElevatedButton(
                                onPressed: onRetry,
                                child: const Text("Reintentar"),
                            ),
                    ],
                ),
            ),
        );
    }
}