import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivityPage extends StatelessWidget {
  const RecentActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F63E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F63E0),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Recent Activity',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          // curved white content area effect
          Positioned(
            top: 56,
            left: -80,
            right: -80,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFF1F63E0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
              ),
            ),
          ),
          // list
          Positioned.fill(top: 0, child: _RecentList()),
        ],
      ),
    );
  }
}

class _RecentList extends StatelessWidget {
  final List<_Item> items = const [
    _Item(
      title: 'Entry scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Exit scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Entry scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Vehicle scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Violation Report',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Exit scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
    _Item(
      title: 'Entry scan',
      subtitle: 'T45624  -  Honda Beat | Color: Orange',
      date: 'Aug 23, 2025 — 10:15 AM',
    ),
  ];

  const _RecentList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemBuilder: (context, index) => _RecentCard(item: items[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: items.length,
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  final _Item item;
  const _RecentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B0D17).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8EDF7)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.sora(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B0D17),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ' -  ${item.date}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sora(
                      color: const Color(0xFF5C6B8A),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item.subtitle,
              style: GoogleFonts.sora(
                color: const Color(0xFF8FA2C6),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item {
  final String title;
  final String date;
  final String subtitle;
  const _Item({
    required this.title,
    required this.subtitle,
    required this.date,
  });
}
