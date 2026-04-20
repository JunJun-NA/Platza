import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// リーディングアイコン + タイトル / サブタイトル + シェブロンで構成された
/// ナビゲーション用カード。
///
/// `PlatzaCard` の tappable バリアントとして ListTile を内包する共通パターンを
/// 1 widget にまとめたもの。plant_detail から care_log / care_calendar などの
/// 画面遷移エントリで使用。
class LinkNavigationCard extends StatelessWidget {
  const LinkNavigationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PlatzaCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
