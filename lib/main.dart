import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/mongodb_service.dart';
import 'package:kathiravan_fireworks/imports.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env");
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDBService.connect();
    runApp(const MyApp());
  } catch (e) {
    print('Error loading environment: $e');
    // Provide fallback or error handling
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: RawString.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
