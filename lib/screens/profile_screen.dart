import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDE8D5),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Creative member',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF29412F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF183A2D),
                      Color(0xFF2F6B4F),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2B35B),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 42,
                            color: Color(0xFF183A2D),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shuvajit Maitra',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Mobile product designer and Flutter explorer',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white70,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: _StatTile(
                              value: '128',
                              label: 'Projects',
                            ),
                          ),
                          Expanded(
                            child: _StatTile(
                              value: '24k',
                              label: 'Followers',
                            ),
                          ),
                          Expanded(
                            child: _StatTile(
                              value: '4.9',
                              label: 'Rating',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'About',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF1E2A22),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Building thoughtful interfaces, shaping design systems, and experimenting with polished Flutter interactions.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF55635A),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(
                    child: _InfoCard(
                      icon: Icons.palette_outlined,
                      title: 'Design',
                      subtitle: 'Interface systems and visual polish',
                      color: Color(0xFFFFE1B5),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _InfoCard(
                      icon: Icons.code_rounded,
                      title: 'Flutter',
                      subtitle: 'Clean UI builds and rapid iteration',
                      color: Color(0xFFCFE7FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick actions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E2A22),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _ActionRow(
                      icon: Icons.folder_copy_outlined,
                      title: 'View portfolio',
                      subtitle: 'Browse recent case studies and experiments',
                    ),
                    const Divider(height: 28),
                    const _ActionRow(
                      icon: Icons.mail_outline_rounded,
                      title: 'Contact',
                      subtitle: 'Start a conversation about collaboration',
                    ),
                    const Divider(height: 28),
                    const _ActionRow(
                      icon: Icons.settings_outlined,
                      title: 'Preferences',
                      subtitle: 'Update profile details and app behavior',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF183A2D),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Back to home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1E2A22),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E2A22),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF55635A),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F0E5),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF183A2D),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E2A22),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF55635A),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Color(0xFF7E8B82),
        ),
      ],
    );
  }
}
