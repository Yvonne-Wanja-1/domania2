import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _promoController = TextEditingController();
  bool _isApplyingPromo = false;
  String? _appliedPromoCode;

  // Example cart items - in a real app, this would come from a cart service
  final List<CartItem> _cartItems = [
    CartItem(
      domain: 'mycompany.ke',
      years: 1,
      pricePerYear: 999.0,
    ),
    CartItem(
      domain: 'startup.ke',
      years: 2,
      pricePerYear: 999.0,
    ),
  ];

  double get _subtotal => _cartItems.fold(
        0,
        (sum, item) => sum + (item.pricePerYear * item.years),
      );

  double get _discount => _appliedPromoCode != null ? _subtotal * 0.1 : 0;
  double get _tax => (_subtotal - _discount) * 0.16; // 16% VAT
  double get _total => _subtotal - _discount + _tax;

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _updateYears(int index, int years) {
    setState(() {
      _cartItems[index].years = years;
    });
  }

  Future<void> _applyPromoCode() async {
    if (_promoController.text.isEmpty) return;

    setState(() => _isApplyingPromo = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _appliedPromoCode = _promoController.text;
      _isApplyingPromo = false;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Promo code applied successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cartItems.isEmpty) {
      return _buildEmptyCart(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.shopping_cart),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Cart Items
                ...List.generate(
                  _cartItems.length,
                  (index) => _buildCartItemCard(index),
                ),
                const SizedBox(height: 24),

                // Promo Code Section
                _buildPromoCodeSection(),
                const SizedBox(height: 24),

                // Order Summary
                _buildOrderSummary(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Checkout Button
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _cartItems[index].isFavorite = !_cartItems[index].isFavorite;
    });
  }

  Widget _buildCartItemCard(int index) {
    final item = _cartItems[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.domain,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: item.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _removeItem(index),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Duration:'),
                      const SizedBox(width: 8),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: item.years > 1
                                    ? () => _updateYears(index, item.years - 1)
                                    : null,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: item.years > 1
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(minWidth: 28),
                              alignment: Alignment.center,
                              child: Text(
                                '${item.years}${item.years == 1 ? 'yr' : 'yrs'}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: item.years < 10
                                    ? () => _updateYears(index, item.years + 1)
                                    : null,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: item.years < 10
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'KES ${(item.pricePerYear * item.years).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Have a Promo Code?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabled: _appliedPromoCode == null,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (_isApplyingPromo)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed:
                        _appliedPromoCode == null ? _applyPromoCode : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Apply'),
                  ),
              ],
            ),
            if (_appliedPromoCode != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Promo code $_appliedPromoCode applied!',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Subtotal', _subtotal),
            if (_discount > 0) _buildSummaryRow('Discount', -_discount),
            _buildSummaryRow('VAT (16%)', _tax),
            const Divider(height: 32),
            _buildSummaryRow(
              'Total',
              _total,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            'KES ${amount.toStringAsFixed(2)}',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement checkout
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(Icons.lock),
            //SizedBox(width: 8),
            Text(
              'Proceed to Checkout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start searching for your perfect .KE domain!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String domain;
  final double pricePerYear;
  int years;
  bool isFavorite;

  CartItem({
    required this.domain,
    required this.years,
    required this.pricePerYear,
    this.isFavorite = false,
  });
}
