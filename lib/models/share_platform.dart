enum SharePlatform {
  instagram('Instagram'),
  facebook('Facebook'),
  messenger('Messenger'),
  whatsapp('WhatsApp'),
  tiktok('TikTok'),
  snapchat('Snapchat'),
  x('X'),
  youtube('YouTube'),
  telegram('Telegram'),
  linkedin('LinkedIn');

  const SharePlatform(this.label);

  final String label;
}

const List<SharePlatform> kSharePlatforms = SharePlatform.values;
