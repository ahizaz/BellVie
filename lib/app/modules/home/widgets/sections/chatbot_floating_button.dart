

// import 'package:bellevie/app/modules/home/controllers/chatbot_Controller.dart';
// import 'package:bellevie/app/modules/home/data/chatbot_repository.dart';
// import 'package:bellevie/app/modules/home/models/chat_message.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class ChatbotFloatingOverlay extends StatelessWidget {
//   final Widget child;
//   final bool show;

//   const ChatbotFloatingOverlay({
//     super.key,
//     required this.child,
//     this.show = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         child,

//         if (show)
//           const Positioned(
//             right: 14,
//             bottom: 14,
//             child: ChatbotFloatingButton(),
//           ),
//       ],
//     );
//   }
// }

// class ChatbotFloatingButton extends StatelessWidget {
//   const ChatbotFloatingButton({super.key});

//   ChatbotController _findOrCreateController() {
//     if (!Get.isRegistered<ChatbotRepository>()) {
//       Get.put<ChatbotRepository>(
//         DemoChatbotRepository(),
//       );
//     }

//     if (!Get.isRegistered<ChatbotController>()) {
//       Get.put<ChatbotController>(
//         ChatbotController(
//           Get.find<ChatbotRepository>(),
//         ),
//       );
//     }

//     return Get.find<ChatbotController>();
//   }

//   Future<void> _openChatbot(BuildContext context) async {
//     final controller = _findOrCreateController();

//     // Get.bottomSheet ব্যবহার করা হয়নি।
//     // Fixed dialog ব্যবহার করা হয়েছে।
//     await showGeneralDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Close BelleVie Assistant',
//       barrierColor: Colors.black.withValues(alpha: 0.45),
//       transitionDuration: const Duration(milliseconds: 250),
//       pageBuilder: (
//         context,
//         animation,
//         secondaryAnimation,
//       ) {
//         return _FixedChatbotDialog(
//           controller: controller,
//         );
//       },
//       transitionBuilder: (
//         context,
//         animation,
//         secondaryAnimation,
//         child,
//       ) {
//         return FadeTransition(
//           opacity: CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOut,
//           ),
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Tooltip(
//       message: 'BelleVie Assistant',
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
//                 _openChatbot(context);
//               },
//               borderRadius: BorderRadius.circular(32),
//               child: Ink(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFF2F6FED),
//                       Color(0xFF02B89D),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF2F6FED)
//                           .withValues(alpha: 0.35),
//                       blurRadius: 14,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.smart_toy_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),

//           // Online indicator
//           Positioned(
//             right: 1,
//             top: 1,
//             child: Container(
//               width: 14,
//               height: 14,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF37D67A),
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FixedChatbotDialog extends StatefulWidget {
//   final ChatbotController controller;

//   const _FixedChatbotDialog({
//     required this.controller,
//   });

//   @override
//   State<_FixedChatbotDialog> createState() =>
//       _FixedChatbotDialogState();
// }

// class _FixedChatbotDialogState
//     extends State<_FixedChatbotDialog> {
//   double? _fixedSheetHeight;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Chatbot প্রথমবার open হওয়ার সময় height save হবে।
//     // Keyboard open হলেও এই height আর change হবে না।
//     _fixedSheetHeight ??=
//         MediaQuery.of(context).size.height * 0.76;
//   }

//   @override
//   void dispose() {
//     widget.controller.stopAudio();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     final keyboardHeight = mediaQuery.viewInsets.bottom;

//     return Scaffold(
//       backgroundColor: Colors.transparent,

//       // Keyboard আসলে পুরো screen resize হবে না
//       resizeToAvoidBottomInset: false,

//       body: Stack(
//         children: [
//           // Chatbot-এর বাইরে tap করলে close হবে
//           Positioned.fill(
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//                 Navigator.of(context).pop();
//               },
//               child: const SizedBox.expand(),
//             ),
//           ),

//           // Chatbot সবসময় একই জায়গায় থাকবে
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               width: double.infinity,
//               height: _fixedSheetHeight,
//               child: ChatbotSheet(
//                 controller: widget.controller,
//                 keyboardHeight: keyboardHeight,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatbotSheet extends StatelessWidget {
//   final ChatbotController controller;
//   final double keyboardHeight;

//   const ChatbotSheet({
//     super.key,
//     required this.controller,
//     required this.keyboardHeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xFFF4F7FB),
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(28),
//         ),
//       ),
//       clipBehavior: Clip.antiAlias,

//       // শুধু ভেতরের content keyboard অনুযায়ী adjust হবে।
//       // পুরো chatbot আর উপরে উঠবে না।
//       child: AnimatedPadding(
//         duration: const Duration(milliseconds: 180),
//         curve: Curves.easeOut,
//         padding: EdgeInsets.only(
//           bottom: keyboardHeight,
//         ),
//         child: Column(
//           children: [
//             _ChatHeader(
//               controller: controller,
//             ),

//             Expanded(
//               child: _MessageList(
//                 controller: controller,
//               ),
//             ),

//             _QuickQuestions(
//               controller: controller,
//             ),

//             Obx(
//               () => controller.isListening.value
//                   ? Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 7,
//                       ),
//                       color: const Color(0xFFFFEBEE),
//                       child: const Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.graphic_eq_rounded,
//                             size: 18,
//                             color: Colors.red,
//                           ),
//                           SizedBox(width: 6),
//                           Text(
//                             'Listening... এখন কথা বলুন',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//             ),

//             _MessageComposer(
//               controller: controller,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ChatHeader extends StatelessWidget {
//   final ChatbotController controller;

//   const _ChatHeader({
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xFF2F6FED),
//             Color(0xFF06AFA0),
//           ],
//         ),
//       ),
//       child: Row(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               const CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Colors.white,
//                 child: Icon(
//                   Icons.smart_toy_rounded,
//                   color: Color(0xFF2F6FED),
//                   size: 27,
//                 ),
//               ),
//               Positioned(
//                 right: -1,
//                 bottom: 1,
//                 child: Container(
//                   width: 12,
//                   height: 12,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF37D67A),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'BelleVie Assistant',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'Online • সাধারণত সাথে সাথে উত্তর দেয়',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 11.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Obx(
//             () => IconButton(
//               tooltip: 'Voice reply',
//               onPressed: controller.toggleVoiceReply,
//               icon: Icon(
//                 controller.voiceReplyEnabled.value
//                     ? Icons.volume_up_rounded
//                     : Icons.volume_off_rounded,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           IconButton(
//             tooltip: 'Close',
//             onPressed: () {
//               controller.stopAudio();
//               FocusScope.of(context).unfocus();
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               Icons.close_rounded,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MessageList extends StatelessWidget {
//   final ChatbotController controller;

//   const _MessageList({
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final messageCount = controller.messages.length;
//       final showTyping = controller.isTyping.value;

//       return ListView.builder(
//         controller: controller.scrollController,
//         keyboardDismissBehavior:
//             ScrollViewKeyboardDismissBehavior.onDrag,
//         padding: const EdgeInsets.fromLTRB(
//           12,
//           16,
//           12,
//           10,
//         ),
//         itemCount: messageCount + (showTyping ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (showTyping && index == messageCount) {
//             return const _TypingBubble();
//           }

//           return _MessageBubble(
//             message: controller.messages[index],
//           );
//         },
//       );
//     });
//   }
// }

// class _MessageBubble extends StatelessWidget {
//   final ChatMessage message;

//   const _MessageBubble({
//     required this.message,
//   });

//   String _formatTime(DateTime dateTime) {
//     final hour = dateTime.hour.toString().padLeft(2, '0');
//     final minute = dateTime.minute.toString().padLeft(2, '0');

//     return '$hour:$minute';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isUser = message.isUser;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         mainAxisAlignment: isUser
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (!isUser) ...[
//             const CircleAvatar(
//               radius: 15,
//               backgroundColor: Color(0xFFE1EAFF),
//               child: Icon(
//                 Icons.smart_toy_rounded,
//                 size: 17,
//                 color: Color(0xFF2F6FED),
//               ),
//             ),
//             const SizedBox(width: 7),
//           ],
//           Flexible(
//             child: Column(
//               crossAxisAlignment: isUser
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isUser
//                         ? const Color(0xFF2F6FED)
//                         : Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(17),
//                       topRight: const Radius.circular(17),
//                       bottomLeft: Radius.circular(
//                         isUser ? 17 : 4,
//                       ),
//                       bottomRight: Radius.circular(
//                         isUser ? 4 : 17,
//                       ),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(
//                           alpha: 0.06,
//                         ),
//                         blurRadius: 7,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     message.message,
//                     style: TextStyle(
//                       color: isUser
//                           ? Colors.white
//                           : const Color(0xFF263238),
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   _formatTime(message.createdAt),
//                   style: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 9.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TypingBubble extends StatelessWidget {
//   const _TypingBubble();

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 15,
//             backgroundColor: Color(0xFFE1EAFF),
//             child: Icon(
//               Icons.smart_toy_rounded,
//               size: 17,
//               color: Color(0xFF2F6FED),
//             ),
//           ),
//           SizedBox(width: 7),
//           DecoratedBox(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(16),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 11,
//               ),
//               child: Text(
//                 '•••',
//                 style: TextStyle(
//                   color: Color(0xFF2F6FED),
//                   fontSize: 16,
//                   letterSpacing: 3,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _QuickQuestions extends StatelessWidget {
//   final ChatbotController controller;

//   const _QuickQuestions({
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const questions = [
//       'জরুরি সহায়তা',
//       'ডাক্তার অ্যাপয়েন্টমেন্ট',
//       'প্যাকেজসমূহ',
//       'পার্টনার হাসপাতাল',
//     ];

//     return Container(
//       height: 48,
//       color: const Color(0xFFF4F7FB),
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 12,
//         ),
//         scrollDirection: Axis.horizontal,
//         itemCount: questions.length,
//         separatorBuilder: (_, __) {
//           return const SizedBox(width: 7);
//         },
//         itemBuilder: (context, index) {
//           return ActionChip(
//             onPressed: () {
//               controller.sendMessage(
//                 questions[index],
//               );
//             },
//             backgroundColor: const Color(0xFFE8F0FF),
//             side: BorderSide.none,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             label: Text(
//               questions[index],
//               style: const TextStyle(
//                 color: Color(0xFF2F6FED),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _MessageComposer extends StatelessWidget {
//   final ChatbotController controller;

//   const _MessageComposer({
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(
//           10,
//           8,
//           10,
//           10,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.06),
//               blurRadius: 12,
//               offset: const Offset(0, -3),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Expanded(
//               child: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 48,
//                   maxHeight: 110,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF2F5F9),
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: TextField(
//                   controller: controller.messageController,
//                   minLines: 1,
//                   maxLines: 4,
//                   textInputAction: TextInputAction.send,
//                   onSubmitted: (_) {
//                     controller.sendMessage();
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'আপনার প্রশ্ন লিখুন...',
//                     hintStyle: TextStyle(
//                       color: Colors.black38,
//                       fontSize: 14,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 13,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 7),
//             Obx(
//               () => AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   color: controller.isListening.value
//                       ? const Color(0xFFFFE5E8)
//                       : const Color(0xFFE8F0FF),
//                   shape: BoxShape.circle,
//                 ),
//                 child: IconButton(
//                   tooltip: 'Voice message',
//                   onPressed: controller.toggleListening,
//                   icon: Icon(
//                     controller.isListening.value
//                         ? Icons.stop_rounded
//                         : Icons.mic_rounded,
//                     color: controller.isListening.value
//                         ? Colors.red
//                         : const Color(0xFF2F6FED),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 7),
//             Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF2F6FED),
//                     Color(0xFF06AFA0),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 tooltip: 'Send',
//                 onPressed: () {
//                   controller.sendMessage();
//                 },
//                 icon: const Icon(
//                   Icons.send_rounded,
//                   color: Colors.white,
//                   size: 21,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:bellevie/app/modules/home/controllers/chatbot_Controller.dart';
import 'package:bellevie/app/modules/home/data/chatbot_repository.dart';
import 'package:bellevie/app/modules/home/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChatbotFloatingOverlay
    extends StatelessWidget {
  final Widget child;
  final bool show;

  const ChatbotFloatingOverlay({
    super.key,
    required this.child,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,

        if (show)
          const Positioned(
            right: 14,
            bottom: 14,
            child: ChatbotFloatingButton(),
          ),
      ],
    );
  }
}

class ChatbotFloatingButton
    extends StatelessWidget {
  const ChatbotFloatingButton({super.key});

  ChatbotController
      _findOrCreateController() {
    if (!Get.isRegistered<
        ChatbotRepository>()) {
      Get.put<ChatbotRepository>(
        DemoChatbotRepository(),
      );
    }

    if (!Get.isRegistered<
        ChatbotController>()) {
      Get.put<ChatbotController>(
        ChatbotController(
          Get.find<ChatbotRepository>(),
        ),
      );
    }

    return Get.find<ChatbotController>();
  }

  Future<void> _openChatbot(
    BuildContext context,
  ) async {
    final controller =
        _findOrCreateController();

    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel:
          'Close BelleVie Assistant',
      barrierColor: Colors.black
          .withValues(alpha: 0.45),
      transitionDuration:
          const Duration(milliseconds: 250),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return _FixedChatbotDialog(
          controller: controller,
        );
      },
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'BelleVie Assistant',
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _openChatbot(context);
              },
              borderRadius:
                  BorderRadius.circular(32),
              child: Ink(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFF2F6FED),
                      Color(0xFF02B89D),
                    ],
                    begin:
                        Alignment.topLeft,
                    end:
                        Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF2F6FED,
                      ).withValues(
                        alpha: 0.35,
                      ),
                      blurRadius: 14,
                      offset:
                          const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color:
                    const Color(0xFF37D67A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FixedChatbotDialog
    extends StatefulWidget {
  final ChatbotController controller;

  const _FixedChatbotDialog({
    required this.controller,
  });

  @override
  State<_FixedChatbotDialog> createState() =>
      _FixedChatbotDialogState();
}

class _FixedChatbotDialogState
    extends State<_FixedChatbotDialog>
    with WidgetsBindingObserver {
  double? _fixedSheetHeight;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Keyboard আসার আগের height save করবে
    _fixedSheetHeight ??=
        MediaQuery.of(context).size.height *
            0.76;
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // Keyboard open/close হলে
    // latest message visible রাখবে
    widget.controller.scrollToLatest();
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this);

    widget.controller.stopAudio();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery =
        MediaQuery.of(context);

    final keyboardHeight =
        mediaQuery.viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,

      // Keyboard open হলেও dialog move করবে না
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior:
                  HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context)
                    .unfocus();

                Navigator.of(context).pop();
              },
              child:
                  const SizedBox.expand(),
            ),
          ),
          Align(
            alignment:
                Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: _fixedSheetHeight,
              child: ChatbotSheet(
                controller:
                    widget.controller,
                keyboardHeight:
                    keyboardHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatbotSheet extends StatelessWidget {
  final ChatbotController controller;
  final double keyboardHeight;

  const ChatbotSheet({
    super.key,
    required this.controller,
    required this.keyboardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF4F7FB),
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: AnimatedPadding(
        duration:
            const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: keyboardHeight,
        ),
        child: Column(
          children: [
            _ChatHeader(
              controller: controller,
            ),
            Expanded(
              child: _MessageList(
                controller: controller,
              ),
            ),
            _QuickQuestions(
              controller: controller,
            ),
            Obx(
              () => controller
                      .isListening.value
                  ? Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 7,
                      ),
                      color: const Color(
                        0xFFFFEBEE,
                      ),
                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Icon(
                            Icons
                                .graphic_eq_rounded,
                            size: 18,
                            color:
                                Colors.red,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Listening... এখন কথা বলুন',
                            style:
                                TextStyle(
                              color:
                                  Colors.red,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            _MessageComposer(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final ChatbotController controller;

  const _ChatHeader({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
        16,
        12,
        8,
        12,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2F6FED),
            Color(0xFF06AFA0),
          ],
        ),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor:
                    Colors.white,
                child: Icon(
                  Icons.smart_toy_rounded,
                  color:
                      Color(0xFF2F6FED),
                  size: 27,
                ),
              ),
              Positioned(
                right: -1,
                bottom: 1,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration:
                      BoxDecoration(
                    color: const Color(
                      0xFF37D67A,
                    ),
                    shape:
                        BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'BelleVie Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Online • সাধারণত সাথে সাথে উত্তর দেয়',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => IconButton(
              tooltip: 'Voice reply',
              onPressed:
                  controller.toggleVoiceReply,
              icon: Icon(
                controller
                        .voiceReplyEnabled
                        .value
                    ? Icons.volume_up_rounded
                    : Icons
                        .volume_off_rounded,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () {
              controller.stopAudio();

              FocusScope.of(context)
                  .unfocus();

              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageList
    extends StatelessWidget {
  final ChatbotController controller;

  const _MessageList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messageCount =
          controller.messages.length;

      final showTyping =
          controller.isTyping.value;

      final totalItems =
          messageCount +
              (showTyping ? 1 : 0);

      return ListView.builder(
        controller:
            controller.scrollController,

        // Latest message নিচে থাকবে
        reverse: true,

        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag,

        padding:
            const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          16,
        ),

        itemCount: totalItems,

        itemBuilder: (context, index) {
          // Typing bubble সবার নিচে
          if (showTyping && index == 0) {
            return const _TypingBubble();
          }

          final messageIndex =
              showTyping
                  ? messageCount - index
                  : messageCount -
                      1 -
                      index;

          if (messageIndex < 0 ||
              messageIndex >=
                  messageCount) {
            return const SizedBox.shrink();
          }

          return _MessageBubble(
            message: controller
                .messages[messageIndex],
          );
        },
      );
    });
  }
}

class _MessageBubble
    extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({
    required this.message,
  });

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour
        .toString()
        .padLeft(2, '0');

    final minute = dateTime.minute
        .toString()
        .padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 15,
              backgroundColor:
                  Color(0xFFE1EAFF),
              child: Icon(
                Icons.smart_toy_rounded,
                size: 17,
                color:
                    Color(0xFF2F6FED),
              ),
            ),
            const SizedBox(width: 7),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets
                      .symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration:
                      BoxDecoration(
                    color: isUser
                        ? const Color(
                            0xFF2F6FED,
                          )
                        : Colors.white,
                    borderRadius:
                        BorderRadius.only(
                      topLeft:
                          const Radius
                              .circular(17),
                      topRight:
                          const Radius
                              .circular(17),
                      bottomLeft:
                          Radius.circular(
                        isUser ? 17 : 4,
                      ),
                      bottomRight:
                          Radius.circular(
                        isUser ? 4 : 17,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                          alpha: 0.06,
                        ),
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      color: isUser
                          ? Colors.white
                          : const Color(
                              0xFF263238,
                            ),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _formatTime(
                    message.createdAt,
                  ),
                  style:
                      const TextStyle(
                    color: Colors.black38,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingBubble
    extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor:
                Color(0xFFE1EAFF),
            child: Icon(
              Icons.smart_toy_rounded,
              size: 17,
              color: Color(0xFF2F6FED),
            ),
          ),
          SizedBox(width: 7),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              child: Text(
                '•••',
                style: TextStyle(
                  color:
                      Color(0xFF2F6FED),
                  fontSize: 16,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickQuestions
    extends StatelessWidget {
  final ChatbotController controller;

  const _QuickQuestions({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const questions = [
      'জরুরি সহায়তা',
      'ডাক্তার অ্যাপয়েন্টমেন্ট',
      'প্যাকেজসমূহ',
      'পার্টনার হাসপাতাল',
    ];

    return Container(
      height: 48,
      color: const Color(0xFFF4F7FB),
      child: ListView.separated(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        scrollDirection:
            Axis.horizontal,
        itemCount: questions.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 7);
        },
        itemBuilder: (context, index) {
          return ActionChip(
            onPressed: () {
              controller.sendMessage(
                questions[index],
              );
            },
            backgroundColor:
                const Color(0xFFE8F0FF),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),
            label: Text(
              questions[index],
              style: const TextStyle(
                color:
                    Color(0xFF2F6FED),
                fontSize: 12,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MessageComposer
    extends StatelessWidget {
  final ChatbotController controller;

  const _MessageComposer({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          10,
          8,
          10,
          10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withValues(alpha: 0.06),
              blurRadius: 12,
              offset:
                  const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints:
                    const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 110,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF2F5F9,
                  ),
                  borderRadius:
                      BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: controller
                      .messageController,
                  minLines: 1,
                  maxLines: 4,
                  keyboardType:
                      TextInputType.text,
                  textInputAction:
                      TextInputAction.send,

                  // Keyboard open হলে
                  // latest message দেখাবে
                  onTap:
                      controller.scrollToLatest,

                  onSubmitted: (_) {
                    controller.sendMessage();
                  },
                  decoration:
                      const InputDecoration(
                    hintText:
                        'আপনার প্রশ্ন লিখুন...',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 7),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                decoration: BoxDecoration(
                  color: controller
                          .isListening.value
                      ? const Color(
                          0xFFFFE5E8,
                        )
                      : const Color(
                          0xFFE8F0FF,
                        ),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  tooltip: 'Voice message',
                  onPressed:
                      controller.toggleListening,
                  icon: Icon(
                    controller
                            .isListening.value
                        ? Icons.stop_rounded
                        : Icons.mic_rounded,
                    color: controller
                            .isListening.value
                        ? Colors.red
                        : const Color(
                            0xFF2F6FED,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 7),
            Container(
              decoration:
                  const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F6FED),
                    Color(0xFF06AFA0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                tooltip: 'Send',
                onPressed: () {
                  controller.sendMessage();
                },
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}