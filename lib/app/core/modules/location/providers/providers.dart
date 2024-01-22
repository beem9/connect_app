import 'package:connect_app/app/core/modules/location/providers/controller/location_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProviders =
    ChangeNotifierProvider.autoDispose((ref) => LocationController());
