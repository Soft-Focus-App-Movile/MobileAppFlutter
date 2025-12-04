class MoodHelper {
  static String getMoodImage(int level) {
    if (level <= 2) return 'assets/images/calendar_emoji_angry.png';
    if (level <= 4) return 'assets/images/calendar_emoji_sad.png';
    if (level <= 6) return 'assets/images/calendar_emoji_serius.png';
    if (level <= 8) return 'assets/images/calendar_emoji_happy.png';
    return 'assets/images/calendar_emoji_joy.png';
  }

  static String getMoodDescription(int level) {
    if (level <= 2) return 'Me siento terrible';
    if (level <= 4) return 'Me siento mal';
    if (level <= 6) return 'Me siento regular';
    if (level <= 8) return 'Me siento bien';
    return 'Me siento excelente';
  }

  static String getMoodImageFromEmoji(String emoji) {
    switch (emoji) {
      case '😢':
        return 'assets/images/calendar_emoji_angry.png';
      case '😕':
        return 'assets/images/calendar_emoji_sad.png';
      case '😐':
        return 'assets/images/calendar_emoji_serius.png';
      case '🙂':
        return 'assets/images/calendar_emoji_happy.png';
      case '😄':
        return 'assets/images/calendar_emoji_joy.png';
      default:
        return 'assets/images/calendar_emoji_serius.png';
    }
  }

  static String getMoodImageFromLevel(int level) {
    return getMoodImage(level);
  }
}