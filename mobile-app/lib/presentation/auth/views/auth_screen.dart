import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/responsive_container.dart';
import '../viewmodels/auth_viewmodel.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController(text: 'priya.sharma@hopkid.in');
  final _passwordController = TextEditingController(text: 'hopkid123');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final authState = ref.read(authViewModelProvider);
    final vm = ref.read(authViewModelProvider.notifier);

    final ok = authState.isSignupMode
        ? await vm.signup(
            _nameController.text,
            _identifierController.text,
            _passwordController.text,
          )
        : await vm.login(
            _identifierController.text,
            _passwordController.text,
          );
    if (ok && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final vm = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ResponsiveContainer(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Hopkid Logo
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: AppColors.lightPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.workspace_premium_rounded,
                              size: 32,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppConstants.appName,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome back to happy kids shopping',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),

                      // Login / Sign Up Tabs
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _TabButton(
                                label: 'Login',
                                selected: !authState.isSignupMode,
                                onTap: () => vm.toggleMode(false),
                              ),
                            ),
                            Expanded(
                              child: _TabButton(
                                label: 'Sign Up',
                                selected: authState.isSignupMode,
                                onTap: () => vm.toggleMode(true),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      if (authState.errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.error.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            authState.errorMessage!,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      if (authState.isSignupMode) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
                        ),
                        const SizedBox(height: 14),
                      ],

                      TextFormField(
                        controller: _identifierController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number / Email',
                          prefixIcon: Icon(Icons.alternate_email_rounded),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Enter mobile number or email'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        validator: (v) => (v == null || v.length < 6)
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),

                      if (!authState.isSignupMode)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Password reset link sent to your registered contact.',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primaryPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 20),

                      PrimaryButton(
                        label: authState.isSignupMode ? 'Create Account' : 'Login',
                        isLoading: authState.isLoading,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(height: 18),

                      _SocialAuthButton(
                        icon: Icons.g_mobiledata_rounded,
                        label: 'Continue with Google',
                        onTap: () async {
                          final ok = await vm.continueWithGoogle();
                          if (ok && context.mounted) context.go('/home');
                        },
                      ),
                      const SizedBox(height: 12),
                      _SocialAuthButton(
                        icon: Icons.apple_rounded,
                        label: 'Continue with Apple',
                        onTap: () async {
                          final ok = await vm.continueWithApple();
                          if (ok && context.mounted) context.go('/home');
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            authState.isSignupMode
                                ? 'Already have an account? '
                                : "Don't have an account? ",
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.toggleMode(!authState.isSignupMode),
                            child: Text(
                              authState.isSignupMode ? 'Login' : 'Sign Up',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.primaryPurple : AppColors.secondaryText,
          ),
        ),
      ),
    );
  }
}

class _SocialAuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialAuthButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 22, color: AppColors.primaryText),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
