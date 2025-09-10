import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cvms_mobile/src/core/controllers/font_controller.dart';
import 'package:cvms_mobile/src/core/controllers/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _sampleDisplay = false;
  bool _sampleSecurity = false;
  bool _backup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) {
                Scaffold.of(context).openDrawer();
              }
            });
          },
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Display Section
            _buildSectionTitle('Display'),
            const SizedBox(height: 12),

            _buildSettingCard(
              icon: Icons.text_fields,
              title: 'Font Size',
              subtitle: 'Adjust apps font size',
              trailing: Text(
                context.watch<FontController>().currentLabel,
                style: GoogleFonts.sora(fontSize: 14, color: Colors.grey[600]),
              ),
              onTap: () => _showFontSizeDialog(),
            ),

            _buildSettingCard(
              icon: Icons.dark_mode,
              title: 'Dark mode',
              subtitle: 'Switch to dark mode',
              trailing: Switch(
                value: context.watch<ThemeController>().isDarkMode,
                onChanged: (value) {
                  context.read<ThemeController>().setDarkMode(value);
                },
                activeColor: const Color(0xFF1E3A8A),
              ),
            ),

            _buildSettingCard(
              icon: Icons.wifi_off,
              title: 'Sample',
              subtitle: 'mock sample',
              trailing: Switch(
                value: _sampleDisplay,
                onChanged: (value) {
                  setState(() {
                    _sampleDisplay = value;
                  });
                },
                activeColor: const Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 32),

            // Security Section
            _buildSectionTitle('Security'),
            const SizedBox(height: 12),

            _buildSettingCard(
              icon: Icons.upload,
              title: 'Sample',
              subtitle: 'Adjust apps font size',
              onTap: () {},
            ),

            _buildSettingCard(
              icon: Icons.alternate_email,
              title: 'Sample',
              subtitle: 'Switch to dark mode',
              trailing: Switch(
                value: _sampleSecurity,
                onChanged: (value) {
                  setState(() {
                    _sampleSecurity = value;
                  });
                },
                activeColor: const Color(0xFF1E3A8A),
              ),
            ),

            _buildSettingCard(
              icon: Icons.backup,
              title: 'Backup',
              subtitle: 'Switch to dark mode',
              trailing: Switch(
                value: _backup,
                onChanged: (value) {
                  setState(() {
                    _backup = value;
                  });
                },
                activeColor: const Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 32),

            // Terms and Privacy Section
            _buildSectionTitle('Terms and Privacy'),
            const SizedBox(height: 12),

            _buildSettingCard(
              icon: Icons.description,
              title: 'Terms of service',
              subtitle: 'Adjust apps font size',
              onTap: () {},
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.sora(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.2 : 0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1E1E1E)
                    : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[300]
                    : Colors.grey[700],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.sora(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              'Font Size',
              style: GoogleFonts.sora(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select font size',
                  style: GoogleFonts.sora(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                ...['10pt', '12pt', '14pt', '16pt', '18pt'].map(
                  (size) => RadioListTile<String>(
                    title: Text(size, style: GoogleFonts.sora()),
                    value: size,
                    groupValue:
                        dialogContext.watch<FontController>().currentLabel,
                    onChanged: (value) {
                      final selected = value!;
                      dialogContext.read<FontController>().setByLabel(selected);
                      Navigator.pop(dialogContext);
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.sora(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
    );
  }
}
