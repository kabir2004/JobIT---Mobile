import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Remote', 'Full-time', 'Part-time', 'Contract'];

  // Mock job data
  final List<JobListing> _jobs = [
    JobListing(
      id: '1',
      title: 'Senior Software Engineer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '\$180,000 - \$280,000',
      postedDate: '2 days ago',
      isRemote: false,
      description: 'Lead the development of scalable, high-performance systems that power Google\'s core products including Search, YouTube, and Cloud Platform.',
      requirements: ['5+ years experience', 'Java', 'Python', 'C++', 'Distributed Systems'],
    ),
    JobListing(
      id: '2',
      title: 'Frontend Developer',
      company: 'Apple',
      location: 'Cupertino, CA',
      type: 'Full-time',
      salary: '\$150,000 - \$200,000',
      postedDate: '1 day ago',
      isRemote: true,
      description: 'Build beautiful, responsive user interfaces for Apple\'s next-generation products and services.',
      requirements: ['3+ years experience', 'React', 'TypeScript', 'iOS Development', 'UI/UX'],
    ),
    JobListing(
      id: '3',
      title: 'Data Scientist',
      company: 'Netflix',
      location: 'Los Gatos, CA',
      type: 'Full-time',
      salary: '\$160,000 - \$220,000',
      postedDate: '3 days ago',
      isRemote: false,
      description: 'Analyze user behavior data to improve content recommendations and user experience.',
      requirements: ['4+ years experience', 'Python', 'Machine Learning', 'SQL', 'Statistics'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobIT'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search jobs, companies, or keywords...',
                prefixIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                suffixIcon: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.sliders),
                  onPressed: () {
                    // TODO: Show advanced filters
                  },
                ),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
          
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          // Job listings
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _jobs.length,
              itemBuilder: (context, index) {
                final job = _jobs[index];
                return JobCard(job: job);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobListing job;

  const JobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.company,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.bookmark),
                  onPressed: () {
                    // TODO: Implement bookmark functionality
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.locationDot,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  job.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                if (job.isRemote) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Remote',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            
            const SizedBox(height: 8),
            
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.moneyBill,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  job.salary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const Spacer(),
                Text(
                  job.postedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.requirements.take(3).map((requirement) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    requirement,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Show job details
                    },
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement quick apply
                    },
                    child: const Text('Quick Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JobListing {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String salary;
  final String postedDate;
  final bool isRemote;
  final String description;
  final List<String> requirements;

  JobListing({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
    required this.postedDate,
    required this.isRemote,
    required this.description,
    required this.requirements,
  });
} 