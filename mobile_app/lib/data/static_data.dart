import '../models/user.dart';

// Static users
final List<User> users = [
  User(username: 'admin', role: UserRole.admin, name: 'Admin User'),
  User(username: 'seller1', role: UserRole.seller, name: 'John Seller'),
  User(username: 'seller2', role: UserRole.seller, name: 'Jane Seller'),
];

// Static products
final List<Map<String, dynamic>> products = [
  {'id': 1, 'name': 'Product 1', 'price': 99.99, 'stock': 100},
  {'id': 2, 'name': 'Product 2', 'price': 149.99, 'stock': 50},
  {'id': 3, 'name': 'Product 3', 'price': 199.99, 'stock': 75},
  {'id': 4, 'name': 'Product 4', 'price': 299.99, 'stock': 25},
];

// Static customers
final List<Map<String, dynamic>> customers = [
  {'id': 1, 'name': 'Customer 1', 'email': 'customer1@email.com', 'phone': '123-456-7890'},
  {'id': 2, 'name': 'Customer 2', 'email': 'customer2@email.com', 'phone': '234-567-8901'},
  {'id': 3, 'name': 'Customer 3', 'email': 'customer3@email.com', 'phone': '345-678-9012'},
];

// Static sales data for admin dashboard
final List<Map<String, dynamic>> salesData = [
  {'date': '2024-03-01', 'amount': 1500.00, 'seller': 'John Seller'},
  {'date': '2024-03-02', 'amount': 2300.00, 'seller': 'Jane Seller'},
  {'date': '2024-03-03', 'amount': 1800.00, 'seller': 'John Seller'},
  {'date': '2024-03-04', 'amount': 2100.00, 'seller': 'Jane Seller'},
];

// Static metrics for admin dashboard
final Map<String, dynamic> metrics = {
  'totalSales': 7700.00,
  'totalCustomers': 3,
  'totalProducts': 4,
  'averageSale': 1925.00,
  'topSellingProduct': 'Product 1',
  'topSeller': 'Jane Seller',
}; 