import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/chatbot_repository.dart';
import '../models/chat_message.dart';

class ChatbotController extends GetxController {
  ChatbotController(this._chatbotRepository);

  final ChatbotRepository _chatbotRepository;

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxBool isTyping = false.obs;
  final RxBool isListening = false.obs;
  final RxBool voiceReplyEnabled = true.obs;

  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  bool _speechInitialized = false;
  bool _speechAvailable = false;

  @override
  void onInit() {
    super.onInit();

    _configureTextToSpeech();

    messages.add(
      ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        message:
            'স্বাগতম! আমি BelleVie Assistant। স্বাস্থ্যসেবা, ডাক্তার, হাসপাতাল অথবা প্যাকেজ সম্পর্কে প্রশ্ন করুন।',
        sender: ChatSender.bot,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _configureTextToSpeech() async {
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setSpeechRate(0.45);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
  }

  Future<bool> _initializeSpeech() async {
    if (_speechInitialized) {
      return _speechAvailable;
    }

    _speechInitialized = true;

    try {
      _speechAvailable = await _speechToText.initialize(
        onStatus: (status) {
          isListening.value = status.toLowerCase() == 'listening';
        },
        onError: (error) {
          isListening.value = false;

          debugPrint(
            'Speech recognition error: ${error.errorMsg}',
          );
        },
      );

      return _speechAvailable;
    } catch (error) {
      debugPrint('Speech initialization error: $error');
      _speechAvailable = false;
      return false;
    }
  }

  Future<String?> _getPreferredVoiceLocale() async {
    try {
      final locales = await _speechToText.locales();

      final languageCode =
          Get.locale?.languageCode.toLowerCase() ?? 'en';

      for (final locale in locales) {
        final localeId = locale.localeId
            .replaceAll('-', '_')
            .toLowerCase();

        if (localeId == languageCode ||
            localeId.startsWith('${languageCode}_')) {
          return locale.localeId;
        }
      }
    } catch (error) {
      debugPrint('Voice locale error: $error');
    }

    // null হলে device-এর default language ব্যবহার হবে
    return null;
  }

  Future<void> toggleListening() async {
    if (isListening.value) {
      await stopListening();
      return;
    }

    // Bot কথা বললে আগে বন্ধ হবে
    await _flutterTts.stop();

    final available = await _initializeSpeech();

    if (!available) {
      Get.snackbar(
        'Microphone unavailable',
        'Please allow microphone permission from device settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
      return;
    }

    final localeId = await _getPreferredVoiceLocale();

    try {
      isListening.value = true;

      await _speechToText.listen(
        onResult: (result) {
          final recognizedText = result.recognizedWords.trim();

          if (recognizedText.isNotEmpty) {
            messageController.value = TextEditingValue(
              text: recognizedText,
              selection: TextSelection.collapsed(
                offset: recognizedText.length,
              ),
            );
          }

          if (result.finalResult) {
            isListening.value = false;
          }
        },
        listenOptions: stt.SpeechListenOptions(
          localeId: localeId,
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 3),
          partialResults: true,
          cancelOnError: true,
          autoPunctuation: true,
          listenMode: stt.ListenMode.dictation,
        ),
      );
    } catch (error) {
      isListening.value = false;

      Get.snackbar(
        'Voice input failed',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );

      debugPrint('Speech listening error: $error');
    }
  }

  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }

    isListening.value = false;
  }

  Future<void> sendMessage([String? quickMessage]) async {
    if (isTyping.value) return;

    final text = (quickMessage ?? messageController.text).trim();

    if (text.isEmpty) return;

    await stopListening();

    messageController.clear();

    messages.add(
      ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        message: text,
        sender: ChatSender.user,
        createdAt: DateTime.now(),
      ),
    );

    isTyping.value = true;
    _scrollToBottom();

    try {
      final botReply = await _chatbotRepository.sendMessage(text);

      messages.add(
        ChatMessage(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          message: botReply,
          sender: ChatSender.bot,
          createdAt: DateTime.now(),
        ),
      );

      isTyping.value = false;
      _scrollToBottom();

      if (voiceReplyEnabled.value) {
        await _speak(botReply);
      }
    } catch (error) {
      messages.add(
        ChatMessage(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          message:
              'দুঃখিত, এই মুহূর্তে উত্তর দেওয়া সম্ভব হচ্ছে না। আবার চেষ্টা করুন।',
          sender: ChatSender.bot,
          createdAt: DateTime.now(),
        ),
      );

      isTyping.value = false;
      _scrollToBottom();

      debugPrint('Chatbot error: $error');
    }
  }

  Future<void> _speak(String message) async {
    final isBangla = RegExp(r'[\u0980-\u09FF]').hasMatch(message);

    await _flutterTts.stop();
    await _flutterTts.setLanguage(isBangla ? 'bn-BD' : 'en-US');
    await _flutterTts.speak(message);
  }

  Future<void> toggleVoiceReply() async {
    voiceReplyEnabled.toggle();

    if (!voiceReplyEnabled.value) {
      await _flutterTts.stop();
    }
  }

  Future<void> stopAudio() async {
    await stopListening();
    await _flutterTts.stop();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onClose() {
    _speechToText.cancel();
    _flutterTts.stop();
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}