#!/usr/bin/env python3
"""dev flavor 用のアプリアイコン（DEV バッジ付き）を生成する。

使い方:
  python3 scripts/generate_dev_icons.py

入力: platza/android/app/src/main/res/mipmap-*/ic_launcher.png
      platza/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-*.png
出力: platza/android/app/src/dev/res/mipmap-*/ic_launcher.png
      platza/ios/Runner/Assets.xcassets/AppIcon-dev.appiconset/Icon-App-*.png
"""
from __future__ import annotations

import shutil
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

REPO = Path(__file__).resolve().parents[1]
ANDROID_MAIN_RES = REPO / "platza/android/app/src/main/res"
ANDROID_DEV_RES = REPO / "platza/android/app/src/dev/res"
IOS_PROD_ICONSET = REPO / "platza/ios/Runner/Assets.xcassets/AppIcon.appiconset"
IOS_DEV_ICONSET = REPO / "platza/ios/Runner/Assets.xcassets/AppIcon-dev.appiconset"

BADGE_COLOR = (220, 38, 38, 235)  # 赤系（dev 識別）
BADGE_TEXT_COLOR = (255, 255, 255, 255)
BADGE_TEXT = "DEV"


def find_font(size: int) -> ImageFont.ImageFont:
    candidates = [
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
        "/System/Library/Fonts/Helvetica.ttc",
        "/System/Library/Fonts/SFNS.ttf",
    ]
    for path in candidates:
        if Path(path).exists():
            try:
                return ImageFont.truetype(path, size)
            except OSError:
                continue
    return ImageFont.load_default()


def add_dev_badge(src_path: Path, dst_path: Path) -> None:
    """画像下部に DEV バッジを焼き込む。"""
    image = Image.open(src_path).convert("RGBA")
    width, height = image.size
    overlay = Image.new("RGBA", image.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay)

    # 下 1/3 を半透明帯にする
    band_top = int(height * 0.62)
    draw.rectangle([(0, band_top), (width, height)], fill=BADGE_COLOR)

    font_size = max(8, int(height * 0.28))
    font = find_font(font_size)
    bbox = draw.textbbox((0, 0), BADGE_TEXT, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    text_x = (width - text_w) // 2 - bbox[0]
    text_y = band_top + (height - band_top - text_h) // 2 - bbox[1]
    draw.text((text_x, text_y), BADGE_TEXT, fill=BADGE_TEXT_COLOR, font=font)

    composed = Image.alpha_composite(image, overlay)
    dst_path.parent.mkdir(parents=True, exist_ok=True)
    composed.save(dst_path, format="PNG")


def process_android() -> None:
    for mipmap_dir in sorted(ANDROID_MAIN_RES.glob("mipmap-*")):
        for png in mipmap_dir.glob("*.png"):
            rel = png.relative_to(ANDROID_MAIN_RES)
            dst = ANDROID_DEV_RES / rel
            add_dev_badge(png, dst)
            print(f"android: {dst.relative_to(REPO)}")


def process_ios() -> None:
    if IOS_DEV_ICONSET.exists():
        shutil.rmtree(IOS_DEV_ICONSET)
    IOS_DEV_ICONSET.mkdir(parents=True)
    for png in sorted(IOS_PROD_ICONSET.glob("*.png")):
        dst = IOS_DEV_ICONSET / png.name
        add_dev_badge(png, dst)
        print(f"ios:     {dst.relative_to(REPO)}")
    contents = IOS_PROD_ICONSET / "Contents.json"
    shutil.copy(contents, IOS_DEV_ICONSET / "Contents.json")
    print(f"ios:     {(IOS_DEV_ICONSET / 'Contents.json').relative_to(REPO)}")


if __name__ == "__main__":
    process_android()
    process_ios()
    print("done")
