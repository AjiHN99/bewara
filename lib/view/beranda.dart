import 'package:flutter/material.dart';
import 'news_list.dart';
import 'add_news_dialog.dart';
import 'user_profile.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final List<Map<String, dynamic>> newsList = [];

  void _addNews() async {
    final newNews = await showAddNewsDialog(context);
    if (newNews != null) {
      setState(() {
        newsList.add(newNews);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            expandedHeight: 140,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman profil user
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final percent = ((constraints.maxHeight - kToolbarHeight) / (140 - kToolbarHeight)).clamp(0.0, 1.0);
                final logoSize = 30 + (80 - 30) * percent;
                final fontSize = 20 + (44 - 20) * percent;

                // Ukuran dan posisi untuk arrow_back
                const double arrowBackWidth = 55.0;

                // Animasi perpindahan dari tengah layar ke sebelah kanan arrow_back
                final double startLeft = MediaQuery.of(context).size.width / 2 - 111; /// 111 posisi "Bewara" di tengah
                final double endLeft = arrowBackWidth + 2; // jarak akhir ikon
                final double animatedLeft = startLeft + (endLeft - startLeft) * (1 - percent);

                final double top = percent > 0.5 ? 60 * (1 - percent) + 40 : 16;

                return Stack(
                  children: [
                    Positioned(
                      left: animatedLeft,
                      top: top,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            height: logoSize,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const SizedBox(width: 8),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            child: const Text('Be'),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            child: const Text('wara'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          if (newsList.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Ucapan selamat datang di tengah-tengah
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Selamat datang di aplikasi Bewara!\n\nBelum ada berita.\nSilakan tambahkan berita dengan menekan tombol + di kanan bawah.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Desain khusus di bawah logo (misal: garis dekoratif)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
          else
            NewsList(
              newsList: newsList,
              onTapNews: (news) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 90),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((news['image'] as String).isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(news['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                                ),
                              const SizedBox(height: 16),
                              // Tampilkan semua kategori sebagai chip
                              if (news['categories'] != null && (news['categories'] as List).isNotEmpty)
                                Wrap(
                                  spacing: 8,
                                  children: (news['categories'] as List<dynamic>)
                                      .map<Widget>((cat) => Chip(
                                            label: Text(cat.toString()),
                                            backgroundColor: Colors.blue[50],
                                            labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                          ))
                                      .toList(),
                                ),
                              const SizedBox(height: 12),
                              Text(
                                news['title'],
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                news['summary'],
                                style: const TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Tombol Tutup di kanan bawah, desain minimalis bulat panjang
                      Positioned(
                        right: 24,
                        bottom: 24,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.redAccent,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadowColor: Colors.black12,
                          ),
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, size: 22),
                          label: const Text('Tutup Berita', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNews,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambah Berita',
      ),
    );
  }
}
