import 'main.dart' as runner;

Future<void> main() async {
  const query = '?q=the+wire+characters&format=json';
  const title = 'The Wire';
  await runner.main(
    [
      query,
      title,
    ],
  );
}
