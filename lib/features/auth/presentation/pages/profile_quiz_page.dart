import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/file_upload_service.dart';
import '../../../../shared/models/user_profile.dart';

class ProfileQuizPage extends StatefulWidget {
  const ProfileQuizPage({super.key});

  @override
  State<ProfileQuizPage> createState() => _ProfileQuizPageState();
}

class _ProfileQuizPageState extends State<ProfileQuizPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _schoolController = TextEditingController();
  final _majorController = TextEditingController();
  
  // Quiz answers
  String? _gender;
  String? _experienceLevel;
  String? _salaryExpectation;
  List<String> _selectedSkills = [];
  List<String> _selectedIndustries = [];
  String? _workStyle;
  String? _resumeUrl;
  String? _coverLetterUrl;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator with circles and lines
              _buildProgressIndicator(),
              
              const SizedBox(height: 8),
              
              Text(
                'Step ${_currentStep + 1} of 9',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Quiz content with smooth transitions
              Expanded(
                child: Form(
                  key: _formKey,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.98,
                            end: 1.0,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      );
                    },
                    child: _buildCurrentStep(),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Navigation buttons
              Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      child: Text(_currentStep == 8 ? 'Complete' : 'Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return SingleChildScrollView(
          key: const ValueKey(0),
          child: _buildBasicInfoStep(),
        );
      case 1:
        return SingleChildScrollView(
          key: const ValueKey(1),
          child: _buildProfilePictureStep(),
        );
      case 2:
        return SingleChildScrollView(
          key: const ValueKey(2),
          child: _buildEducationStep(),
        );
      case 3:
        return SingleChildScrollView(
          key: const ValueKey(3),
          child: _buildExperienceStep(),
        );
      case 4:
        return SingleChildScrollView(
          key: const ValueKey(4),
          child: _buildLocationStep(),
        );
      case 5:
        return SingleChildScrollView(
          key: const ValueKey(5),
          child: _buildSalaryStep(),
        );
      case 6:
        return SingleChildScrollView(
          key: const ValueKey(6),
          child: _buildSkillsStep(),
        );
      case 7:
        return SingleChildScrollView(
          key: const ValueKey(7),
          child: _buildFinalStep(),
        );
      case 8:
        return SingleChildScrollView(
          key: const ValueKey(8),
          child: _buildDocumentsStep(),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about yourself',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps us personalize your job recommendations',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
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
      ],
    );
  }

  Widget _buildProfilePictureStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Profile Picture',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload a professional photo to make your profile stand out',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
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
              
              const SizedBox(height: 24),
              
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final fileUploadService = FileUploadService();
                    final filePath = await fileUploadService.uploadImage(
                      type: FileUploadType.profilePicture,
                    );
                    
                    if (filePath != null) {
                      setState(() {
                        _profilePictureUrl = filePath;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile picture uploaded successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error uploading profile picture: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.upload),
                label: Text(_profilePictureUrl != null ? 'Photo Uploaded' : 'Upload Photo'),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Upload a professional headshot (optional)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about your education',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps employers understand your background',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
        TextFormField(
          controller: _schoolController,
          decoration: const InputDecoration(
            labelText: 'School/University',
            hintText: 'e.g., Stanford University, MIT, University of California',
            prefixIcon: Icon(Icons.school),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your school or university';
            }
            return null;
          },
        ),
        
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _majorController,
          decoration: const InputDecoration(
            labelText: 'Major/Field of Study',
            hintText: 'e.g., Computer Science, Business Administration, Engineering',
            prefixIcon: Icon(Icons.book),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your major or field of study';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildExperienceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s your experience level?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps us match you with appropriate opportunities',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
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
      ],
    );
  }

  Widget _buildLocationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where would you like to work?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tell us about your preferred work location',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
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
      ],
    );
  }

  Widget _buildSalaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s your salary expectation?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps us find roles that match your expectations',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
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
      ],
    );
  }

  Widget _buildSkillsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What are your key skills?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select all that apply (you can add more later)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _skills.length,
          itemBuilder: (context, index) {
            final skill = _skills[index];
            final isSelected = _selectedSkills.contains(skill);
            
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedSkills.remove(skill);
                  } else {
                    _selectedSkills.add(skill);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Center(
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFinalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Almost done!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Just a few more questions to complete your profile',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
        Text(
          'What industries interest you?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _industries.length,
          itemBuilder: (context, index) {
            final industry = _industries[index];
            final isSelected = _selectedIndustries.contains(industry);
            
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedIndustries.remove(industry);
                  } else {
                    _selectedIndustries.add(industry);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Center(
                  child: Text(
                    industry,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'What\'s your preferred work style?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
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
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Your Documents',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload your resume and cover letter to complete your profile (optional)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 32),
        
        // Resume Upload
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.upload_file,
                size: 48,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(height: 16),
              Text(
                'Resume',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_resumeUrl != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Text(
                    'Uploaded',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Upload your resume (PDF, DOC, DOCX)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final fileUploadService = FileUploadService();
                    final filePath = await fileUploadService.uploadPDF(
                      type: FileUploadType.resume,
                    );
                    
                    if (filePath != null) {
                      setState(() {
                        _resumeUrl = filePath;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Resume uploaded successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error uploading resume: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.upload),
                label: Text(_resumeUrl != null ? 'Resume Uploaded' : 'Upload Resume'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Cover Letter Upload
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.description,
                size: 48,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(height: 16),
              Text(
                'Cover Letter',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_coverLetterUrl != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Text(
                    'Uploaded',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Upload your cover letter (PDF, DOC, DOCX)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final fileUploadService = FileUploadService();
                    final filePath = await fileUploadService.uploadPDF(
                      type: FileUploadType.coverLetter,
                    );
                    
                    if (filePath != null) {
                      setState(() {
                        _coverLetterUrl = filePath;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cover letter uploaded successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error uploading cover letter: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.upload),
                label: Text(_coverLetterUrl != null ? 'Cover Letter Uploaded' : 'Upload Cover Letter'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    const totalSteps = 9;

    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < _currentStep;
        final isCurrent = index == _currentStep;
        final isLast = index == totalSteps - 1;

        return Expanded(
          child: Row(
            children: [
              // Circle with consistent size
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted || isCurrent
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  border: isCompleted || isCurrent
                      ? null
                      : Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1.5,
                        ),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                ),
              ),
              
              // Connecting line with uniform spacing
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index < _currentStep
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  void _nextStep() {
    if (_currentStep < 8) {
      if (_validateCurrentStep()) {
        setState(() {
          _currentStep++;
        });
      }
    } else {
      _completeProfile();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (!_formKey.currentState!.validate()) {
          return false;
        }
        if (_gender == null) {
          _showValidationError('Please select your gender');
          return false;
        }
        return true;
      case 1:
        // Profile picture is optional
        return true;
      case 2:
        if (!_formKey.currentState!.validate()) {
          return false;
        }
        return true;
      case 3:
        if (_experienceLevel == null) {
          _showValidationError('Please select your experience level');
          return false;
        }
        return true;
      case 4:
        if (_locationController.text.isEmpty) {
          _showValidationError('Please enter your preferred location');
          return false;
        }
        return true;
      case 5:
        if (_salaryExpectation == null) {
          _showValidationError('Please select your salary expectation');
          return false;
        }
        return true;
      case 6:
        if (_selectedSkills.isEmpty) {
          _showValidationError('Please select at least one skill');
          return false;
        }
        return true;
      case 7:
        if (_selectedIndustries.isEmpty) {
          _showValidationError('Please select at least one industry');
          return false;
        }
        if (_workStyle == null) {
          _showValidationError('Please select your work style');
          return false;
        }
        return true;
      case 8:
        // Documents are optional
        return true;
      default:
        return true;
    }
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _completeProfile() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentUser = authService.currentUser;
    
    if (currentUser != null) {
      final updatedProfile = currentUser.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _gender,
        jobTitle: _jobTitleController.text.trim(),
        experienceLevel: _experienceLevel,
        preferredLocation: _locationController.text.trim(),
        salaryExpectation: _salaryExpectation,
        skills: _selectedSkills,
        preferredIndustries: _selectedIndustries,
        workStyle: _workStyle,
        resumeUrl: _resumeUrl,
        coverLetterUrl: _coverLetterUrl,
        profilePictureUrl: _profilePictureUrl,
        school: _schoolController.text.trim(),
        major: _majorController.text.trim(),
        isProfileComplete: true,
      );
      
      await authService.updateProfile(updatedProfile);
      
      if (mounted) {
        context.go('/quiz-welcome');
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    _schoolController.dispose();
    _majorController.dispose();
    super.dispose();
  }
} 