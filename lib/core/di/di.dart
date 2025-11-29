import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initialize',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() => getIt.initialize();