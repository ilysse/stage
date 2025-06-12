import 'package:flutter/material.dart';
import '../../data/static_data.dart';
import '../login_screen.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _cart = [];
  double _total = 0.0;
  Map<String, dynamic>? _selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildPOSScreen(),
          _buildCustomersScreen(),
          _buildHistoryScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale),
            label: 'POS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  void _showQuantityDialog(Map<String, dynamic> product) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product['name'] ?? 'Unknown Product',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: quantity > 1
                        ? () {
                            setState(() {
                              quantity--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: quantity < (product['stock'] ?? 0)
                        ? () {
                            setState(() {
                              quantity++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
              Text(
                'Stock available: ${product['stock'] ?? 0}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                this.setState(() {
                  _cart.add({
                    ...product,
                    'quantity': quantity,
                    'total': (product['price'] ?? 0.0) * quantity,
                  });
                  _total += (product['price'] ?? 0.0) * quantity;
                });
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Customer'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(customer['name']),
                subtitle: Text(customer['email']),
                onTap: () {
                  setState(() {
                    _selectedCustomer = customer;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildPOSScreen() {
    return Column(
      children: [
        // Customer Selection
        if (_cart.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedCustomer?['name'] ?? 'Select Customer',
                    style: TextStyle(
                      color: _selectedCustomer == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _showCustomerSelectionDialog,
                  icon: const Icon(Icons.edit),
                  label: Text(_selectedCustomer == null ? 'Select' : 'Change'),
                ),
              ],
            ),
          ),

        // Products Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: InkWell(
                  onTap: () => _showQuantityDialog(product),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['name'] ?? 'Unknown Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${(product['price'] ?? 0.0).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Stock: ${product['stock'] ?? 0}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Cart Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_cart.isNotEmpty) ...[
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      final item = _cart[index];
                      return Card(
                        margin: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item['name'] ?? 'Unknown Product',
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item['quantity'] ?? 1} x \$${(item['price'] ?? 0.0).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '\$${(item['total'] ?? 0.0).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _total -= item['total'] ?? 0.0;
                                    _cart.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${_total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _selectedCustomer == null || _cart.isEmpty
                          ? null
                          : _printInvoice,
                      child: const Text('Print Invoice'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomersScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final customer = customers[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(customer['name']),
            subtitle: Text(customer['email']),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Show edit customer dialog
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: salesData.length,
      itemBuilder: (context, index) {
        final sale = salesData[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.receipt),
            ),
            title: Text('Sale on ${sale['date'] ?? 'N/A'}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer: ${sale['customer'] ?? 'N/A'}'),
                Text('Amount: \$${(sale['amount'] ?? 0.0).toStringAsFixed(2)}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.print),
              onPressed: () {
                // Reprint invoice
              },
            ),
          ),
        );
      },
    );
  }

  void _printInvoice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invoice'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
            Text('Customer: ${_selectedCustomer?['name'] ?? 'N/A'}'),
            const SizedBox(height: 16),
            ..._cart.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item['name']} (${item['quantity'] ?? 1} x \$${(item['price'] ?? 0.0).toStringAsFixed(2)})',
                        ),
                      ),
                      Text('\$${(item['total'] ?? 0.0).toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _cart.clear();
                _total = 0;
                _selectedCustomer = null;
              });
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
} 