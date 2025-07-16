import 'package:flutter/foundation.dart';
import '../models/job_application.dart';

class ApplicationService extends ChangeNotifier {
  static final ApplicationService _instance = ApplicationService._internal();
  factory ApplicationService() => _instance;
  ApplicationService._internal();

  final List<JobApplication> _applications = [];

  List<JobApplication> get applications => List.unmodifiable(_applications);

  int get totalApplications => _applications.length;
  
  int get thisWeekApplications {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return _applications.where((app) {
      final appDate = DateTime.parse(app.appliedDate);
      return appDate.isAfter(weekStart);
    }).length;
  }
  
  int get thisMonthApplications {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return _applications.where((app) {
      final appDate = DateTime.parse(app.appliedDate);
      return appDate.isAfter(monthStart);
    }).length;
  }
  
  double get averageDailyApplications {
    if (_applications.isEmpty) return 0;
    final now = DateTime.now();
    final firstApp = _applications.map((app) => DateTime.parse(app.appliedDate)).reduce((a, b) => a.isBefore(b) ? a : b);
    final days = now.difference(firstApp).inDays + 1;
    return _applications.length / days;
  }
  
  int get goalProgress {
    // Assuming goal is 100 applications
    const goal = 100;
    return ((_applications.length / goal) * 100).round();
  }

  void addApplication(String jobTitle, String company, String location) {
    final application = JobApplication.fromJobListing(jobTitle, company, location);
    _applications.add(application);
    notifyListeners();
  }

  void updateApplicationStatus(String id, String status) {
    final index = _applications.indexWhere((app) => app.id == id);
    if (index != -1) {
      final app = _applications[index];
      _applications[index] = JobApplication(
        id: app.id,
        jobTitle: app.jobTitle,
        company: app.company,
        location: app.location,
        appliedDate: app.appliedDate,
        status: status,
        lastUpdated: '0 days ago',
        nextStep: app.nextStep,
      );
      notifyListeners();
    }
  }

  void removeApplication(String id) {
    _applications.removeWhere((app) => app.id == id);
    notifyListeners();
  }
} 