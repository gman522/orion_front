import 'package:flutter/material.dart';

class AppButton extends StatelessWidget{
    final String text;
    final VoidCallback? onPressed;
    final Color color;
    final IconData? icon;
    final bool loading;

    const AppButton({
        super.key,
        required this.text,
        required this.onPressed,
        this.color = Colors.blue,
        this.icon,
        this.loading = false,
    });

    @override
    Widget build(BuildContext context){
        return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: loading ? null: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                    ),
                ),
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                        ),
                    )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                            if(icon != null) Icon(icon, color: Colors.white),
                            if(icon != null) const SizedBox(width: 8),
                            Text(
                                text,
                                style: const TextStyle(color: Colors.white),
                            ),
                        ],
                    ),
            ),
        );
    }
}