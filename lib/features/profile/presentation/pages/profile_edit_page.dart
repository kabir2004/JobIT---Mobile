import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../shared/models/user_profile.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _githubController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _schoolController = TextEditingController();
  final _majorController = TextEditingController();
  
  // Form values
  String? _gender;
  String? _experienceLevel;
  String? _salaryExpectation;
  String? _workStyle;
  List<String> _selectedSkills = [];
  List<String> _selectedIndustries = [];
  String? _profilePictureUrl;

  final List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  final List<String> _jobTitles = [
    'Software Engineer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'Mobile Developer',
    'Data Scientist',
    'Data Analyst',
    'Product Manager',
    'Project Manager',
    'UI/UX Designer',
    'DevOps Engineer',
    'QA Engineer',
    'System Administrator',
    'Network Engineer',
    'Cybersecurity Analyst',
    'Business Analyst',
    'Marketing Manager',
    'Sales Representative',
    'Customer Success Manager',
    'Content Writer',
    'Graphic Designer',
    'Video Editor',
    'Social Media Manager',
    'HR Manager',
    'Recruiter',
    'Accountant',
    'Financial Analyst',
    'Legal Assistant',
    'Nurse',
    'Teacher',
    'Consultant',
    'Entrepreneur',
    'Student',
    'Other',
  ];

  final List<String> _experienceLevels = [
    'Entry Level (0-2 years)',
    'Mid Level (3-5 years)',
    'Senior Level (6-10 years)',
    'Executive Level (10+ years)',
  ];

  final List<String> _salaryRanges = [
    'Under \$50,000',
    '\$50,000 - \$75,000',
    '\$75,000 - \$100,000',
    '\$100,000 - \$150,000',
    '\$150,000 - \$200,000',
    'Over \$200,000',
  ];

  final List<String> _skills = [
    'JavaScript', 'Python', 'React', 'Node.js', 'Java', 'C++',
    'SQL', 'AWS', 'Docker', 'Kubernetes', 'Machine Learning',
    'Data Analysis', 'UI/UX Design', 'Project Management',
    'Sales', 'Marketing', 'Customer Service', 'Writing',
    'Graphic Design', 'Accounting', 'Legal', 'Healthcare',
  ];

  final List<String> _industries = [
    'Technology', 'Healthcare', 'Finance', 'Education',
    'Retail', 'Manufacturing', 'Media & Entertainment',
    'Non-profit', 'Government', 'Real Estate', 'Transportation',
    'Energy', 'Consulting', 'Marketing & Advertising',
  ];

  final List<String> _workStyles = [
    'Remote-first',
    'Hybrid (part remote, part office)',
    'Office-based',
    'Flexible schedule',
    'Traditional 9-5',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    
    if (user != null) {
      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _gender = user.gender;
      _jobTitleController.text = user.jobTitle ?? '';
      _locationController.text = user.preferredLocation ?? '';
      _experienceLevel = user.experienceLevel;
      _salaryExpectation = user.salaryExpectation;
      _workStyle = user.workStyle;
      _selectedSkills = List.from(user.skills);
      _selectedIndustries = List.from(user.preferredIndustries);
      _githubController.text = user.githubUrl ?? '';
      _linkedinController.text = user.linkedinUrl ?? '';
      _schoolController.text = user.school ?? '';
      _majorController.text = user.major ?? '';
      _profilePictureUrl = user.profilePictureUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Information Section
                _buildSectionTitle('Personal Information'),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Gender Selection
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                ...(_genders.map((gender) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _gender == gender 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: Text(gender),
                    value: gender,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ))),
                
                const SizedBox(height: 24),
                
                // Profile Picture Section
                _buildSectionTitle('Profile Picture'),
                const SizedBox(height: 16),
                
                Center(
                  child: Column(
                    children: [
                      // Profile Picture Display/Upload
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: _profilePictureUrl != null
                            ? ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Photo\nUploaded',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 32,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add Photo',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Simulate profile picture upload
                              setState(() {
                                _profilePictureUrl = 'profile_picture_${DateTime.now().millisecondsSinceEpoch}.jpg';
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile picture uploaded successfully!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.upload),
                            label: const Text('Upload Photo'),
                          ),
                          if (_profilePictureUrl != null) ...[
                            const SizedBox(width: 12),
                            OutlinedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _profilePictureUrl = null;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile picture removed'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text('Remove'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Education Section
                _buildSectionTitle('Education'),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _schoolController,
                  decoration: const InputDecoration(
                    labelText: 'School/University',
                    hintText: 'e.g., Stanford University, MIT, University of California',
                    prefixIcon: Icon(Icons.school),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _majorController,
                  decoration: const InputDecoration(
                    labelText: 'Major/Field of Study',
                    hintText: 'e.g., Computer Science, Business Administration, Engineering',
                    prefixIcon: Icon(Icons.book),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Professional Information Section
                _buildSectionTitle('Professional Information'),
                const SizedBox(height: 16),
                
                // Job Title Dropdown
                DropdownButtonFormField<String>(
                  value: _jobTitleController.text.isEmpty ? null : _jobTitleController.text,
                  decoration: const InputDecoration(
                    labelText: 'Current or Desired Job Title',
                    prefixIcon: Icon(Icons.work),
                  ),
                  items: _jobTitles.map((title) => DropdownMenuItem(
                    value: title,
                    child: Text(title),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _jobTitleController.text = value ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your job title';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Location',
                    hintText: 'e.g., Remote, New York, NY, San Francisco, CA',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your preferred location';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Experience Level
                Text(
                  'Experience Level',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                ...(_experienceLevels.map((level) => RadioListTile<String>(
                  title: Text(level),
                  value: level,
                  groupValue: _experienceLevel,
                  onChanged: (value) {
                    setState(() {
                      _experienceLevel = value;
                    });
                  },
                ))),
                
                const SizedBox(height: 16),
                
                // Salary Expectation
                Text(
                  'Salary Expectation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                ...(_salaryRanges.map((range) => RadioListTile<String>(
                  title: Text(range),
                  value: range,
                  groupValue: _salaryExpectation,
                  onChanged: (value) {
                    setState(() {
                      _salaryExpectation = value;
                    });
                  },
                ))),
                
                const SizedBox(height: 16),
                
                // Work Style
                Text(
                  'Work Style',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                ...(_workStyles.map((style) => RadioListTile<String>(
                  title: Text(style),
                  value: style,
                  groupValue: _workStyle,
                  onChanged: (value) {
                    setState(() {
                      _workStyle = value;
                    });
                  },
                ))),
                
                const SizedBox(height: 24),
                
                // Skills Section
                _buildSectionTitle('Skills'),
                const SizedBox(height: 16),
                
                Text(
                  'Select your key skills',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _skills.map((skill) {
                    final isSelected = _selectedSkills.contains(skill);
                    return FilterChip(
                      label: Text(skill),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedSkills.add(skill);
                          } else {
                            _selectedSkills.remove(skill);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Industries Section
                _buildSectionTitle('Industries'),
                const SizedBox(height: 16),
                
                Text(
                  'Select industries that interest you',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _industries.map((industry) {
                    final isSelected = _selectedIndustries.contains(industry);
                    return FilterChip(
                      label: Text(industry),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedIndustries.add(industry);
                          } else {
                            _selectedIndustries.remove(industry);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 24),
                
                // Social Links Section
                _buildSectionTitle('Social Links'),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _githubController,
                  decoration: InputDecoration(
                    labelText: 'GitHub URL',
                    hintText: 'https://github.com/username',
                    prefixIcon: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.github,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _linkedinController,
                  decoration: InputDecoration(
                    labelText: 'LinkedIn URL',
                    hintText: 'https://linkedin.com/in/username',
                    prefixIcon: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    final currentUser = authService.currentUser;
    
    if (currentUser != null) {
      final updatedProfile = currentUser.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _gender,
        jobTitle: _jobTitleController.text.trim(),
        preferredLocation: _locationController.text.trim(),
        experienceLevel: _experienceLevel,
        salaryExpectation: _salaryExpectation,
        workStyle: _workStyle,
        skills: _selectedSkills,
        preferredIndustries: _selectedIndustries,
        githubUrl: _githubController.text.trim(),
        linkedinUrl: _linkedinController.text.trim(),
        profilePictureUrl: _profilePictureUrl,
        school: _schoolController.text.trim(),
        major: _majorController.text.trim(),
        isProfileComplete: true,
      );
      
      await authService.updateProfile(updatedProfile);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/profile');
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _schoolController.dispose();
    _majorController.dispose();
    super.dispose();
  }
} 