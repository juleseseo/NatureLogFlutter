import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nature_log_flutter/repository/herbarium_repository.dart';
import 'package:nature_log_flutter/repository/plant_repository.dart';
import 'package:nature_log_flutter/ui/screens/camera.dart';
import 'package:nature_log_flutter/ui/screens/herbarium.dart';
import 'cubits/camera_cubit.dart';
import 'cubits/search_cubit.dart';
import 'ui/screens/home.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CameraCubit(
            PlantRepository(),
            HerbariumRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchCubit(PlantRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          '/home': (context) => const HomePage(),
          '/camera': (context) => CameraScreen(camera: cameras.first),
          '/herbarium': (context) => const HerbariumPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}
