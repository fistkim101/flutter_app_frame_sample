import '../application.dart';

void main() {
  final Environment environment =
      Environment.newInstance(EnvironmentType.production);
  environment.run();
}
