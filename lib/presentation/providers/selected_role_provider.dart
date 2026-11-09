import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);