import 'package:bellevie/app/modules/home/controllers/doctor_follow_controller.dart';
import 'package:bellevie/app/modules/home/models/doctor_follow_up_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get/get.dart';



class DoctorFollowupView
    extends GetView<DoctorFollowupController> {
  const DoctorFollowupView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DoctorFollowupController>()) {
      Get.put(DoctorFollowupController());
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F7FB),

      // ==========================
      // APP BAR
      // ==========================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF7F7FB),
        foregroundColor: Colors.black,
        centerTitle: true,

        title: const Text(
          'Doctor Follow-up',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ==========================
      // BODY
      // ==========================

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        }

        if (controller.followups.isEmpty) {
          return _emptyState();
        }

        return RefreshIndicator(
          color: Colors.deepPurple,
          onRefresh: controller.fetchDoctorFollowups,

          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),

            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              30,
            ),

            itemCount: controller.followups.length,

            itemBuilder: (context, index) {
              final followup =
                  controller.followups[index];

              return _followupCard(
                context,
                followup,
              );
            },
          ),
        );
      }),
    );
  }

  // ==========================================================
  // FOLLOW-UP CARD
  // ==========================================================

  Widget _followupCard(
    BuildContext context,
    DoctorFollowupModel followup,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        _showFollowupDetails(
          context,
          followup,
        );
      },

      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: .04,
              ),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==========================
              // HEADER
              // ==========================

              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,

                    decoration: BoxDecoration(
                      color: Colors.deepPurple
                          .withValues(alpha: .08),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons
                          .medical_services_outlined,
                      color: Colors.deepPurple,
                      size: 25,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Doctor Follow-up',

                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Follow-up #${followup.id}',

                          style: TextStyle(
                            fontSize: 13,
                            color:
                                Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.green
                          .withValues(alpha: .10),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: const Text(
                      'Follow-up',

                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ==========================
              // DOCTOR
              // ==========================

              _doctorBox(followup),

              const SizedBox(height: 14),

              // ==========================
              // DATE + TIME
              // ==========================

              Row(
                children: [
                  Expanded(
                    child: _infoBox(
                      icon: Icons
                          .calendar_today_outlined,

                      title: 'Follow-up Date',

                      value: _formatDate(
                        followup.followupDate,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _infoBox(
                      icon: Icons.access_time,

                      title: 'Follow-up Time',

                      value: _formatTime(
                        followup.followupTime,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ==========================
              // TREATMENT PREVIEW
              // ==========================

              if (followup
                  .treatmentDetails
                  .isNotEmpty)
                _previewSection(
                  title: 'Treatment Details',
                  icon: Icons
                      .medication_outlined,
                  text: followup
                      .treatmentDetails,
                ),

              // ==========================
              // NOTES PREVIEW
              // ==========================

              if (followup.notes.isNotEmpty) ...[
                const SizedBox(height: 12),

                _previewSection(
                  title: 'Doctor\'s Notes',
                  icon: Icons.notes_outlined,
                  text: followup.notes,
                ),
              ],

              const SizedBox(height: 14),

              // ==========================
              // VIEW DETAILS
              // ==========================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 4),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DOCTOR BOX
  // ==========================================================

  Widget _doctorBox(
    DoctorFollowupModel followup,
  ) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(
          alpha: .06,
        ),

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.person_outline,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Doctor',

                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  followup.doctorName.isEmpty
                      ? 'Unknown Doctor'
                      : followup.doctorName,

                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DATE / TIME BOX
  // ==========================================================

  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xffF8F7FC),

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            color: Colors.deepPurple,
            size: 20,
          ),

          const SizedBox(height: 8),

          Text(
            title,

            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PREVIEW SECTION
  // ==========================================================

  Widget _previewSection({
    required String title,
    required IconData icon,
    required String text,
  }) {
    final preview = _cleanPreview(text);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.deepPurple,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                title,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            preview,

            maxLines: 3,
            overflow:
                TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DETAILS BOTTOM SHEET
  // ==========================================================

  void _showFollowupDetails(
    BuildContext context,
    DoctorFollowupModel followup,
  ) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height *
                  .90,
        ),

        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20,
        ),

        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),

        child: Column(
          children: [
            // ==========================
            // HANDLE
            // ==========================

            Container(
              width: 45,
              height: 5,

              decoration: BoxDecoration(
                color: Colors.grey.shade300,

                borderRadius:
                    BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 18),

            // ==========================
            // TITLE
            // ==========================

            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,

                  decoration: BoxDecoration(
                    color: Colors.deepPurple
                        .withValues(alpha: .08),

                    borderRadius:
                        BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons
                        .medical_services_outlined,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Doctor Follow-up',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        'Follow-up #${followup.id}',

                        style: TextStyle(
                          fontSize: 13,
                          color:
                              Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==========================
            // SCROLLABLE CONTENT
            // ==========================

            Expanded(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // Doctor
                    _doctorBox(followup),

                    const SizedBox(height: 14),

                    // Date + Time
                    Row(
                      children: [
                        Expanded(
                          child: _infoBox(
                            icon: Icons
                                .calendar_today_outlined,
                            title:
                                'Follow-up Date',
                            value: _formatDate(
                              followup
                                  .followupDate,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _infoBox(
                            icon:
                                Icons.access_time,
                            title:
                                'Follow-up Time',
                            value: _formatTime(
                              followup
                                  .followupTime,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Treatment
                    if (followup
                        .treatmentDetails
                        .isNotEmpty) ...[
                      const SizedBox(height: 18),

                      _markdownSection(
                        title:
                            'Treatment Details',
                        icon: Icons
                            .medication_outlined,
                        text: followup
                            .treatmentDetails,
                      ),
                    ],

                    // Notes
                    if (followup
                        .notes
                        .isNotEmpty) ...[
                      const SizedBox(height: 18),

                      _markdownSection(
                        title:
                            'Doctor\'s Notes',
                        icon:
                            Icons.notes_outlined,
                        text: followup.notes,
                      ),
                    ],

                    // Created at
                    if (followup
                        .createdAt
                        .isNotEmpty) ...[
                      const SizedBox(height: 18),

                      Text(
                        'Created: ${_formatCreatedAt(followup.createdAt)}',

                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Colors.grey.shade500,
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      isScrollControlled: true,
    );
  }

  // ==========================================================
  // MARKDOWN SECTION
  // ==========================================================

  Widget _markdownSection({
    required String title,
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xffFAFAFC),

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.deepPurple,
                size: 21,
              ),

              const SizedBox(width: 8),

              Text(
                title,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          MarkdownBody(
            data: text,

            shrinkWrap: true,

            styleSheet:
                MarkdownStyleSheet(
              p: const TextStyle(
                fontSize: 14,
                height: 1.6,
              ),

              h1: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.w700,
              ),

              h2: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w700,
              ),

              h3: const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.w700,
              ),

              strong: const TextStyle(
                fontWeight:
                    FontWeight.w700,
              ),

              listBullet:
                  const TextStyle(
                fontSize: 14,
              ),

              listIndent: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: Colors.deepPurple
                    .withValues(alpha: .08),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.event_note_outlined,
                size: 45,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Doctor Follow-up',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'You currently have no doctor follow-up records.',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(String date) {
    try {
      final parsed =
          DateTime.parse(date);

      return '${parsed.day.toString().padLeft(2, '0')} '
          '${_monthName(parsed.month)} '
          '${parsed.year}';
    } catch (_) {
      return date;
    }
  }

  // ==========================================================
  // TIME FORMAT
  // ==========================================================

  String _formatTime(String time) {
    try {
      final parts =
          time.split(':');

      int hour =
          int.parse(parts[0]);

      final minute = parts[1];

      final period =
          hour >= 12 ? 'PM' : 'AM';

      hour = hour % 12;

      if (hour == 0) {
        hour = 12;
      }

      return '$hour:$minute $period';
    } catch (_) {
      return time;
    }
  }

  // ==========================================================
  // CREATED AT FORMAT
  // ==========================================================

  String _formatCreatedAt(
    String value,
  ) {
    try {
      final parsed =
          DateTime.parse(value);

      final date =
          '${parsed.day.toString().padLeft(2, '0')} '
          '${_monthName(parsed.month)} '
          '${parsed.year}';

      final hour =
          parsed.hour == 0
              ? 12
              : parsed.hour > 12
                  ? parsed.hour - 12
                  : parsed.hour;

      final minute =
          parsed.minute
              .toString()
              .padLeft(2, '0');

      final period =
          parsed.hour >= 12
              ? 'PM'
              : 'AM';

      return '$date at $hour:$minute $period';
    } catch (_) {
      return value;
    }
  }

  // ==========================================================
  // MONTH
  // ==========================================================

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    if (month < 1 ||
        month > 12) {
      return '';
    }

    return months[month];
  }

  // ==========================================================
  // PREVIEW CLEANER
  // ==========================================================

  String _cleanPreview(String text) {
    var value = text;

    value = value.replaceAll(
      RegExp(r'#{1,6}\s*'),
      '',
    );

    value = value.replaceAll(
      RegExp(r'\*\*'),
      '',
    );

    value = value.replaceAll(
      RegExp(r'\*'),
      '',
    );

    value = value.replaceAll(
      RegExp(r'\r?\n+'),
      ' ',
    );

    return value.trim();
  }
}