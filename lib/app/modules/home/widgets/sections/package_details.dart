import 'package:flutter/material.dart';

class PackageDetails extends StatelessWidget {
  final String title;
  final String assetPath;

  const PackageDetails(
      {super.key, required this.title, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final isProbashi = title == 'Probashi Package';
    final caption = isProbashi ? null : 'Bellevie Guardian Health Programme';

    const premiumHeader = [
      'Category',
      'Product 1',
      'Product 2',
      'Product 3',
      'Product 4',
      'Product 5',
    ];

    const premiumRows = [
      [
        'Yearly Premium',
        'BDT 549',
        'BDT 999',
        'BDT 1499',
        'BDT 2399',
        'BDT 3599',
      ],
      [
        'Life',
        '100,000',
        '150,000',
        '175,000',
        '200,000',
        '350,000',
      ],
      [
        'ADB',
        '200,000',
        '300,000',
        '350,000',
        '400,000',
        '700,000',
      ],
      [
        'PTD & PPD',
        '100,000',
        'N/A',
        '175,000',
        '200,000',
        '250,000',
      ],
      [
        'Critical Illness',
        'N/A',
        '25,000',
        '50,000',
        '100,000',
        '150,000',
      ],
      [
        'Hospicash',
        'BDT 5000 (BDT 500/day, up to 5 days in a row)',
        'BDT 15,000 (BDT 1000/day, up to 5 days in a row)',
        'BDT 15,000 (BDT 1500/day, up to 5 days in a row)',
        'BDT 20,000 (BDT 1500/day, up to 5 days in a row)',
        'BDT 35,000 (BDT 2000/day, up to 5 days in a row)',
      ],
      [
        'OPD',
        'N/A',
        'N/A',
        'N/A',
        '2000',
        '5000',
      ],
      [
        'Telemedicine',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
      ],
      [
        'Discount Facilities',
        'Up to 50% Discount facilities Up to 50+ Hospitals & Diagnostic center all around Bangladesh. https://guardianlife.com.bd/preferred-hospital',
        '',
        '',
        '',
        '',
      ],
    ];

    const probashiHeader = ['Category', 'Coverage'];

    const probashiRows = [
      ['Life', '500,000'],
      ['PTD', '500,000'],
      ['PPD', '50,000-200,000'],
      ['Funeral Benefit', 'Up to 20,000'],
      ['Dead Body Repatriation', '15,000'],
      ['Loss of Income (Up to six Months) Month', '50,000'],
      ['Hospitalization', '50,000 (BDT 5000/day, up to 5 days in a row)'],
      [
        'Telemedicine',
        '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
      ],
      ['Yearly Premium (BDT)', '6250'],
    ];

    final header = isProbashi ? probashiHeader : premiumHeader;
    final rows = isProbashi ? probashiRows : premiumRows;
    final widths = isProbashi
        ? const [180.0, 240.0]
        : const [120.0, 140.0, 140.0, 140.0, 140.0, 140.0];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                assetPath,
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 110,
                  color: Colors.grey.shade100,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            if (caption != null) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  caption,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBEE9FF),
                    Color(0xFFDFF8EF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33FFFFFF),
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Color(0x22000000),
                    offset: Offset(3, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTableRow(header, widths, isHeader: true),
                    const SizedBox(height: 6),
                    for (final row in rows) ...[
                      _buildTableRow(row, widths),
                      const SizedBox(height: 6),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTableRow(
    List<String> cells,
    List<double> widths, {
    bool isHeader = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        cells.length,
        (index) => _buildCell(
          cells[index],
          width: widths[index],
          isHeader: isHeader,
        ),
      ),
    );
  }

  static Widget _buildCell(
    String text, {
    required double width,
    bool isHeader = false,
  }) {
    final background = isHeader ? const Color(0xFFE6F4FF) : Colors.white;
    final borderColor = isHeader ? const Color(0xFFD6E8F6) : Colors.black12;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 12.5 : 12,
          fontWeight: isHeader ? FontWeight.w700 : FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
