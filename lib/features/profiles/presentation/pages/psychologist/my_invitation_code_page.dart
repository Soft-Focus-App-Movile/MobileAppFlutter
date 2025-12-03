import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../../../../core/widgets/invitation_card.dart';

class MyInvitationCodePage extends StatelessWidget {
  final VoidCallback onNavigateBack;
  final String invitationCode;

  const MyInvitationCodePage({
    super.key,
    required this.onNavigateBack,
    required this.invitationCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Mi código de invitación',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: green37,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: green37),
          onPressed: onNavigateBack,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: InvitationCard(
            code: invitationCode,
            onCopyClick: () => _copyToClipboard(context, invitationCode),
            onShareClick: () => _shareCode(invitationCode),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Código copiado: $code'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareCode(String code) {
    Clipboard.setData(ClipboardData(
      text: 'Mi código de invitación de SoftFocus es: $code\n\nÚnete a SoftFocus y conecta conmigo!',
    ));
  }
}
