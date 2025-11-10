class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  static const String baseUrl = "http://98.90.172.251:5000/api/v1/";

  // Google OAuth Client IDs
  // Web Client ID - Used for serverClientId in Credential Manager and backend verification
  static const String googleWebClientId =
      "456468181765-quas8eebf9rfjg33ovhn42efqu4uqcag.apps.googleusercontent.com";

  // Android Client ID - Registered with SHA-1 fingerprint
  static const String googleAndroidClientId =
      "456468181765-c6kjl3vsdc0a7d6mqjfgg3aihnuj23tb.apps.googleusercontent.com";

  // For Credential Manager API, we use the WEB client ID as serverClientId
  static const String googleServerClientId = googleWebClientId;
}

// Auth endpoints
class AuthEndpoints {
  AuthEndpoints._();

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String registerGeneral = "auth/register/general";
  static const String registerPsychologist = "auth/register/psychologist";
  static const String socialLogin = "auth/social-login";
  static const String oauth = "auth/oauth";
  static const String oauthVerify = "auth/oauth/verify";
  static const String oauthCompleteRegistration = "auth/oauth/complete-registration";
  static const String forgotPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password";
}

// User endpoints
class UsersEndpoints {
  UsersEndpoints._();

  static const String base = "users";
  static const String profile = "users/profile";
  static const String byId = "users/{id}";
  static const String verifyPsychologist = "users/{id}/verify";
  static const String changeStatus = "users/{id}/status";
  static const String psychologistInvitationCode = "users/psychologist/invitation-code";
  static const String psychologistCompleteProfile = "users/psychologist/complete";
  static const String psychologistProfessionalData = "users/psychologist/professional";
  static const String psychologistVerification = "users/psychologist/verification";
  static const String psychologistStats = "users/psychologist/stats";

  // Public psychologist directory endpoints
  static const String psychologistsDirectory = "users/psychologists/directory";
  static const String psychologistDetail = "users/psychologists/{id}";

  static String getById(String id) => byId.replaceAll("{id}", id);
  static String verifyPsychologistById(String id) =>
      verifyPsychologist.replaceAll("{id}", id);
  static String changeStatusById(String id) =>
      changeStatus.replaceAll("{id}", id);
  static String getPsychologistDetail(String id) =>
      psychologistDetail.replaceAll("{id}", id);
}

// Therapy endpoints
class TherapyEndpoints {
  TherapyEndpoints._();

  static const String myRelationship = "therapy/my-relationship";
  static const String connect = "therapy/connect";
  static const String patients = "therapy/patients";
}

// AI endpoints
class AIEndpoints {
  AIEndpoints._();

  static const String chatMessage = "ai/chat/message";
  static const String chatUsage = "ai/chat/usage";
  static const String chatSessions = "ai/chat/sessions";
  static const String chatSessionMessages = "ai/chat/sessions/{sessionId}/messages";
  static const String emotionAnalyze = "ai/emotion/analyze";
  static const String emotionUsage = "ai/emotion/usage";

  static String getChatSessionMessages(String sessionId) =>
      chatSessionMessages.replaceAll("{sessionId}", sessionId);
}

// Tracking endpoints
class TrackingEndpoints {
  TrackingEndpoints._();

  // Check-ins
  static const String checkIns = "tracking/check-ins";
  static const String checkInById = "tracking/check-ins/{id}";
  static const String checkInToday = "tracking/check-ins/today";

  // Emotional Calendar
  static const String emotionalCalendar = "tracking/emotional-calendar";
  static const String emotionalCalendarByDate = "tracking/emotional-calendar/{date}";

  // Dashboard
  static const String dashboard = "tracking/dashboard";

  // Helper functions for dynamic parameters
  static String getCheckInById(String id) => checkInById.replaceAll("{id}", id);
  static String getEmotionalCalendarByDate(String date) =>
      emotionalCalendarByDate.replaceAll("{date}", date);
}

// Notification endpoints
class NotificationsEndpoints {
  NotificationsEndpoints._();

  static const String base = "notifications";
  static const String byUserId = "notifications/{userId}";
  static const String detail = "notifications/detail/{notificationId}";
  static const String markAsRead = "notifications/{notificationId}/read";
  static const String markAllRead = "notifications/read-all";
  static const String delete = "notifications/{notificationId}";
  static const String unreadCount = "notifications/unread-count";

  static String getByUserId(String userId) =>
      byUserId.replaceAll("{userId}", userId);
  static String getDetail(String notificationId) =>
      detail.replaceAll("{notificationId}", notificationId);
  static String markAsReadById(String notificationId) =>
      markAsRead.replaceAll("{notificationId}", notificationId);
  static String deleteById(String notificationId) =>
      delete.replaceAll("{notificationId}", notificationId);
}

// Preferences endpoints
class PreferencesEndpoints {
  PreferencesEndpoints._();

  static const String base = "preferences";
  static const String reset = "preferences/reset";
}

// Crisis endpoints
class CrisisEndpoints {
  CrisisEndpoints._();

  static const String alert = "crisis/alert";
  static const String alertsByPatient = "crisis/alerts/patient";
  static const String alertsByPsychologist = "crisis/alerts";
  static const String alertById = "crisis/alerts/{id}";
  static const String updateStatus = "crisis/alerts/{id}/status";
  static const String updateSeverity = "crisis/alerts/{id}/severity";

  static String getAlertById(String id) => alertById.replaceAll("{id}", id);
  static String updateStatusById(String id) =>
      updateStatus.replaceAll("{id}", id);
  static String updateSeverityById(String id) =>
      updateSeverity.replaceAll("{id}", id);
}

// Library endpoints
class LibraryEndpoints {
  LibraryEndpoints._();

  static const String base = "library";

  // Content Search endpoints
  static const String search = "library/search";
  static const String contentById = "library/{contentId}";

  // Favorites endpoints (General and Patient only)
  static const String favorites = "library/favorites";
  static const String favoriteById = "library/favorites/{favoriteId}";

  // Assignment endpoints - Patient side
  static const String assignedContent = "library/assignments/assigned";
  static const String completeAssignment =
      "library/assignments/assigned/{assignmentId}/complete";

  // Assignment endpoints - Psychologist side
  static const String assignments = "library/assignments";
  static const String psychologistAssignments = "library/assignments/by-psychologist";

  // Recommendation endpoints
  static const String recommendPlaces = "library/recommendations/places";
  static const String recommendContent = "library/recommendations/content";
  static const String recommendByEmotion = "library/recommendations/emotion/{emotion}";

  // Helper functions for dynamic parameters
  static String getContentById(String contentId) =>
      contentById.replaceAll("{contentId}", contentId);
  static String deleteFavorite(String favoriteId) =>
      favoriteById.replaceAll("{favoriteId}", favoriteId);
  static String completeAssignmentById(String assignmentId) =>
      completeAssignment.replaceAll("{assignmentId}", assignmentId);
  static String recommendByEmotionType(String emotion) =>
      recommendByEmotion.replaceAll("{emotion}", emotion);
}
