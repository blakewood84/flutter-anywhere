import 'main.dart' as runner;

Future<void> main() async {
  const query = '?q=simpsons+characters&format=json';
  const title = 'Simpsons';
  await runner.main(
    [
      query,
      title,
    ],
  );
}
