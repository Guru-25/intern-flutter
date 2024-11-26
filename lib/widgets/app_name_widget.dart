import 'package:kathiravan_fireworks/imports.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBuilder(
          text: 'KATHIRAVAN', 
          color: Color.fromARGB(255, 255, 0, 0), 
          fontSize: 25, 
          fontWeight: FontWeight.w700
        ),
        TextBuilder(
          text: 'Fireworks', 
          color: Color.fromARGB(255, 0, 0, 0), 
          fontSize: 17
        ),
      ],
    );
  }
}
