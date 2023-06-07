import '../application.dart';

void main() {
  final Environment environment =
      Environment.newInstance(EnvironmentType.development);
  environment.run();
}
