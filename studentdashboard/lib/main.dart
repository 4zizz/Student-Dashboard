import 'package:flutter/material.dart';

void main() {
  runApp(const StudentDashboardApp());
}

class SagePalette {
  static const Color primary = Color(0xFF52796F);
  static const Color primaryDark = Color(0xFF354F52);
  static const Color primaryLight = Color(0xFF84A98C);
  static const Color softTint = Color(0xFFE8F0EB);
  static const Color borderTint = Color(0xFFC4D7CC);
  static const Color background = Color(0xFFF5F8F6);
  static const Color textDark = Color(0xFF1D2B24);
  static const Color textMuted = Color(0xFF63766C);
}

class StudentDashboardApp extends StatelessWidget {
  const StudentDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: SagePalette.primary,
          primary: SagePalette.primary,
        ),
        scaffoldBackgroundColor: SagePalette.background,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isFavorite = false;

  final String _studentName = 'Muchammad Naufal Aziz';
  final String _studentNrp = '5053251009';
  final String _studentMajor = 'Rekayasa Perangkat Lunak';
  final String _studentClass = 'Kelas M • Semester 3';

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.sizeOf(context).width >= 850;

    final List<Widget> pages = [
      DashboardHomeTab(
        studentName: _studentName,
        studentNrp: _studentNrp,
        studentMajor: _studentMajor,
        studentClass: _studentClass,
        isFavorite: _isFavorite,
        onToggleFavorite: _toggleFavorite,
        onNavigateTab: _selectTab,
      ),
      const CoursesTab(),
      ProfileTab(
        studentName: _studentName,
        studentNrp: _studentNrp,
        studentMajor: _studentMajor,
        studentClass: _studentClass,
        isFavorite: _isFavorite,
        onToggleFavorite: _toggleFavorite,
      ),
    ];

    return Scaffold(
      backgroundColor: SagePalette.background,
      body: SafeArea(
        child: Row(
          children: [
            if (isWideScreen)
              _SageSidebar(
                selectedIndex: _selectedIndex,
                onSelectTab: _selectTab,
              ),
            Expanded(child: pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              backgroundColor: Colors.white,
              indicatorColor: SagePalette.softTint,
              onDestinationSelected: _selectTab,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon:
                      Icon(Icons.dashboard, color: SagePalette.primary),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon:
                      Icon(Icons.menu_book, color: SagePalette.primary),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person, color: SagePalette.primary),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}

class _SageSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectTab;

  const _SageSidebar({
    required this.selectedIndex,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            SagePalette.primaryLight,
            SagePalette.primary,
            SagePalette.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: SagePalette.primary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 40).clamp(0.0, double.infinity),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Student Portal',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _SidebarNavItem(
                        icon: Icons.dashboard_rounded,
                        label: 'Dashboard',
                        isActive: selectedIndex == 0,
                        onTap: () => onSelectTab(0),
                      ),
                      _SidebarNavItem(
                        icon: Icons.menu_book_rounded,
                        label: 'Courses',
                        isActive: selectedIndex == 1,
                        onTap: () => onSelectTab(1),
                      ),
                      _SidebarNavItem(
                        icon: Icons.person_rounded,
                        label: 'Profile',
                        isActive: selectedIndex == 2,
                        onTap: () => onSelectTab(2),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(color: Colors.white24),
                      ),
                      _SidebarNavItem(
                        icon: Icons.code_rounded,
                        label: 'Flutter',
                        isActive: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FlutterMenuPage()),
                          );
                        },
                      ),
                      _SidebarNavItem(
                        icon: Icons.folder_copy_rounded,
                        label: 'Materials',
                        isActive: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MaterialsMenuPage()),
                          );
                        },
                      ),
                      _SidebarNavItem(
                        icon: Icons.assignment_rounded,
                        label: 'Assignments',
                        isActive: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AssignmentsMenuPage()),
                          );
                        },
                      ),
                      _SidebarNavItem(
                        icon: Icons.grade_rounded,
                        label: 'Grades',
                        isActive: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const GradesMenuPage()),
                          );
                        },
                      ),
                      const Spacer(),
                      const SizedBox(height: 8),
                      _SidebarNavItem(
                        icon: Icons.info_outline_rounded,
                        label: 'Semester 3',
                        isActive: false,
                        onTap: () => onSelectTab(2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SidebarNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color:
            isActive ? Colors.white.withValues(alpha: 0.22) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive ? Colors.white : Colors.white70,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.white70,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardHomeTab extends StatefulWidget {
  final String studentName;
  final String studentNrp;
  final String studentMajor;
  final String studentClass;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final ValueChanged<int> onNavigateTab;

  const DashboardHomeTab({
    super.key,
    required this.studentName,
    required this.studentNrp,
    required this.studentMajor,
    required this.studentClass,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onNavigateTab,
  });

  @override
  State<DashboardHomeTab> createState() => _DashboardHomeTabState();
}

class _DashboardHomeTabState extends State<DashboardHomeTab> {
  int _counter = 0;
  String _searchQuery = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.sizeOf(context).width >= 1050;

    final List<MenuItemData> allMenus = [
      MenuItemData(
        title: 'Flutter Fundamentals',
        subtitle: 'Widget, Layout & State',
        icon: Icons.code_rounded,
        destination: const FlutterMenuPage(),
      ),
      MenuItemData(
        title: 'Enrolled Courses',
        subtitle: '7 Mata Kuliah Aktif',
        icon: Icons.school_rounded,
        destination: const CoursesMenuPage(),
      ),
      MenuItemData(
        title: 'Learning Materials',
        subtitle: 'Modul & Slide Kuliah',
        icon: Icons.menu_book_rounded,
        destination: const MaterialsMenuPage(),
      ),
      MenuItemData(
        title: 'Assignments',
        subtitle: 'Praktikum & Tugas',
        icon: Icons.assignment_rounded,
        destination: const AssignmentsMenuPage(),
      ),
      MenuItemData(
        title: 'Grades / Nilai',
        subtitle: 'Transkrip Semester',
        icon: Icons.grade_rounded,
        destination: const GradesMenuPage(),
      ),
    ];

    final filteredMenus = allMenus
        .where((item) =>
            item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopHeader(context),
          const SizedBox(height: 18),
          _buildWelcomeBanner(),
          const SizedBox(height: 22),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildMainContent(filteredMenus, crossAxisCount: 2),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: _buildRightPanel(),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildMainContent(
                  filteredMenus,
                  crossAxisCount:
                      MediaQuery.sizeOf(context).width >= 600 ? 2 : 1,
                ),
                const SizedBox(height: 20),
                _buildRightPanel(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    final bool isCompact = MediaQuery.sizeOf(context).width < 600;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search menu...',
                hintStyle: TextStyle(
                  color: SagePalette.textMuted,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: SagePalette.primary,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => widget.onNavigateTab(2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: SagePalette.primary, width: 1.5),
                  ),
                  child: const CircleAvatar(
                    radius: 17,
                    backgroundColor: SagePalette.softTint,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                ),
                if (!isCompact) ...[
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.studentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: SagePalette.textDark,
                        ),
                      ),
                      Text(
                        'NRP: ${widget.studentNrp} • Kelas M',
                        style: const TextStyle(
                          fontSize: 11,
                          color: SagePalette.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: widget.onToggleFavorite,
            icon: Icon(
              widget.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: widget.isFavorite ? Colors.redAccent : SagePalette.primary,
              size: 21,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tidak ada notifikasi baru hari ini.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: SagePalette.primaryDark,
              size: 21,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SagePalette.primaryLight,
            SagePalette.primary,
            SagePalette.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: SagePalette.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '27 November 2026',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Welcome back, ${widget.studentName}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${widget.studentMajor} • NRP: ${widget.studentNrp} (${widget.studentClass})',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 46,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    List<MenuItemData> menuItems, {
    required int crossAxisCount,
  }) {
    final bool isNarrow = MediaQuery.sizeOf(context).width < 650;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Academic & Interactive Counter',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: SagePalette.textDark,
          ),
        ),
        const SizedBox(height: 12),
        if (isNarrow)
          Column(
            children: [
              _buildInteractiveCounterCard(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.auto_stories_rounded,
                      value: '21 SKS',
                      label: 'Semester 3',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.bar_chart_rounded,
                      value: '7 Matkul',
                      label: 'Kelas M',
                    ),
                  ),
                ],
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.auto_stories_rounded,
                  value: '21 SKS',
                  label: 'Total SKS',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: _buildInteractiveCounterCard(),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.bar_chart_rounded,
                  value: '7 Matkul',
                  label: 'Kelas M',
                ),
              ),
            ],
          ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Learning Menu',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: SagePalette.textDark,
              ),
            ),
            Text(
              '${menuItems.length} Menus',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: SagePalette.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: crossAxisCount == 1 ? 2.5 : 2.05,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              elevation: 0,
              color: SagePalette.softTint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: SagePalette.borderTint,
                  width: 1.5,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item.destination),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: SagePalette.primaryDark,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.subtitle,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: SagePalette.textMuted,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: SagePalette.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: SagePalette.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          item.icon,
                          size: 32,
                          color: SagePalette.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SagePalette.softTint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: SagePalette.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: SagePalette.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: SagePalette.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveCounterCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: SagePalette.primary,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Column(
          children: [
            const Text(
              'Interactive Counter',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: SagePalette.textMuted,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: SagePalette.primaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 52,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: _counter > 0 ? _decrementCounter : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SagePalette.primary,
                      disabledBackgroundColor: SagePalette.borderTint,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: const Icon(Icons.remove, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 52,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SagePalette.primary,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: const Icon(Icons.add, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 52,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: _resetCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SagePalette.softTint,
                      foregroundColor: SagePalette.primaryDark,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: const Icon(Icons.refresh, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Student Identity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: SagePalette.textDark,
              ),
            ),
            GestureDetector(
              onTap: () => widget.onNavigateTab(2),
              child: const Text(
                'See profile',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: SagePalette.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: SagePalette.primary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: SagePalette.softTint,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.studentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: SagePalette.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NRP: ${widget.studentNrp}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: SagePalette.textMuted,
                        ),
                      ),
                      Text(
                        widget.studentClass,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: SagePalette.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daily notice',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: SagePalette.textDark,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AssignmentsMenuPage()),
                );
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: SagePalette.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Praktikum Pemrograman Mobile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: SagePalette.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Implementasi Student Dashboard dengan StatefulWidget, GridView, dan navigasi antar halaman.',
                  style: TextStyle(
                    fontSize: 12,
                    color: SagePalette.textMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FlutterMenuPage()),
                    );
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: SagePalette.primary,
                    ),
                  ),
                ),
                const Divider(height: 24, color: SagePalette.softTint),
                const Text(
                  'Jadwal & Penilaian Semester 3',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: SagePalette.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Cek rekap nilai dan status tugas perkuliahan secara berkala melalui menu Grades.',
                  style: TextStyle(
                    fontSize: 12,
                    color: SagePalette.textMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GradesMenuPage()),
                    );
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: SagePalette.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget destination;

  MenuItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.destination,
  });
}

class FlutterMenuPage extends StatelessWidget {
  const FlutterMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      (
        'Stateless & Stateful Widget',
        'Perbedaan widget statis dan dinamis dengan setState().'
      ),
      ('Layouting Dasar', 'Penggunaan Column, Row, Container, dan Padding.'),
      (
        'List & Grid',
        'Menampilkan koleksi data menggunakan ListView dan GridView.'
      ),
      (
        'Navigasi Halaman',
        'Perpindahan layar menggunakan Navigator.push & NavigationBar.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Fundamentals'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: SagePalette.borderTint),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: SagePalette.softTint,
                child: Icon(Icons.code_rounded, color: SagePalette.primary),
              ),
              title: Text(topics[index].$1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(topics[index].$2),
            ),
          );
        },
      ),
    );
  }
}

class CoursesMenuPage extends StatelessWidget {
  const CoursesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: const CoursesListContent(),
    );
  }
}

class MaterialsMenuPage extends StatelessWidget {
  const MaterialsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = [
      ('Modul 1 - Pengenalan Dart', 'PDF • 2.4 MB'),
      ('Modul 2 - Widget Tree & Layout', 'PDF • 3.1 MB'),
      ('Modul 3 - State Management Dasar', 'PDF • 1.8 MB'),
      ('Modul 4 - Navigation & Routing', 'PDF • 2.0 MB'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Materials'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: SagePalette.borderTint),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: SagePalette.softTint,
                child:
                    Icon(Icons.menu_book_rounded, color: SagePalette.primary),
              ),
              title: Text(materials[index].$1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(materials[index].$2),
              trailing: const Icon(Icons.download_rounded,
                  color: SagePalette.primary),
            ),
          );
        },
      ),
    );
  }
}

class AssignmentsMenuPage extends StatelessWidget {
  const AssignmentsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assignments = [
      ('Praktikum 1: Student Dashboard UI', 'Tenggat: Hari ini', true),
      ('Praktikum 2: Form & Input Validation', 'Tenggat: Minggu depan', false),
      (
        'Tugas Proyek: Aplikasi Katalog Kampus',
        'Tenggat: 2 Minggu lagi',
        false
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final isDone = assignments[index].$3;
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: SagePalette.borderTint),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: SagePalette.softTint,
                child: Icon(
                  isDone
                      ? Icons.check_circle_rounded
                      : Icons.assignment_rounded,
                  color: SagePalette.primary,
                ),
              ),
              title: Text(assignments[index].$1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(assignments[index].$2),
              trailing: Chip(
                label: Text(
                  isDone ? 'Selesai' : 'Aktif',
                  style: TextStyle(
                    color: isDone
                        ? SagePalette.primaryDark
                        : SagePalette.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor:
                    isDone ? SagePalette.softTint : const Color(0xFFFFF3D6),
                side: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }
}

class GradesMenuPage extends StatelessWidget {
  const GradesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final grades = [
      ('Pemrograman Perangkat Bergerak', 'A', '92'),
      ('Kecerdasan Artifisial', 'A', '90'),
      ('Jaringan Komputer', 'AB', '85'),
      ('Sistem Operasi', 'A', '89'),
      ('Desain & Analisis Algoritma', 'AB', '84'),
      ('Arsitektur Perangkat Lunak', 'A', '91'),
      ('Interaksi Manusia dan Komputer', 'A', '93'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades / Nilai'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: grades.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: SagePalette.borderTint),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: SagePalette.softTint,
                child: Icon(Icons.grade_rounded, color: SagePalette.primary),
              ),
              title: Text(grades[index].$1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Skor Akhir: ${grades[index].$3}'),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: SagePalette.softTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  grades[index].$2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: SagePalette.primaryDark,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: const CoursesListContent(),
    );
  }
}

class CoursesListContent extends StatelessWidget {
  const CoursesListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      ('Pemrograman Perangkat Bergerak', '3 SKS • Semester 3 • Kelas M'),
      ('Kecerdasan Artifisial', '3 SKS • Semester 3 • Kelas M'),
      ('Jaringan Komputer', '3 SKS • Semester 3 • Kelas M'),
      ('Sistem Operasi', '3 SKS • Semester 3 • Kelas M'),
      ('Desain dan Analisis Algoritma', '3 SKS • Semester 3 • Kelas M'),
      ('Arsitektur Perangkat Lunak', '3 SKS • Semester 3 • Kelas M'),
      ('Interaksi Manusia dan Komputer', '3 SKS • Semester 3 • Kelas M'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: SagePalette.borderTint),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: SagePalette.softTint,
              child: Icon(Icons.school_rounded, color: SagePalette.primary),
            ),
            title: Text(courses[index].$1,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(courses[index].$2),
          ),
        );
      },
    );
  }
}

class ProfileTab extends StatelessWidget {
  final String studentName;
  final String studentNrp;
  final String studentMajor;
  final String studentClass;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const ProfileTab({
    super.key,
    required this.studentName,
    required this.studentNrp,
    required this.studentMajor,
    required this.studentClass,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: SagePalette.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: SagePalette.borderTint),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: SagePalette.primary, width: 2.5),
                  ),
                  child: const CircleAvatar(
                    radius: 46,
                    backgroundColor: SagePalette.softTint,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  studentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SagePalette.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'NRP: $studentNrp',
                  style: const TextStyle(
                    fontSize: 15,
                    color: SagePalette.textMuted,
                  ),
                ),
                const Divider(height: 32, color: SagePalette.softTint),
                ListTile(
                  leading: const Icon(Icons.school_rounded,
                      color: SagePalette.primary),
                  title: const Text('Program Studi'),
                  subtitle: Text(studentMajor),
                ),
                ListTile(
                  leading: const Icon(Icons.class_rounded,
                      color: SagePalette.primary),
                  title: const Text('Kelas'),
                  subtitle: Text(studentClass),
                ),
                ListTile(
                  leading: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.redAccent : SagePalette.primary,
                  ),
                  title: const Text('Status Favorit'),
                  subtitle: Text(isFavorite
                      ? 'Ditandai sebagai favorit'
                      : 'Belum ditandai'),
                  trailing: TextButton(
                    onPressed: onToggleFavorite,
                    child: const Text(
                      'Ubah',
                      style: TextStyle(
                        color: SagePalette.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}