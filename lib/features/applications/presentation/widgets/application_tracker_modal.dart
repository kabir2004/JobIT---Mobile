import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/job_application.dart';

class ApplicationTrackerModal extends StatelessWidget {
  final JobApplication application;

  const ApplicationTrackerModal({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.jobTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.building,
                                size: 12,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  application.company,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '•',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.locationDot,
                                size: 12,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  application.location,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  iconSize: 20,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Application Progress Section
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Application Progress',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Timeline with proper scrolling
            Expanded(
              child: SingleChildScrollView(
                child: _buildTimeline(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final stages = [
      ApplicationStage(
        title: 'Application Submitted',
        description: 'Your application has been received',
        date: application.appliedDate,
        isCompleted: true,
        icon: FontAwesomeIcons.check,
      ),
      ApplicationStage(
        title: 'Resume Review',
        description: 'Your resume is being reviewed',
        date: null,
        isCompleted: false,
        icon: FontAwesomeIcons.fileLines,
      ),
      ApplicationStage(
        title: 'Phone Screen',
        description: 'Initial phone conversation',
        date: null,
        isCompleted: false,
        icon: FontAwesomeIcons.phone,
      ),
      ApplicationStage(
        title: 'Technical Interview',
        description: 'Technical assessment and coding',
        date: null,
        isCompleted: false,
        icon: FontAwesomeIcons.code,
      ),
      ApplicationStage(
        title: 'On-site Interview',
        description: 'Final round interviews',
        date: null,
        isCompleted: false,
        icon: FontAwesomeIcons.users,
      ),
      ApplicationStage(
        title: 'Offer',
        description: 'Job offer and negotiations',
        date: null,
        isCompleted: false,
        icon: FontAwesomeIcons.handshake,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: stages.asMap().entries.map((entry) {
          final index = entry.key;
          final stage = entry.value;
          final isLast = index == stages.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline column with perfect alignment
                SizedBox(
                  width: 32,
                  child: Column(
                    children: [
                      // Circle with consistent size and positioning
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: stage.isCompleted 
                              ? Colors.green[600]
                              : Theme.of(context).colorScheme.surface,
                          border: Border.all(
                            color: stage.isCompleted 
                                ? Colors.green[600]!
                                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: stage.isCompleted
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : FaIcon(
                                  stage.icon,
                                  size: 12,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                ),
                        ),
                      ),
                      // Connecting line that touches the circle
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Stage content with consistent spacing
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                stage.title,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: stage.isCompleted ? FontWeight.w600 : FontWeight.w500,
                                  color: stage.isCompleted 
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                ),
                              ),
                            ),
                            if (stage.date != null)
                              Text(
                                _formatDate(stage.date!),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                          ],
                        ),
                        if (stage.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            stage.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                        if (!isLast) const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatDate(String date) {
    final dateTime = DateTime.parse(date);
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}

class ApplicationStage {
  final String title;
  final String description;
  final String? date;
  final bool isCompleted;
  final IconData icon;

  ApplicationStage({
    required this.title,
    required this.description,
    this.date,
    required this.isCompleted,
    required this.icon,
  });
} 