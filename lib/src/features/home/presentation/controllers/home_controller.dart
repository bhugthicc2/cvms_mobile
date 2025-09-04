import 'package:flutter/material.dart';
import '../../domain/models/user_model.dart';
import '../../domain/models/statistics_model.dart';
import '../../domain/models/quick_action_model.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/get_statistics_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class HomeController extends ChangeNotifier {
  final GetUserUseCase _getUserUseCase;
  final GetStatisticsUseCase _getStatisticsUseCase;
  final LogoutUseCase _logoutUseCase;

  HomeController(
    this._getUserUseCase,
    this._getStatisticsUseCase,
    this._logoutUseCase,
  );

  UserModel? _user;
  StatisticsModel? _statistics;
  List<QuickActionModel> _quickActions = [];
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  StatisticsModel? get statistics => _statistics;
  List<QuickActionModel> get quickActions => _quickActions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> initialize() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Load user data and statistics in parallel
      final results = await Future.wait([
        _getUserUseCase.execute(),
        _getStatisticsUseCase.execute(),
      ]);

      _user = results[0] as UserModel;
      _statistics = results[1] as StatisticsModel;

      // Initialize quick actions
      _initializeQuickActions();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load data: ${e.toString()}';
      notifyListeners();
    }
  }

  void _initializeQuickActions() {
    _quickActions = [
      QuickActionModel(
        id: 'entrance_scan',
        title: 'Entrance scan',
        subtitle: 'Scan entrance QR',
        icon: Icons.qr_code_scanner,
        color: const Color(0xFF2ECC71), // Teal/Green
        onTap: () => _handleEntranceScan(),
      ),
      QuickActionModel(
        id: 'exit_scan',
        title: 'Exit scan',
        subtitle: 'Scan exit QR',
        icon: Icons.exit_to_app,
        color: const Color(0xFFF39C12), // Orange/Yellow
        onTap: () => _handleExitScan(),
      ),
      QuickActionModel(
        id: 'vehicle_scan',
        title: 'Vehicle scan',
        subtitle: 'Scan vehicles QR',
        icon: Icons.local_shipping,
        color: const Color(0xFF3498DB), // Blue
        onTap: () => _handleVehicleScan(),
      ),
      QuickActionModel(
        id: 'recent_activity',
        title: 'Recent activity',
        subtitle: 'View activity history',
        icon: Icons.history,
        color: const Color(0xFFE91E63), // Pink/Magenta
        onTap: () => _handleRecentActivity(),
      ),
    ];
  }

  void _handleEntranceScan() {
    // TODO: Implement entrance scan functionality
    print('Entrance scan tapped');
  }

  void _handleExitScan() {
    // TODO: Implement exit scan functionality
    print('Exit scan tapped');
  }

  void _handleVehicleScan() {
    // TODO: Implement vehicle scan functionality
    print('Vehicle scan tapped');
  }

  void _handleRecentActivity() {
    // TODO: Implement recent activity functionality
    print('Recent activity tapped');
  }

  Future<void> logout() async {
    try {
      await _logoutUseCase.execute();
    } catch (e) {
      _errorMessage = 'Logout failed: ${e.toString()}';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
