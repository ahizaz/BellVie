
// import 'dart:async';
// import 'dart:convert';

// import 'package:bellevie/app/modules/home/widgets/sections/medical_product_details_view.dart';
// import 'package:bellevie/app/services/api_service.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MedicalAccessoriesSection extends StatefulWidget {
//   const MedicalAccessoriesSection({super.key});

//   @override
//   State<MedicalAccessoriesSection> createState() =>
//       _MedicalAccessoriesSectionState();
// }

// class _MedicalAccessoriesSectionState extends State<MedicalAccessoriesSection> {
//   static const String _cacheKey = 'medical_accessories_categories_cache_v1';

//   final AppApiService _apiService = AppApiService();

//   bool _isFetching = false;
//   bool _isLoading = true;
//   List<_MedicalAccessoryItem> _items = [];

//   @override
//   void initState() {
//     super.initState();
//     _restoreCachedCategories().then((hasCache) {
//       _fetchCategories(showLoading: !hasCache);
//     });
//   }

//   String _resolveImageUrl(String raw) {
//     final value = raw.trim();
//     if (value.isEmpty) return '';

//     if (value.startsWith('http://') || value.startsWith('https://')) {
//       return value;
//     }

//     return '${AppApiService.baseUrl}$value';
//   }

//   Future<void> _fetchCategories({bool showLoading = true}) async {
//     if (_isFetching) return;

//     _isFetching = true;

//     if (showLoading && mounted) {
//       setState(() {
//         _isLoading = true;
//       });
//     }

//     try {
//       debugPrint(
//         'Medical categories => GET ${AppApiService.baseUrl}/api/v1/medical-accessories/categories/',
//       );

//       final response = await _apiService.get(
//         path: '/api/v1/medical-accessories/categories/',
//       );

//       debugPrint('Medical categories => status: ${response.statusCode}');
//       debugPrint('Medical categories => body: ${response.body}');

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final dynamic decoded = jsonDecode(response.body);
//         final rawList = _extractList(decoded);

//         final List<_MedicalAccessoryItem> items = rawList
//             .whereType<Map<String, dynamic>>()
//             .map((m) {
//               try {
//                 final id = (m['id'] ?? 0) is int
//                     ? m['id'] as int
//                     : int.tryParse((m['id'] ?? '0').toString()) ?? 0;

//                 final nameEn = (m['name_en'] ?? m['name'] ?? '').toString();
//                 final nameBn = (m['name_bn'] ?? '').toString();
//                 final image = _resolveImageUrl((m['image'] ?? '').toString());

//                 return _MedicalAccessoryItem(
//                   id: id,
//                   nameEn: nameEn,
//                   nameBn: nameBn,
//                   imageUrl: image,
//                 );
//               } catch (e) {
//                 debugPrint('Medical category parse error => $e');
//                 return null;
//               }
//             })
//             .whereType<_MedicalAccessoryItem>()
//             .where((item) => item.name.isNotEmpty)
//             .toList();

//         if (!mounted) return;

//         setState(() {
//           _items = items;
//           _isLoading = false;
//         });

//         await _saveCachedCategories(items);
//         return;
//       }

//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Categories fetch error => $e');

//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } finally {
//       _isFetching = false;
//     }
//   }

//   List<dynamic> _extractList(dynamic decoded) {
//     if (decoded is List) return decoded;

//     if (decoded is Map<String, dynamic>) {
//       final results = decoded['results'];
//       if (results is List) return results;

//       final data = decoded['data'];
//       if (data is List) return data;

//       final items = decoded['items'];
//       if (items is List) return items;
//     }

//     return const [];
//   }

//   Future<bool> _restoreCachedCategories() async {
//     final cached = await _loadCachedCategories();

//     if (!mounted || cached.isEmpty) return false;

//     setState(() {
//       _items = cached;
//       _isLoading = false;
//     });

//     return true;
//   }

//   Future<List<_MedicalAccessoryItem>> _loadCachedCategories() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cachedJson = prefs.getString(_cacheKey);

//       if (cachedJson == null || cachedJson.isEmpty) return [];

//       final decoded = jsonDecode(cachedJson);

//       if (decoded is! List) return [];

//       return decoded
//           .whereType<Map<String, dynamic>>()
//           .map((m) {
//             try {
//               final id = (m['id'] ?? 0) is int
//                   ? m['id'] as int
//                   : int.tryParse((m['id'] ?? '0').toString()) ?? 0;

//               final nameEn = (m['name_en'] ?? m['name'] ?? '').toString();
//               final nameBn = (m['name_bn'] ?? '').toString();
//               final image = (m['imageUrl'] ?? '').toString();

//               return _MedicalAccessoryItem(
//                 id: id,
//                 nameEn: nameEn,
//                 nameBn: nameBn,
//                 imageUrl: image,
//               );
//             } catch (e) {
//               debugPrint('Medical accessories cache item parse error => $e');
//               return null;
//             }
//           })
//           .whereType<_MedicalAccessoryItem>()
//           .where((item) => item.name.isNotEmpty)
//           .toList();
//     } catch (e) {
//       debugPrint('Medical accessories cache read error => $e');
//       return [];
//     }
//   }

//   Future<void> _saveCachedCategories(List<_MedicalAccessoryItem> items) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();

//       final encoded = jsonEncode(
//         items
//             .map(
//               (e) => {
//                 'id': e.id,
//                 'name_en': e.nameEn,
//                 'name_bn': e.nameBn,
//                 'imageUrl': e.imageUrl,
//               },
//             )
//             .toList(),
//       );

//       await prefs.setString(_cacheKey, encoded);
//     } catch (e) {
//       debugPrint('Medical accessories cache write error => $e');
//     }
//   }

//   void _goToDetails(_MedicalAccessoryItem item) {
//     Get.to(
//       () => MedicalAccessoryProductDetailsView(
//         categoryName: item.name,
//         categoryImage: item.imageUrl,
//       ),
//     );
//   }

//   void _goToAllMedicalAccessories() {
//     Get.to(
//       () => AllMedicalAccessoriesView(
//         items: _items,
//         onItemTap: _goToDetails,
//       ),
//     );
//   }

//   Widget _buildAccessoryItem(_MedicalAccessoryItem item) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () => _goToDetails(item),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 44,
//             width: 44,
//             child: item.imageUrl.isNotEmpty
//                 ? CachedNetworkImage(
//                     imageUrl: item.imageUrl,
//                     fit: BoxFit.contain,
//                     errorWidget: (_, __, ___) => const Icon(
//                       Icons.image_not_supported,
//                       size: 26,
//                       color: Colors.black26,
//                     ),
//                   )
//                 : const Icon(
//                     Icons.image_not_supported,
//                     size: 26,
//                     color: Colors.black26,
//                   ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             item.name,
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 10,
//               height: 1.2,
//               fontWeight: FontWeight.w800,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final visibleItems = _items.take(8).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 'medical_accessories'.tr,
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(18),
//               onTap: _goToAllMedicalAccessories,
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'See all',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF2F6FED),
//                     ),
//                   ),
//                   SizedBox(width: 4),
//                   Icon(
//                     Icons.arrow_forward_ios,
//                     size: 12,
//                     color: Color(0xFF2F6FED),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         _isLoading && _items.isEmpty
//             ? const SizedBox(
//                 height: 120,
//                 child: Center(
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               )
//             : _items.isEmpty
//                 ? const SizedBox(
//                     height: 100,
//                     child: Center(
//                       child: Text(
//                         'No categories found',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ),
//                   )
//                 : GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: visibleItems.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 0.9,
//                     ),
//                     itemBuilder: (context, index) {
//                       return _buildAccessoryItem(visibleItems[index]);
//                     },
//                   ),
//       ],
//     );
//   }
// }

// class AllMedicalAccessoriesView extends StatelessWidget {
//   final List<_MedicalAccessoryItem> items;
//   final void Function(_MedicalAccessoryItem item) onItemTap;

//   const AllMedicalAccessoriesView({
//     super.key,
//     required this.items,
//     required this.onItemTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medical Accessories'),
//         centerTitle: true,
//       ),
//       body: items.isEmpty
//           ? const Center(
//               child: Text(
//                 'No categories found',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.black54,
//                 ),
//               ),
//             )
//           : GridView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: items.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 14,
//                 childAspectRatio: 0.82,
//               ),
//               itemBuilder: (context, index) {
//                 final item = items[index];

//                 return InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: () => onItemTap(item),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 46,
//                         width: 46,
//                         child: item.imageUrl.isNotEmpty
//                             ? CachedNetworkImage(
//                                 imageUrl: item.imageUrl,
//                                 fit: BoxFit.contain,
//                                 errorWidget: (_, __, ___) => const Icon(
//                                   Icons.image_not_supported,
//                                   size: 26,
//                                   color: Colors.black26,
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.image_not_supported,
//                                 size: 26,
//                                 color: Colors.black26,
//                               ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item.name,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           height: 1.2,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class _MedicalAccessoryItem {
//   final int id;
//   final String nameEn;
//   final String nameBn;
//   final String imageUrl;

//   _MedicalAccessoryItem({
//     required this.id,
//     required this.nameEn,
//     required this.nameBn,
//     required this.imageUrl,
//   });

//   String localizedName(Locale? locale) {
//     final lang = locale?.languageCode ?? 'en';

//     if (lang == 'bn' && nameBn.trim().isNotEmpty) {
//       return nameBn.trim();
//     }

//     return nameEn.trim();
//   }

//   String get name => localizedName(Get.locale);
// }


import 'dart:async';
import 'dart:convert';

import 'package:bellevie/app/modules/home/widgets/sections/medical_product_details_view.dart';
import 'package:bellevie/app/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalAccessoriesSection extends StatefulWidget {
  const MedicalAccessoriesSection({super.key});

  @override
  State<MedicalAccessoriesSection> createState() =>
      _MedicalAccessoriesSectionState();
}

class _MedicalAccessoriesSectionState
    extends State<MedicalAccessoriesSection> {

  // v2 because details are now included in cache
  static const String _cacheKey =
      'medical_accessories_categories_cache_v2';

  final AppApiService _apiService = AppApiService();

  bool _isFetching = false;
  bool _isLoading = true;

  List<_MedicalAccessoryItem> _items = [];

  @override
  void initState() {
    super.initState();

    _restoreCachedCategories().then((hasCache) {
      _fetchCategories(showLoading: !hasCache);
    });
  }

  // ============================================================
  // IMAGE URL
  // ============================================================

  String _resolveImageUrl(String raw) {
    final value = raw.trim();

    if (value.isEmpty) {
      return '';
    }

    if (value.startsWith('http://') ||
        value.startsWith('https://')) {
      return value;
    }

    return '${AppApiService.baseUrl}$value';
  }

  // ============================================================
  // FETCH CATEGORIES
  // ============================================================

  Future<void> _fetchCategories({
    bool showLoading = true,
  }) async {
    if (_isFetching) return;

    _isFetching = true;

    if (showLoading && mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      debugPrint(
        'Medical categories => GET '
        '${AppApiService.baseUrl}'
        '/api/v1/medical-accessories/categories/',
      );

      final response = await _apiService.get(
        path: '/api/v1/medical-accessories/categories/',
      );

      debugPrint(
        'Medical categories => status: '
        '${response.statusCode}',
      );

      debugPrint(
        'Medical categories => body: '
        '${response.body}',
      );

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {

        final dynamic decoded =
            jsonDecode(response.body);

        final rawList = _extractList(decoded);

        final List<_MedicalAccessoryItem> items =
            rawList
                .whereType<Map<String, dynamic>>()
                .map((m) {
          try {
            // ----------------------------------------------------
            // ID
            // ----------------------------------------------------

            final id = (m['id'] ?? 0) is int
                ? m['id'] as int
                : int.tryParse(
                      (m['id'] ?? '0').toString(),
                    ) ??
                    0;

            // ----------------------------------------------------
            // NAME
            // ----------------------------------------------------

            final nameEn =
                (m['name_en'] ??
                        m['name'] ??
                        '')
                    .toString();

            final nameBn =
                (m['name_bn'] ?? '').toString();

            // ----------------------------------------------------
            // IMAGE
            // ----------------------------------------------------

            final image =
                _resolveImageUrl(
              (m['image'] ?? '').toString(),
            );

            // ----------------------------------------------------
            // DETAILS
            // ----------------------------------------------------

            final details =
                m['details']?.toString();

            final detailsEn =
                m['details_en']?.toString();

            final detailsBn =
                m['details_bn']?.toString();

            debugPrint(
              'Medical category => '
              'id: $id, '
              'name: $nameEn, '
              'details: $details, '
              'details_en: $detailsEn, '
              'details_bn: $detailsBn',
            );

            return _MedicalAccessoryItem(
              id: id,
              nameEn: nameEn,
              nameBn: nameBn,
              imageUrl: image,

              // IMPORTANT
              details: details,
              detailsEn: detailsEn,
              detailsBn: detailsBn,
            );
          } catch (e) {
            debugPrint(
              'Medical category parse error => $e',
            );

            return null;
          }
        })
                .whereType<_MedicalAccessoryItem>()
                .where(
                  (item) => item.name.isNotEmpty,
                )
                .toList();

        if (!mounted) return;

        setState(() {
          _items = items;
          _isLoading = false;
        });

        await _saveCachedCategories(items);

        return;
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(
        'Categories fetch error => $e',
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

  // ============================================================
  // EXTRACT LIST
  // ============================================================

  List<dynamic> _extractList(dynamic decoded) {
    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map<String, dynamic>) {
      final results = decoded['results'];

      if (results is List) {
        return results;
      }

      final data = decoded['data'];

      if (data is List) {
        return data;
      }

      final items = decoded['items'];

      if (items is List) {
        return items;
      }
    }

    return const [];
  }

  // ============================================================
  // RESTORE CACHE
  // ============================================================

  Future<bool> _restoreCachedCategories() async {
    final cached = await _loadCachedCategories();

    if (!mounted || cached.isEmpty) {
      return false;
    }

    setState(() {
      _items = cached;
      _isLoading = false;
    });

    return true;
  }

  // ============================================================
  // LOAD CACHE
  // ============================================================

  Future<List<_MedicalAccessoryItem>>
      _loadCachedCategories() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      final cachedJson =
          prefs.getString(_cacheKey);

      if (cachedJson == null ||
          cachedJson.isEmpty) {
        return [];
      }

      final decoded =
          jsonDecode(cachedJson);

      if (decoded is! List) {
        return [];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map((m) {
        try {
          final id = (m['id'] ?? 0) is int
              ? m['id'] as int
              : int.tryParse(
                    (m['id'] ?? '0').toString(),
                  ) ??
                  0;

          final nameEn =
              (m['name_en'] ??
                      m['name'] ??
                      '')
                  .toString();

          final nameBn =
              (m['name_bn'] ?? '').toString();

          final image =
              (m['imageUrl'] ?? '').toString();

          // ------------------------------------------------------
          // DETAILS FROM CACHE
          // ------------------------------------------------------

          final details =
              m['details']?.toString();

          final detailsEn =
              m['detailsEn']?.toString();

          final detailsBn =
              m['detailsBn']?.toString();

          return _MedicalAccessoryItem(
            id: id,
            nameEn: nameEn,
            nameBn: nameBn,
            imageUrl: image,

            details: details,
            detailsEn: detailsEn,
            detailsBn: detailsBn,
          );
        } catch (e) {
          debugPrint(
            'Medical accessories cache item parse error => $e',
          );

          return null;
        }
      })
          .whereType<_MedicalAccessoryItem>()
          .where(
            (item) => item.name.isNotEmpty,
          )
          .toList();
    } catch (e) {
      debugPrint(
        'Medical accessories cache read error => $e',
      );

      return [];
    }
  }

  // ============================================================
  // SAVE CACHE
  // ============================================================

  Future<void> _saveCachedCategories(
    List<_MedicalAccessoryItem> items,
  ) async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      final encoded = jsonEncode(
        items
            .map(
              (e) => {
                'id': e.id,

                'name_en': e.nameEn,

                'name_bn': e.nameBn,

                'imageUrl': e.imageUrl,

                // IMPORTANT
                'details': e.details,

                'detailsEn': e.detailsEn,

                'detailsBn': e.detailsBn,
              },
            )
            .toList(),
      );

      await prefs.setString(
        _cacheKey,
        encoded,
      );
    } catch (e) {
      debugPrint(
        'Medical accessories cache write error => $e',
      );
    }
  }

  // ============================================================
  // GO TO DETAILS
  // ============================================================

  void _goToDetails(
    _MedicalAccessoryItem item,
  ) {
    Get.to(
      () => MedicalAccessoryProductDetailsView(
        categoryName: item.name,
        categoryImage: item.imageUrl,

        // IMPORTANT
        details: item.details,
        detailsEn: item.detailsEn,
        detailsBn: item.detailsBn,
      ),
    );
  }

  // ============================================================
  // GO TO ALL
  // ============================================================

  void _goToAllMedicalAccessories() {
    Get.to(
      () => AllMedicalAccessoriesView(
        items: _items,
        onItemTap: _goToDetails,
      ),
    );
  }

  // ============================================================
  // ACCESSORY ITEM
  // ============================================================

  Widget _buildAccessoryItem(
    _MedicalAccessoryItem item,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _goToDetails(item),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: item.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.contain,
                    errorWidget:
                        (_, __, ___) =>
                            const Icon(
                      Icons.image_not_supported,
                      size: 26,
                      color: Colors.black26,
                    ),
                  )
                : const Icon(
                    Icons.image_not_supported,
                    size: 26,
                    color: Colors.black26,
                  ),
          ),

          const SizedBox(height: 8),

          Text(
            item.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final visibleItems =
        _items.take(8).toList();

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        // ========================================================
        // HEADER
        // ========================================================

        Row(
          children: [
            Expanded(
              child: Text(
                'medical_accessories'.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),

            InkWell(
              borderRadius:
                  BorderRadius.circular(18),
              onTap:
                  _goToAllMedicalAccessories,
              child: const Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          Color(0xFF2F6FED),
                    ),
                  ),

                  SizedBox(width: 4),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color:
                        Color(0xFF2F6FED),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // ========================================================
        // CONTENT
        // ========================================================

        _isLoading && _items.isEmpty
            ? const SizedBox(
                height: 120,
                child: Center(
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              )
            : _items.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No categories found',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Colors.black54,
                        ),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount:
                        visibleItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder:
                        (context, index) {
                      return _buildAccessoryItem(
                        visibleItems[index],
                      );
                    },
                  ),
      ],
    );
  }
}

// ============================================================
// ALL MEDICAL ACCESSORIES VIEW
// ============================================================

class AllMedicalAccessoriesView
    extends StatelessWidget {
  final List<_MedicalAccessoryItem> items;

  final void Function(
    _MedicalAccessoryItem item,
  ) onItemTap;

  const AllMedicalAccessoriesView({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Accessories',
        ),
        centerTitle: true,
      ),

      body: items.isEmpty
          ? const Center(
              child: Text(
                'No categories found',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            )
          : GridView.builder(
              padding:
                  const EdgeInsets.all(16),
              itemCount: items.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              itemBuilder:
                  (context, index) {
                final item =
                    items[index];

                return InkWell(
                  borderRadius:
                      BorderRadius.circular(12),
                  onTap: () =>
                      onItemTap(item),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 46,
                        width: 46,
                        child: item.imageUrl
                                .isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    item.imageUrl,
                                fit: BoxFit.contain,
                                errorWidget:
                                    (_, __, ___) =>
                                        const Icon(
                                  Icons
                                      .image_not_supported,
                                  size: 26,
                                  color:
                                      Colors.black26,
                                ),
                              )
                            : const Icon(
                                Icons
                                    .image_not_supported,
                                size: 26,
                                color:
                                    Colors.black26,
                              ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        item.name,
                        textAlign:
                            TextAlign.center,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 10,
                          height: 1.2,
                          fontWeight:
                              FontWeight.w800,
                          color:
                              Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// ============================================================
// MEDICAL ACCESSORY ITEM
// ============================================================

class _MedicalAccessoryItem {
  final int id;

  final String nameEn;
  final String nameBn;

  final String imageUrl;

  // ============================================================
  // DETAILS
  // ============================================================

  final String? details;
  final String? detailsEn;
  final String? detailsBn;

  _MedicalAccessoryItem({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.imageUrl,

    this.details,
    this.detailsEn,
    this.detailsBn,
  });

  // ============================================================
  // LOCALIZED NAME
  // ============================================================

  String localizedName(Locale? locale) {
    final lang =
        locale?.languageCode ?? 'en';

    if (lang == 'bn' &&
        nameBn.trim().isNotEmpty) {
      return nameBn.trim();
    }

    return nameEn.trim();
  }

  String get name =>
      localizedName(Get.locale);
}