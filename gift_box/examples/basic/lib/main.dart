import 'package:material_ui/material_ui.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Box',
      home: Scaffold(
        appBar: AppBar(title: const Text('Gift Box')),
        body: const Center(child: Text('Your gift is on its way.')),
      ),
    );
  }
}
