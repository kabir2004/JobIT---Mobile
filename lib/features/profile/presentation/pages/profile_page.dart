import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../app/theme/theme_provider.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../shared/models/user_profile.dart';
import 'profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _showProfileCompletionBanner = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    // Hide profile completion banner after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showProfileCompletionBanner = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          'JobIT',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        // Edit Profile Button
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileEditPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Theme Toggle Button
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          themeProvider.toggleTheme();
                          if (themeProvider.isDarkMode) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              themeProvider.isDarkMode 
                                  ? Icons.dark_mode 
                                  : Icons.light_mode,
                              key: ValueKey(themeProvider.isDarkMode),
                              size: 20,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileCompletionBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green[600],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Profile Complete! Your professional persona has been built. Your profile is now optimized for better job matches.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.green[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInformationCard(UserProfile user) {
    final displayName = user.firstName != null && user.lastName != null
        ? '${user.firstName} ${user.lastName}'
        : user.email.split('@')[0];
    
    final jobTitle = user.jobTitle ?? 'Add your job title';
    final location = user.preferredLocation ?? 'Add location';
    final experience = user.experienceLevel ?? 'Add experience level';
    final school = user.school ?? 'Add education';
    final major = user.major ?? 'Add major';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Picture
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: user.profilePictureUrl != null
                    ? ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Text(
                              'Photo',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 32,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      jobTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Location and Experience
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.location_on,
                text: location,
              ),
              const SizedBox(width: 24),
              _buildInfoItem(
                icon: Icons.work,
                text: experience,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Education
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.school,
                text: school,
              ),
              const SizedBox(width: 24),
              _buildInfoItem(
                icon: Icons.book,
                text: major,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Contact Information
          _buildContactItem(
            icon: Icons.email,
            text: user.email,
          ),
          const SizedBox(height: 8),
          _buildContactItem(
            icon: Icons.phone,
            text: 'Add phone number',
            isPlaceholder: true,
          ),
          const SizedBox(height: 8),
          _buildContactItem(
            icon: FontAwesomeIcons.linkedin,
            text: 'Add LinkedIn',
            isPlaceholder: true,
          ),
          const SizedBox(height: 8),
          _buildContactItem(
            icon: FontAwesomeIcons.github,
            text: 'Add GitHub',
            isPlaceholder: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
    bool isPlaceholder = false,
  }) {
    return Row(
      children: [
        FaIcon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isPlaceholder 
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard(UserProfile user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${user.jobTitle} with ${user.experienceLevel ?? 'experience'} in ${user.preferredIndustries.isNotEmpty ? user.preferredIndustries.join(', ') : 'various industries'}.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsCard(UserProfile user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: user.skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        skill,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildJobPreferencesCard(UserProfile user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Preferences',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPreferenceItem('Work Style:', user.workStyle ?? 'Not specified'),
                    const SizedBox(height: 12),
                    _buildPreferenceItem('Preferred Location:', user.preferredLocation ?? 'Not specified'),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPreferenceItem('Salary Range:', user.salaryExpectation ?? 'Not specified'),
                    const SizedBox(height: 12),
                    _buildPreferenceItem('Experience Level:', user.experienceLevel ?? 'Not specified'),
                  ],
                ),
              ),
            ],
          ),
          if (user.preferredIndustries.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildPreferenceItem('Industries:', user.preferredIndustries.join(', ')),
          ],
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinksCard(UserProfile user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Links',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (user.githubUrl != null && user.githubUrl!.isNotEmpty)
            _buildSocialLink(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              url: user.githubUrl!,
            ),
          if (user.githubUrl != null && user.githubUrl!.isNotEmpty && 
              user.linkedinUrl != null && user.linkedinUrl!.isNotEmpty)
            const SizedBox(height: 12),
          if (user.linkedinUrl != null && user.linkedinUrl!.isNotEmpty)
            _buildSocialLink(
              icon: FontAwesomeIcons.linkedin,
              label: 'LinkedIn',
              url: user.linkedinUrl!,
            ),
        ],
      ),
    );
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () {
        // TODO: Implement URL launcher
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $label...'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    url,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsCard(UserProfile user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Documents',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => _showDocumentEditDialog(context, user),
                icon: const Icon(Icons.edit),
                iconSize: 20,
                tooltip: 'Edit Documents',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (user.resumeUrl != null && user.resumeUrl!.isNotEmpty)
            _buildDocumentItem(
              icon: Icons.description,
              label: 'Resume',
              url: user.resumeUrl!,
              onView: () => _viewDocument('Resume', user.resumeUrl!),
              onRemove: () => _removeDocument('resume', user),
            ),
          if (user.resumeUrl != null && user.resumeUrl!.isNotEmpty && 
              user.coverLetterUrl != null && user.coverLetterUrl!.isNotEmpty)
            const SizedBox(height: 12),
          if (user.coverLetterUrl != null && user.coverLetterUrl!.isNotEmpty)
            _buildDocumentItem(
              icon: Icons.article,
              label: 'Cover Letter',
              url: user.coverLetterUrl!,
              onView: () => _viewDocument('Cover Letter', user.coverLetterUrl!),
              onRemove: () => _removeDocument('coverLetter', user),
            ),
          if ((user.resumeUrl == null || user.resumeUrl!.isEmpty) && 
              (user.coverLetterUrl == null || user.coverLetterUrl!.isEmpty))
            _buildEmptyDocumentsState(),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required IconData icon,
    required String label,
    required String url,
    required VoidCallback onView,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  url.split('/').last, // Show just filename
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onView,
                icon: const Icon(Icons.visibility),
                iconSize: 18,
                tooltip: 'View $label',
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline),
                iconSize: 18,
                tooltip: 'Remove $label',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDocumentsState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.upload_file,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'No documents uploaded',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload your resume and cover letter to complete your profile',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _viewDocument(String label, String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $label...'),
        duration: const Duration(seconds: 1),
      ),
    );
    // TODO: Implement actual document viewer
  }

  void _removeDocument(String documentType, UserProfile user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${documentType == 'resume' ? 'Resume' : 'Cover Letter'}'),
        content: Text('Are you sure you want to remove your ${documentType == 'resume' ? 'resume' : 'cover letter'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _confirmRemoveDocument(documentType, user);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _confirmRemoveDocument(String documentType, UserProfile user) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final updatedProfile = documentType == 'resume' 
        ? user.copyWith(resumeUrl: null)
        : user.copyWith(coverLetterUrl: null);
    
    authService.updateProfile(updatedProfile);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${documentType == 'resume' ? 'Resume' : 'Cover Letter'} removed successfully'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDocumentEditDialog(BuildContext context, UserProfile user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Documents'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Resume'),
              subtitle: Text(user.resumeUrl != null && user.resumeUrl!.isNotEmpty 
                  ? 'Uploaded' : 'Not uploaded'),
              trailing: user.resumeUrl != null && user.resumeUrl!.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _removeDocument('resume', user);
                      },
                    )
                  : null,
              onTap: () {
                Navigator.of(context).pop();
                _uploadDocument('resume');
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Cover Letter'),
              subtitle: Text(user.coverLetterUrl != null && user.coverLetterUrl!.isNotEmpty 
                  ? 'Uploaded' : 'Not uploaded'),
              trailing: user.coverLetterUrl != null && user.coverLetterUrl!.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _removeDocument('coverLetter', user);
                      },
                    )
                  : null,
              onTap: () {
                Navigator.of(context).pop();
                _uploadDocument('coverLetter');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _uploadDocument(String documentType) {
    // Simulate document upload
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentUser = authService.currentUser;
    
    if (currentUser != null) {
      final fileName = '${documentType}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final updatedProfile = documentType == 'resume' 
          ? currentUser.copyWith(resumeUrl: fileName)
          : currentUser.copyWith(coverLetterUrl: fileName);
      
      authService.updateProfile(updatedProfile);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${documentType == 'resume' ? 'Resume' : 'Cover Letter'} uploaded successfully'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Consumer<AuthService>(
          builder: (context, authService, child) {
            final user = authService.currentUser;
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  if (user.isProfileComplete && _showProfileCompletionBanner) _buildProfileCompletionBanner(),
                  if (user.isProfileComplete && _showProfileCompletionBanner) const SizedBox(height: 24),
                  _buildPersonalInformationCard(user),
                  const SizedBox(height: 16),
                  if (user.jobTitle != null && user.jobTitle!.isNotEmpty) _buildAboutCard(user),
                  if (user.jobTitle != null && user.jobTitle!.isNotEmpty) const SizedBox(height: 16),
                  if (user.skills.isNotEmpty) _buildSkillsCard(user),
                  if (user.skills.isNotEmpty) const SizedBox(height: 16),
                  if (user.isProfileComplete) _buildJobPreferencesCard(user),
                  if (user.isProfileComplete) const SizedBox(height: 16),
                  if ((user.githubUrl != null && user.githubUrl!.isNotEmpty) || (user.linkedinUrl != null && user.linkedinUrl!.isNotEmpty)) _buildSocialLinksCard(user),
                  if ((user.githubUrl != null && user.githubUrl!.isNotEmpty) || (user.linkedinUrl != null && user.linkedinUrl!.isNotEmpty)) const SizedBox(height: 16),
                  _buildDocumentsCard(user),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
} 