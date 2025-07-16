import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import 'signin_modal.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
    
    // Use Future.microtask to avoid setState during build
    Future.microtask(() => _checkAuthStatus());
  }

  Future<void> _checkAuthStatus() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.checkAuthStatus();
    
    if (mounted) {
      if (authService.isAuthenticated) {
        // User is already logged in
        if (authService.currentUser?.isProfileComplete == true) {
          context.go('/discover');
        } else {
          context.go('/profile-quiz');
        }
      } else {
        // Show sign-in modal after a brief delay
        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) {
          _showSignInModal();
        }
      }
    }
  }

  void _showSignInModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SignInModal(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo with smooth animation
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.work,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // App name with smooth fade
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'JobIT',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Tagline with delayed animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Swipe. Apply. Hired.',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),
                
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Jobs made simple.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Aesthetic loading indicator
                Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Loading text with pulse animation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Text(
                        'Loading...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 