class JobApplication {
  final String id;
  final String jobTitle;
  final String company;
  final String location;
  final String appliedDate;
  final String status;
  final String lastUpdated;
  final String nextStep;

  JobApplication({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.appliedDate,
    required this.status,
    required this.lastUpdated,
    required this.nextStep,
  });

  factory JobApplication.fromJobListing(String jobTitle, String company, String location) {
    final now = DateTime.now();
    final appliedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    
    return JobApplication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      jobTitle: jobTitle,
      company: company,
      location: location,
      appliedDate: appliedDate,
      status: 'Applied',
      lastUpdated: '0 days ago',
      nextStep: 'Application under review',
    );
  }
} 