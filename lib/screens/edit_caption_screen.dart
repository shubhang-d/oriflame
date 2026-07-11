import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EditCaptionScreen extends StatefulWidget {
  final String initialText;

  const EditCaptionScreen({super.key, required this.initialText});

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  static const Color _saveEnabled = Color(0xFF6FC49A);
  static const Color _saveDisabled = Color(0xFFB4DDCB);

  late final TextEditingController _controller;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText)
      ..addListener(_onChanged);
  }

  void _onChanged() {
    final changed = _controller.text != widget.initialText;
    if (changed != _changed) setState(() => _changed = changed);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  void _save() {
    if (!_changed) return;
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.h8Bold.copyWith(
      fontSize: 17,
      color: AppColors.text500,
    );
    final bodyStyle = AppTextStyles.caption.copyWith(
      fontSize: 15,
      height: 1.5,
      color: AppColors.text500,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(child: Text('Edit Caption', style: titleStyle)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 26),
                      color: AppColors.text500,
                      splashRadius: 22,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _SaveButton(
                        enabled: _changed,
                        enabledColor: _saveEnabled,
                        disabledColor: _saveDisabled,
                        onTap: _save,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  cursorColor: _saveEnabled,
                  style: bodyStyle,
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool enabled;
  final Color enabledColor;
  final Color disabledColor;
  final VoidCallback onTap;

  const _SaveButton({
    required this.enabled,
    required this.enabledColor,
    required this.disabledColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? enabledColor : disabledColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Save',
          style: AppTextStyles.captionBold.copyWith(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
