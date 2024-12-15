import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class GLBModelViewer extends StatefulWidget {
  final String modelPath;

  const GLBModelViewer({super.key, required this.modelPath});

  @override
  State<GLBModelViewer> createState() => _GLBModelViewerState();
}

class _GLBModelViewerState extends State<GLBModelViewer> {
  final Flutter3DController controller = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Visualizador 3D',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Flutter3DViewer(
                src: widget.modelPath,
                activeGestureInterceptor: true,
                progressBarColor: Colors.orange,
                enableTouch: true,
                onProgress: (double progressValue) {
                  debugPrint('Progreso de carga: $progressValue');
                },
                onLoad: (String modelAddress) {
                  debugPrint('Modelo cargado: $modelAddress');
                },
                onError: (String error) {
                  debugPrint('Error al cargar el modelo: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error al cargar el modelo: $error',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
