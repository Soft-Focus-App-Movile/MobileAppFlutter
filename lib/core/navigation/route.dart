/// Sealed class representing all navigation routes in the app.
///
/// Each route corresponds to a screen or destination in the navigation graph.
/// Using a sealed class ensures type safety and compile-time checking for routes.
sealed class AppRoute {
  const AppRoute(this.path);
  final String path;

  // Auth routes
  static const splash = _SplashRoute();
  static const login = _LoginRoute();
  static const register = _RegisterRoute();
  static const forgotPassword = _ForgotPasswordRoute();
  static const accountReview = _AccountReviewRoute();
  static const accountSuccess = _AccountSuccessRoute();
  static const accountDenied = _AccountDeniedRoute();

  static const permissions = _PermissionsRoute();

  // Main app routes
  static const home = _HomeRoute();
  static const tracking = _TrackingRoute();
  static const crisis = _CrisisRoute();

  // Tracking routes
  static const diary = _DiaryRoute();
  static const checkInForm = _CheckInFormRoute();
  static const progress = _ProgressRoute();

  // Library routes - General
  static const libraryGeneralBrowse = _LibraryGeneralBrowseRoute();
  static const library = _LibraryRoute();

  // Search Psychologist routes
  static const searchPsychologist = _SearchPsychologistRoute();

  // General/Patient profile routes
  static const generalProfile = _GeneralProfileRoute();
  static const patientProfile = _PatientProfileRoute();
  static const editProfile = _EditProfileRoute();
  static const privacyPolicy = _PrivacyPolicyRoute();
  static const helpSupport = _HelpSupportRoute();

  // Psychologist profile routes
  static const psychologistProfile = _PsychologistProfileRoute();
  static const psychologistEditProfile = _PsychologistEditProfileRoute();
  static const professionalData = _ProfessionalDataRoute();
  static const invitationCode = _InvitationCodeRoute();
  static const psychologistPlan = _PsychologistPlanRoute();
  static const psychologistStats = _PsychologistStatsRoute();

  static const myPlan = _MyPlanRoute();
  static const patientPlan = _PatientPlanRoute();

  // Therapy routes (Psychologist)
  static const psychologistPatientList = _PsychologistPatientListRoute();
  static const psychologistPatientDetail = _PsychologistPatientDetailRoute();

  // Therapy routes (Patient)
  static const patientPsychologistChat = _PatientPsychologistChatRoute();
  static const psychologistChatProfile = _PsychologistChatProfileRoute();
  static const crisisAlerts = _CrisisAlertsRoute();

  // AI routes
  static const aiWelcome = _AIWelcomeRoute();
  static const emotionDetection = _EmotionDetectionRoute();

  static const connectPsychologist = _ConnectPsychologistRoute();

  // Admin routes
  static const adminUsers = _AdminUsersRoute();
  static const verifyPsychologist = _VerifyPsychologistRoute();

  // Notifications routes
  static const notifications = _NotificationsRoute();
  static const notificationPreferences = _NotificationPreferencesRoute();

  /// Returns all auth-related routes.
  static const List<AppRoute> authRoutes = [
    splash,
    login,
    register,
    forgotPassword,
    accountReview,
    accountSuccess,
    accountDenied,
  ];
}

// Auth routes
class _SplashRoute extends AppRoute {
  const _SplashRoute() : super('/splash');
}

class _LoginRoute extends AppRoute {
  const _LoginRoute() : super('/login');
}

class _RegisterRoute extends AppRoute {
  const _RegisterRoute() : super('/register');
}

class _ForgotPasswordRoute extends AppRoute {
  const _ForgotPasswordRoute() : super('/forgot_password');
}

class _AccountReviewRoute extends AppRoute {
  const _AccountReviewRoute() : super('/account_review');
}

class _AccountSuccessRoute extends AppRoute {
  const _AccountSuccessRoute() : super('/account_success');
}

class _AccountDeniedRoute extends AppRoute {
  const _AccountDeniedRoute() : super('/account_denied');
}

class _PermissionsRoute extends AppRoute {
  const _PermissionsRoute() : super('/permissions');
}

// Main app routes
class _HomeRoute extends AppRoute {
  const _HomeRoute() : super('/home');
}

class _TrackingRoute extends AppRoute {
  const _TrackingRoute() : super('/tracking');
}

class _CrisisRoute extends AppRoute {
  const _CrisisRoute() : super('/crisis');
}

// Tracking routes
class _DiaryRoute extends AppRoute {
  const _DiaryRoute() : super('/diary');
}

class _CheckInFormRoute extends AppRoute {
  const _CheckInFormRoute() : super('/check_in_form');
}

class _ProgressRoute extends AppRoute {
  const _ProgressRoute() : super('/progress');
}

// Library routes
class _LibraryGeneralBrowseRoute extends AppRoute {
  const _LibraryGeneralBrowseRoute() : super('/library_general_browse');
}

class _LibraryRoute extends AppRoute {
  const _LibraryRoute() : super('/library');
}

// Search Psychologist routes
class _SearchPsychologistRoute extends AppRoute {
  const _SearchPsychologistRoute() : super('/search_psychologist');
}

// Profile routes
class _GeneralProfileRoute extends AppRoute {
  const _GeneralProfileRoute() : super('/general_profile');
}

class _PatientProfileRoute extends AppRoute {
  const _PatientProfileRoute() : super('/patient_profile');
}

class _EditProfileRoute extends AppRoute {
  const _EditProfileRoute() : super('/edit_profile');
}

class _PrivacyPolicyRoute extends AppRoute {
  const _PrivacyPolicyRoute() : super('/privacy_policy');
}

class _HelpSupportRoute extends AppRoute {
  const _HelpSupportRoute() : super('/help_support');
}

// Psychologist profile routes
class _PsychologistProfileRoute extends AppRoute {
  const _PsychologistProfileRoute() : super('/psychologist_profile');
}

class _PsychologistEditProfileRoute extends AppRoute {
  const _PsychologistEditProfileRoute() : super('/psychologist_edit_profile');
}

class _ProfessionalDataRoute extends AppRoute {
  const _ProfessionalDataRoute() : super('/professional_data');
}

class _InvitationCodeRoute extends AppRoute {
  const _InvitationCodeRoute() : super('/invitation_code');
}

class _PsychologistPlanRoute extends AppRoute {
  const _PsychologistPlanRoute() : super('/psychologist_plan');
}

class _PsychologistStatsRoute extends AppRoute {
  const _PsychologistStatsRoute() : super('/psychologist_stats');
}

class _MyPlanRoute extends AppRoute {
  const _MyPlanRoute() : super('/my_plan');
}

class _PatientPlanRoute extends AppRoute {
  const _PatientPlanRoute() : super('/patient_plan');
}

// Therapy routes
class _PsychologistPatientListRoute extends AppRoute {
  const _PsychologistPatientListRoute() : super('/psychologist_patient_list');
}

class _PsychologistPatientDetailRoute extends AppRoute {
  const _PsychologistPatientDetailRoute() : super('/psychologist_patient_detail/:patientId');
  
  String createRoute(String patientId) {
    return '/psychologist_patient_detail/$patientId';
  }
}

class _PatientPsychologistChatRoute extends AppRoute {
  const _PatientPsychologistChatRoute() : super('/patient_psychologist_chat');
}

class _PsychologistChatProfileRoute extends AppRoute {
  const _PsychologistChatProfileRoute() : super('/psychologist_chat_profile');
}

class _CrisisAlertsRoute extends AppRoute {
  const _CrisisAlertsRoute() : super('/crisis_alerts');
}

// AI routes
class _AIWelcomeRoute extends AppRoute {
  const _AIWelcomeRoute() : super('/ai_welcome');
}

class _EmotionDetectionRoute extends AppRoute {
  const _EmotionDetectionRoute() : super('/emotion_detection');
}

class _ConnectPsychologistRoute extends AppRoute {
  const _ConnectPsychologistRoute() : super('/connect_psychologist');
}

// Admin routes
class _AdminUsersRoute extends AppRoute {
  const _AdminUsersRoute() : super('/admin_users');
}

class _VerifyPsychologistRoute extends AppRoute {
  const _VerifyPsychologistRoute() : super('/verify_psychologist');
}

// Notifications routes
class _NotificationsRoute extends AppRoute {
  const _NotificationsRoute() : super('/notifications');
}

class _NotificationPreferencesRoute extends AppRoute {
  const _NotificationPreferencesRoute() : super('/notification_preferences');
}
