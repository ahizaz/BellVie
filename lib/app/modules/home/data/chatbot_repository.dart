abstract class ChatbotRepository {
  Future<String> sendMessage(String message);
}

class DemoChatbotRepository implements ChatbotRepository {
  @override
  Future<String> sendMessage(String message) async {
    // Demo API delay
    await Future.delayed(const Duration(milliseconds: 900));

    final text = message.toLowerCase().trim();
    final isBangla = RegExp(r'[\u0980-\u09FF]').hasMatch(message);

    bool containsAny(List<String> words) {
      return words.any(text.contains);
    }

    if (containsAny([
      'emergency',
      'জরুরি',
      'হটলাইন',
      'hotline',
      'help',
      'সাহায্য',
    ])) {
      return isBangla
          ? 'জরুরি সহায়তার জন্য আমাদের হটলাইন 01805-464392 নম্বরে যোগাযোগ করুন।'
          : 'For emergency assistance, please contact our hotline at 01805-464392.';
    }

    if (containsAny([
      'doctor',
      'appointment',
      'ডাক্তার',
      'অ্যাপয়েন্টমেন্ট',
    ])) {
      return isBangla
          ? 'ডাক্তার অ্যাপয়েন্টমেন্টের জন্য Home Page থেকে Doctor Appointments অপশনে ক্লিক করুন।'
          : 'To book a doctor, select Doctor Appointments from the Home Page.';
    }

    if (containsAny([
      'package',
      'প্যাকেজ',
      'premium',
      'freemium',
      'probashi',
      'প্রবাসী',
    ])) {
      return isBangla
          ? 'BelleVie-তে Freemium, Premium এবং Probashi Package রয়েছে। Home Page-এর Health Protection Plan থেকে বিস্তারিত দেখতে পারবেন।'
          : 'BelleVie offers Freemium, Premium and Probashi packages. You can view details from Health Protection Plan.';
    }

    if (containsAny([
      'hospital',
      'হাসপাতাল',
      'partner',
      'discount',
      'ডিসকাউন্ট',
    ])) {
      return isBangla
          ? 'আপনি National এবং International partner hospital-এর তথ্য ও discount সুবিধা অ্যাপ থেকে দেখতে পারবেন।'
          : 'You can view National and International partner hospitals and their discount facilities from the app.';
    }

    if (containsAny([
      'hello',
      'hi',
      'hey',
      'হ্যালো',
      'আসসালামু',
    ])) {
      return isBangla
          ? 'হ্যালো! আমি BelleVie Assistant। কীভাবে আপনাকে সাহায্য করতে পারি?'
          : 'Hello! I am BelleVie Assistant. How can I help you?';
    }

    return isBangla
        ? 'আপনার প্রশ্নটি পেয়েছি। খুব শিগগিরই আমি BelleVie-এর বিস্তারিত তথ্য দিয়ে সাহায্য করতে পারব।'
        : 'I received your question. I will help you with more detailed BelleVie information soon.';
  }
}