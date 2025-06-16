import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;
  final void Function(Map<String, dynamic>)? onTapNews;

  const NewsList({
    super.key,
    required this.newsList,
    this.onTapNews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final news = newsList[index];
            return GestureDetector(
              onTap: () => onTapNews?.call(news),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((news['image'] as String).isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(news['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tampilkan semua kategori sebagai chip
                          Wrap(
                            spacing: 8,
                            children: (news['categories'] as List<dynamic>? ?? [])
                                .map<Widget>((cat) => Chip(
                                      label: Text(cat.toString()),
                                      backgroundColor: Colors.blue[50],
                                      labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            news['title'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            news['summary'],
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: newsList.length,
        ),
      ),
    );
  }
}
