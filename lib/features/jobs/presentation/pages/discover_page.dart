import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../../../applications/data/services/application_service.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin {
  late AnimationController _counterController;
  late Animation<double> _counterAnimation;
  int _currentCounter = 0;
  int _targetCounter = 0;
  int _remainingJobs = 0;
  int _appliedJobs = 0;
  
  // Company logo mapping with brand colors
  static const Map<String, Map<String, dynamic>> companyLogos = {
    'Google': {
      'icon': FontAwesomeIcons.google,
      'color': Color(0xFF4285F4), // Google Blue
    },
    'Meta': {
      'icon': FontAwesomeIcons.facebook,
      'color': Color(0xFF1877F2), // Facebook/Meta Blue
    },
    'Amazon': {
      'icon': FontAwesomeIcons.amazon,
      'color': Color(0xFFFF9900), // Amazon Orange
    },
    'Microsoft': {
      'icon': FontAwesomeIcons.microsoft,
      'color': Color(0xFF00A4EF), // Microsoft Blue
    },
    'Apple': {
      'icon': FontAwesomeIcons.apple,
      'color': Color(0xFF000000), // Apple Black
    },
    'Netflix': {
      'icon': FontAwesomeIcons.play,
      'color': Color(0xFFE50914), // Netflix Red
    },
    'Twitter': {
      'icon': FontAwesomeIcons.twitter,
      'color': Color(0xFF1DA1F2), // Twitter Blue
    },
    'LinkedIn': {
      'icon': FontAwesomeIcons.linkedin,
      'color': Color(0xFF0077B5), // LinkedIn Blue
    },
    'Uber': {
      'icon': FontAwesomeIcons.car,
      'color': Color(0xFF000000), // Uber Black
    },
    'Airbnb': {
      'icon': FontAwesomeIcons.home,
      'color': Color(0xFFFF5A5F), // Airbnb Red
    },
    'Spotify': {
      'icon': FontAwesomeIcons.music,
      'color': Color(0xFF1DB954), // Spotify Green
    },
    'Discord': {
      'icon': FontAwesomeIcons.comments,
      'color': Color(0xFF5865F2), // Discord Blue
    },
    'Slack': {
      'icon': FontAwesomeIcons.slack,
      'color': Color(0xFF4A154B), // Slack Purple
    },
    'GitHub': {
      'icon': FontAwesomeIcons.github,
      'color': Color(0xFF000000), // GitHub Black
    },
    'Salesforce': {
      'icon': FontAwesomeIcons.cloud,
      'color': Color(0xFF00A1E0), // Salesforce Blue
    },
    'Adobe': {
      'icon': FontAwesomeIcons.palette,
      'color': Color(0xFFFF0000), // Adobe Red
    },
    'Intel': {
      'icon': FontAwesomeIcons.microchip,
      'color': Color(0xFF0071C5), // Intel Blue
    },
    'NVIDIA': {
      'icon': FontAwesomeIcons.gamepad,
      'color': Color(0xFF76B900), // NVIDIA Green
    },
    'Oracle': {
      'icon': FontAwesomeIcons.database,
      'color': Color(0xFFF80000), // Oracle Red
    },
    'IBM': {
      'icon': FontAwesomeIcons.building,
      'color': Color(0xFF006699), // IBM Blue
    },
  };

  static Map<String, dynamic> getCompanyLogo(String companyName) {
    return companyLogos[companyName] ?? {
      'icon': FontAwesomeIcons.building,
      'color': const Color(0xFF666666), // Default gray
    };
  }

  final List<JobListing> _jobs = [
    JobListing(
      id: '1',
      title: 'Senior Software Engineer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '180,000 - 280,000',
      hourly: '87-135/hr',
      about: "Lead the development of scalable, high-performance systems that power Google's core products including Search, YouTube, and Cloud Platform. Drive technical architecture decisions and mentor engineering teams while contributing to Google's mission of organizing the world's information.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in algorithms, data structures, and system design',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Architect and develop scalable, high-performance applications and systems',
        'Mentor junior engineers and lead technical code reviews',
        'Collaborate with cross-functional teams to define and implement technical requirements',
        'Contribute to technical architecture decisions and system design strategy',
      ],
      skills: [
        'Java',
        'Python',
        'C++',
        '5+ years experience',
        'Distributed Systems',
        'Google Cloud Platform',
      ],
    ),
    JobListing(
      id: '2',
      title: 'Data Scientist',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: '180,000 - 220,000',
      hourly: '150-180/hr',
      about: "Analyze large datasets to identify patterns, trends, and insights that drive business decisions. Develop and implement machine learning models to improve product recommendations and user experience.",
      requirements: [
        'Degree: Master\'s in Computer Science, Statistics, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in statistics, machine learning, and data modeling',
        'Preferred: PhD or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement machine learning algorithms',
        'Analyze data to identify patterns and trends',
        'Develop predictive models and optimize algorithms',
        'Collaborate with cross-functional teams to define and implement technical requirements',
      ],
      skills: [
        'Python',
        'R',
        'SQL',
        '3+ years experience',
        'Machine Learning',
        'AWS',
      ],
    ),
    JobListing(
      id: '3',
      title: 'Frontend Developer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '150,000 - 180,000',
      hourly: '120-150/hr',
      about: "Build and maintain user-friendly interfaces for Meta's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in HTML, CSS, and JavaScript',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'HTML',
        'CSS',
        'JavaScript',
        '2+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '4',
      title: 'Backend Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: '180,000 - 220,000',
      hourly: '150-180/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in Java, Python, or C++',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Java',
        'Python',
        'C++',
        '3+ years experience',
        'Distributed Systems',
        'AWS',
      ],
    ),
    JobListing(
      id: '5',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '200,000 - 250,000',
      hourly: '160-200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '6',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '160,000 - 200,000',
      hourly: '130-160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '7',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: '170,000 - 210,000',
      hourly: '140-170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '8',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: '180,000 - 220,000',
      hourly: '150-180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '9',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '150,000 - 180,000',
      hourly: '120-150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '10',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '140,000 - 170,000',
      hourly: '110-140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '11',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: '160,000 - 200,000',
      hourly: '130-160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '12',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: '170,000 - 210,000',
      hourly: '140-170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '13',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '200,000 - 250,000',
      hourly: '160-200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '14',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '160,000 - 200,000',
      hourly: '130-160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '15',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: '170,000 - 210,000',
      hourly: '140-170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '16',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: '180,000 - 220,000',
      hourly: '150-180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '17',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '150,000 - 180,000',
      hourly: '120-150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '18',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '140,000 - 170,000',
      hourly: '110-140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '19',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: '160,000 - 200,000',
      hourly: '130-160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '20',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: '170,000 - 210,000',
      hourly: '140-170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '21',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: '200,000 - 250,000',
      hourly: '160-200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '22',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: '160,000 - 200,000',
      hourly: '130-160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '23',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '24',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '25',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '26',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '27',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '28',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '29',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '30',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '31',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '32',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '33',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '34',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '35',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '36',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '37',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '38',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '39',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '40',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '41',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '42',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '43',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '44',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '45',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '46',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '47',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '48',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '49',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '50',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '51',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '52',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '53',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '54',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '55',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '56',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '57',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '58',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '59',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '60',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate withfrontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '61',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '62',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '63',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '64',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '65',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '66',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '67',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '68',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '69',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '70',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '71',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '72',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '73',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '74',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '75',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '76',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '77',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '78',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '79',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '80',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '81',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '82',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '83',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '84',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '85',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '86',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '87',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '88',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '89',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '90',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '91',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '92',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
    JobListing(
      id: '93',
      title: 'Product Manager',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 200,000 -  250,000',
      hourly: ' 160- 200/hr',
      about: "Lead product development and strategy for Google's core products. Define product vision, roadmap, and metrics, and collaborate with engineering teams to deliver.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 5+ years experience',
        'Background: Strong foundation in product management, user experience, and technical knowledge',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Define product vision and roadmap',
        'Collaborate with engineering teams to deliver products',
        'Define metrics and KPIs',
        'Lead product strategy and decision-making',
      ],
      skills: [
        'Product Management',
        'User Experience',
        'Technical Knowledge',
        '5+ years experience',
        'Agile',
        'Scrum',
      ],
    ),
    JobListing(
      id: '94',
      title: 'Data Engineer',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Design, build, and maintain scalable data pipelines for Meta's products. Ensure data quality, reliability, and performance of data systems.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Engineering, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in data engineering, ETL, and data modeling',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and build scalable data pipelines',
        'Ensure data quality and reliability',
        'Optimize data systems performance',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Engineering',
        'ETL',
        'Data Modeling',
        '3+ years experience',
        'Apache Kafka',
        'Apache Spark',
      ],
    ),
    JobListing(
      id: '95',
      title: 'Full Stack Developer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Develop and maintain full-stack applications for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and backend technologies',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain full-stack applications',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Full Stack',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Node.js',
      ],
    ),
    JobListing(
      id: '96',
      title: 'DevOps Engineer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 180,000 -  220,000',
      hourly: ' 150- 180/hr',
      about: "Design, implement, and maintain robust DevOps practices for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in DevOps tools, CI/CD, and cloud infrastructure',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and implement robust DevOps practices',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with engineering teams',
      ],
      skills: [
        'DevOps',
        'CI/CD',
        'Cloud Infrastructure',
        '4+ years experience',
        'AWS',
        'Azure',
      ],
    ),
    JobListing(
      id: '97',
      title: 'UX Designer',
      company: 'Google',
      location: 'Mountain View, CA',
      type: 'Full-time',
      salary: ' 150,000 -  180,000',
      hourly: ' 120- 150/hr',
      about: "Create intuitive and engaging user experiences for Google's products. Collaborate with engineers and product managers to design and implement new features.",
      requirements: [
        'Degree: Bachelor\'s in Design, HCI, or related field',
        'Experience: 3+ years experience',
        'Background: Strong foundation in user research, interaction design, and prototyping',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Create intuitive and engaging user experiences',
        'Collaborate with engineers and product managers',
        'Design and implement new features',
        'Conduct user research and testing',
      ],
      skills: [
        'UX Design',
        'User Research',
        'Interaction Design',
        '3+ years experience',
        'Figma',
        'Sketch',
      ],
    ),
    JobListing(
      id: '98',
      title: 'Data Analyst',
      company: 'Meta',
      location: 'Menlo Park, CA',
      type: 'Full-time',
      salary: ' 140,000 -  170,000',
      hourly: ' 110- 140/hr',
      about: "Analyze data to provide insights and drive business decisions. Develop and implement data visualization tools and dashboards.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science, Statistics, or related field',
        'Experience: 2+ years experience',
        'Background: Strong foundation in data analysis, SQL, and data visualization',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Analyze data to provide insights',
        'Develop and implement data visualization tools',
        'Create dashboards and reports',
        'Collaborate with data scientists and engineers',
      ],
      skills: [
        'Data Analysis',
        'SQL',
        'Data Visualization',
        '2+ years experience',
        'Tableau',
        'Power BI',
      ],
    ),
    JobListing(
      id: '99',
      title: 'Frontend Engineer',
      company: 'Amazon',
      location: 'Seattle, WA',
      type: 'Full-time',
      salary: ' 160,000 -  200,000',
      hourly: ' 130- 160/hr',
      about: "Develop and maintain user interfaces for Amazon's products. Collaborate with designers and backend developers to create intuitive and responsive web applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in HTML, CSS, JavaScript, and frontend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Develop and maintain user interfaces',
        'Optimize application performance',
        'Collaborate with designers and backend developers',
        'Implement new features and improvements',
      ],
      skills: [
        'Frontend Engineer',
        'HTML',
        'CSS',
        'JavaScript',
        '4+ years experience',
        'React',
        'Vue.js',
      ],
    ),
    JobListing(
      id: '100',
      title: 'Backend Developer',
      company: 'Microsoft',
      location: 'Redmond, WA',
      type: 'Full-time',
      salary: ' 170,000 -  210,000',
      hourly: ' 140- 170/hr',
      about: "Design, develop, and maintain scalable backend systems for Microsoft's products. Ensure high availability, reliability, and performance of applications.",
      requirements: [
        'Degree: Bachelor\'s in Computer Science or related field',
        'Experience: 4+ years experience',
        'Background: Strong foundation in Java, Python, or C++, and backend frameworks',
        'Preferred: Master\'s degree or relevant certifications',
      ],
      highlights: [
        'Competitive compensation with equity participation',
        'Professional development and mentorship programs',
        'Cutting-edge technology and development tools',
        'Flexible work arrangements and remote options',
      ],
      responsibilities: [
        'Design and develop scalable backend systems',
        'Ensure high availability and reliability',
        'Optimize application performance',
        'Collaborate with frontend and other backend teams',
      ],
      skills: [
        'Backend Developer',
        'Java',
        'Python',
        'C++',
        '4+ years experience',
        'Spring Boot',
        'Django',
      ],
    ),
  ];

  int _currentIndex = 0;
  double _dragOffset = 0.0;
  double _dragStart = 0.0;
  bool _isDragging = false;
  bool _showNotification = false;
  String _notificationMessage = '';
  String _appliedCompany = '';

  @override
  void initState() {
    super.initState();
    _counterController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _counterAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _counterController,
      curve: Curves.easeOutCubic,
    ));
    
    // Initialize counters
    _remainingJobs = _jobs.length;
    _appliedJobs = 0;
    _targetCounter = _remainingJobs;
    _counterController.forward();
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragStart = details.globalPosition.dx;
      _dragOffset = 0.0;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isDragging) {
      setState(() {
        _dragOffset = details.globalPosition.dx - _dragStart;
      });
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    
    setState(() {
      _isDragging = false;
      if (_dragOffset.abs() > 100) {
        // Swipe left or right
        if (_dragOffset < 0 && _currentIndex < _jobs.length - 1) {
          // Swipe left - skip to next
          _currentIndex++;
          _updateCounter();
        } else if (_dragOffset > 0) {
          // Swipe right - apply to job
          _showApplicationNotification();
          _appliedJobs++;
          if (_currentIndex < _jobs.length - 1) {
            _currentIndex++;
            _updateCounter();
          }
        }
      }
      _dragOffset = 0.0;
    });
  }

  void _updateCounter() {
    _remainingJobs = _jobs.length - _currentIndex;
    _targetCounter = _remainingJobs;
    _counterController.reset();
    _counterController.forward();
  }

  void _showApplicationNotification() {
    final currentJob = _jobs[_currentIndex];
    
    // Add application to tracking service
    ApplicationService().addApplication(
      currentJob.title,
      currentJob.company,
      currentJob.location,
    );
    
    setState(() {
      _showNotification = true;
      _appliedCompany = currentJob.company;
    });
    
    // Hide notification after 2 seconds with 1 second fade out
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showNotification = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final job = _jobs[_currentIndex];
    final nextJob = _currentIndex < _jobs.length - 1 ? _jobs[_currentIndex + 1] : null;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'JobIT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: -0.5,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: AnimatedBuilder(
              animation: _counterAnimation,
              builder: (context, child) {
                final currentValue = (_targetCounter * _counterAnimation.value).round();
                return Text(
                  '$currentValue remaining',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: min(size.width, 420),
          height: size.height * 0.75,
          child: Stack(
            children: [
              // Next card (underneath)
              if (nextJob != null)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: 0.95,
                      child: Opacity(
                        opacity: 0.7,
                        child: MinimalJobCard(job: nextJob),
                      ),
                    ),
                  ),
                ),
              // Current card (on top)
              AnimatedPositioned(
                duration: _isDragging ? Duration.zero : const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                left: _dragOffset,
                top: 0,
                right: -_dragOffset,
                bottom: 0,
                child: Transform.rotate(
                  angle: (_dragOffset / size.width) * 0.08,
                  child: Transform.scale(
                    scale: 1.0 - (_dragOffset.abs() / size.width) * 0.03,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _dragOffset.abs() > 80 ? 0.0 : 1.0,
                      child: GestureDetector(
                        onHorizontalDragStart: _onDragStart,
                        onHorizontalDragUpdate: _onDragUpdate,
                        onHorizontalDragEnd: _onDragEnd,
                        child: MinimalJobCard(job: job),
                      ),
                    ),
                  ),
                ),
              ),
              if (_isDragging && _dragOffset < -60)
                Positioned.fill(
                  child: Center(
                    child: Transform.scale(
                      scale: 1.0 + (_dragOffset.abs() / size.width) * 0.5,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Icon(Icons.close, color: Colors.red.withOpacity(0.8), size: 36),
                      ),
                    ),
                  ),
                ),
              if (_isDragging && _dragOffset > 60)
                Positioned.fill(
                  child: Center(
                    child: Transform.scale(
                      scale: 1.0 + (_dragOffset.abs() / size.width) * 0.5,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Icon(Icons.check, color: Colors.green.withOpacity(0.8), size: 36),
                      ),
                    ),
                  ),
                ),
              // Application notification
              if (_showNotification)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  bottom: 20,
                  right: 16,
                  child: AnimatedOpacity(
                    opacity: _showNotification ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Applied to $_appliedCompany',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MinimalJobCard extends StatelessWidget {
  final JobListing job;
  const MinimalJobCard({super.key, required this.job});

  String _formatNumber(String number) {
    // Handle ranges like "180,000 - 280,000" or "87-135/hr"
    if (number.contains('-')) {
      final parts = number.split('-');
      if (parts.length == 2) {
        // Take the first number (lower bound) and format it
        final firstPart = parts[0].trim().replaceAll(' ', '').replaceAll(',', '');
        final intValue = int.tryParse(firstPart) ?? 0;
        final formatter = NumberFormat('#,###');
        return formatter.format(intValue);
      }
    }
    
    // Handle single numbers
    final cleanNumber = number.replaceAll(' ', '').replaceAll(',', '');
    final intValue = int.tryParse(cleanNumber) ?? 0;
    
    // Format with commas
    final formatter = NumberFormat('#,###');
    return formatter.format(intValue);
  }

  String _formatHourly(String hourly) {
    // Handle ranges like "87-135/hr" or "150-180/hr"
    if (hourly.contains('-')) {
      final parts = hourly.split('-');
      if (parts.length == 2) {
        // Take the first number (lower bound)
        final firstPart = parts[0].trim().replaceAll(' ', '').replaceAll(',', '');
        final intValue = int.tryParse(firstPart) ?? 0;
        return intValue.toString();
      }
    }
    
    // Handle single numbers
    final cleanNumber = hourly.replaceAll(' ', '').replaceAll(',', '').replaceAll('/hr', '');
    final intValue = int.tryParse(cleanNumber) ?? 0;
    return intValue.toString();
  }

  Color _getSkillColor(String skill, ThemeData theme) {
    final skillLower = skill.toLowerCase();
    
    // Programming Languages
    if (skillLower.contains('java') || skillLower.contains('python') || 
        skillLower.contains('javascript') || skillLower.contains('c++') ||
        skillLower.contains('html') || skillLower.contains('css') ||
        skillLower.contains('sql') || skillLower.contains('r')) {
      return Colors.blue[700]!;
    }
    
    // Frameworks & Libraries
    if (skillLower.contains('react') || skillLower.contains('vue') ||
        skillLower.contains('node') || skillLower.contains('spring') ||
        skillLower.contains('django') || skillLower.contains('angular')) {
      return Colors.purple[600]!;
    }
    
    // Cloud & Infrastructure
    if (skillLower.contains('aws') || skillLower.contains('azure') ||
        skillLower.contains('cloud') || skillLower.contains('devops') ||
        skillLower.contains('ci/cd') || skillLower.contains('kubernetes')) {
      return Colors.orange[600]!;
    }
    
    // Data & Analytics
    if (skillLower.contains('data') || skillLower.contains('machine learning') ||
        skillLower.contains('analytics') || skillLower.contains('etl') ||
        skillLower.contains('apache') || skillLower.contains('spark') ||
        skillLower.contains('kafka') || skillLower.contains('tableau') ||
        skillLower.contains('power bi')) {
      return Colors.green[600]!;
    }
    
    // Design & UX
    if (skillLower.contains('ux') || skillLower.contains('design') ||
        skillLower.contains('figma') || skillLower.contains('sketch') ||
        skillLower.contains('ui')) {
      return Colors.pink[500]!;
    }
    
    // Product & Management
    if (skillLower.contains('product') || skillLower.contains('agile') ||
        skillLower.contains('scrum') || skillLower.contains('management')) {
      return Colors.indigo[600]!;
    }
    
    // Experience levels
    if (skillLower.contains('years') || skillLower.contains('experience')) {
      return Colors.grey[600]!;
    }
    
    // Default color
    return theme.colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo and Title Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: FaIcon(
                    _DiscoverPageState.getCompanyLogo(job.company)['icon'],
                    size: 40,
                    color: _DiscoverPageState.getCompanyLogo(job.company)['color'],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        job.title, 
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        job.company, 
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(job.location, style: theme.textTheme.labelSmall),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
                            ),
                            child: Text(
                              job.type, 
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Text(
                            '\$${_formatNumber(job.salary)}', 
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.green[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[600]!.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              '\$${_formatHourly(job.hourly)}/hr',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(height: 1, thickness: 1, color: theme.colorScheme.outline.withOpacity(0.08)),
            const SizedBox(height: 10),
            // About
            Text('About the Role', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(job.about, style: theme.textTheme.labelSmall),
            const SizedBox(height: 10),
            Divider(height: 1, thickness: 1, color: theme.colorScheme.outline.withOpacity(0.08)),
            const SizedBox(height: 10),
            // Requirements
            Text('Required Experience & Education', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            ...job.requirements.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Expanded(child: Text(r, style: theme.textTheme.labelSmall)),
                ],
              ),
            )),
            const SizedBox(height: 10),
            // Highlights
            Text('Role Highlights', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            ...job.highlights.map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Expanded(child: Text(h, style: theme.textTheme.labelSmall)),
                ],
              ),
            )),
            const SizedBox(height: 10),
            // Responsibilities
            Text('Key Responsibilities', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            ...job.responsibilities.map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  Expanded(child: Text(h, style: theme.textTheme.labelSmall)),
                ],
              ),
            )),
            const SizedBox(height: 10),
            // Skills
            Text('Required Skills', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Wrap(
              spacing: 3,
              runSpacing: 3,
              children: job.skills.map((skill) {
                final skillColor = _getSkillColor(skill, theme);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: skillColor.withOpacity(0.1),
                    border: Border.all(color: skillColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    skill, 
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: skillColor,
                      fontSize: 9,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // Removed action buttons for pure swipe UX
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
  final String hourly;
  final String about;
  final List<String> requirements;
  final List<String> highlights;
  final List<String> responsibilities;
  final List<String> skills;

  JobListing({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
    required this.hourly,
    required this.about,
    required this.requirements,
    required this.highlights,
    required this.responsibilities,
    required this.skills,
  });
} 