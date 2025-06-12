import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/static_data.dart';
import '../../models/user.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? _selectedSeller;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _selectedChartType = 'Daily';

  @override
  Widget build(BuildContext context) {
    final sellers = users.where((user) => user.role == UserRole.seller).toList();
    final filteredSales = _getFilteredSales();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filters
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Seller',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedSeller,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('All Sellers'),
                          ),
                          ...sellers.map((seller) => DropdownMenuItem(
                                value: seller.name,
                                child: Text(seller.name),
                              )),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSeller = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () => _selectDateRange(context),
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                '${_startDate.toString().split(' ')[0]} - ${_endDate.toString().split(' ')[0]}',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: _selectedChartType,
                            items: const [
                              DropdownMenuItem(
                                value: 'Daily',
                                child: Text('Daily'),
                              ),
                              DropdownMenuItem(
                                value: 'Weekly',
                                child: Text('Weekly'),
                              ),
                              DropdownMenuItem(
                                value: 'Monthly',
                                child: Text('Monthly'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedChartType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Summary Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildSummaryCard(
                    'Total Sales',
                    '\$${_calculateTotalSales(filteredSales).toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                  _buildSummaryCard(
                    'Number of Sales',
                    filteredSales.length.toString(),
                    Icons.receipt,
                    Colors.blue,
                  ),
                  _buildSummaryCard(
                    'Average Sale',
                    '\$${_calculateAverageSale(filteredSales).toStringAsFixed(2)}',
                    Icons.trending_up,
                    Colors.orange,
                  ),
                  _buildSummaryCard(
                    'Top Product',
                    _getTopProduct(filteredSales),
                    Icons.star,
                    Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sales Chart
              const Text(
                'Sales Trend',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getChartData(filteredSales),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sales List
              const Text(
                'Sales Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredSales.length,
                itemBuilder: (context, index) {
                  final sale = filteredSales[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ExpansionTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.receipt),
                      ),
                      title: Text(
                        'Sale by ${sale['seller']}',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sale['date'],
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Customer: ${sale['customer']}',
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Total: \$${sale['amount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Products:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...sale['products'].map<Widget>((product) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${product['name']} x${product['quantity']}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        '\$${(product['price'] * product['quantity']).toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredSales() {
    return salesData.where((sale) {
      final saleDate = DateTime.parse(sale['date']);
      final sellerMatch = _selectedSeller == null || sale['seller'] == _selectedSeller;
      final dateMatch = saleDate.isAfter(_startDate) && saleDate.isBefore(_endDate.add(const Duration(days: 1)));
      return sellerMatch && dateMatch;
    }).toList();
  }

  double _calculateTotalSales(List<Map<String, dynamic>> sales) {
    return sales.fold(0.0, (sum, sale) => sum + sale['amount']);
  }

  double _calculateAverageSale(List<Map<String, dynamic>> sales) {
    if (sales.isEmpty) return 0;
    return _calculateTotalSales(sales) / sales.length;
  }

  String _getTopProduct(List<Map<String, dynamic>> sales) {
    final productCounts = <String, int>{};
    for (var sale in sales) {
      for (var product in sale['products']) {
        final name = product['name'] as String;
        productCounts[name] = (productCounts[name] ?? 0) + (product['quantity'] as int);
      }
    }
    if (productCounts.isEmpty) return 'N/A';
    return productCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  List<FlSpot> _getChartData(List<Map<String, dynamic>> sales) {
    final sortedSales = List<Map<String, dynamic>>.from(sales)
      ..sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

    return sortedSales.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value['amount'] / 1000,
      );
    }).toList();
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }
} 