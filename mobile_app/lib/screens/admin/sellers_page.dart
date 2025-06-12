import 'package:flutter/material.dart';
import '../../data/static_data.dart';
import '../../models/user.dart';

class SellersPage extends StatelessWidget {
  const SellersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sellers = users.where((user) => user.role == UserRole.seller).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sellers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Show add seller dialog
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Seller'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: sellers.length,
              itemBuilder: (context, index) {
                final seller = sellers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(seller.name),
                    subtitle: Text('Email: ${seller.email}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // TODO: Implement edit functionality
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 