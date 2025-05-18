class Assets {
  static const _path = 'assets/sfx';
  static const inhale = '$_path/INHALE.mp3';
  static const hold = '$_path/HOLD.mp3';
  static const exhale = '$_path/EXHALE.mp3';
  static const beep = '$_path/BEEP.mp3';
  static const tick = '$_path/TICK.wav';
  static const backGroundMusic1 = 'assets/music/meditation1.mp3';
  static const backGroundMusic2 = 'assets/music/meditation2.mp3';
  static const backGroundMusic3 = 'assets/music/meditation3.mp3';

  static const poemICO = 'assets/icon/poem.png';
  static const mute = 'assets/icon/mute.png';
  static const sound = 'assets/icon/sound.png';
  static const iconSetting = 'assets/icon/setting.png';
  static const iconShare = 'assets/icon/share.png';
  static const background = 'assets/icon/background.png';

  static List<String> values = <String>[
    inhale,
    exhale,
    hold,
    beep,
    tick,
    backGroundMusic1,
    backGroundMusic2,
    backGroundMusic3
  ];

  static List<String> cacheAudio = values.map((e) => e.replaceFirst('assets/', '')).toList();
}

class Play {
  static const inhale = 'sfx/INHALE.mp3';
  static const hold = 'sfx/HOLD.mp3';
  static const exhale = 'sfx/EXHALE.mp3';
  static const beep = 'sfx/BEEP.mp3';
  static const tick = 'sfx/TICK.wav';
  static const backGroundMusic1 = 'music/meditation1.mp3';
  static const backGroundMusic2 = 'music/meditation2.mp3';
  static const backGroundMusic3 = 'music/meditation3.mp3';
}

class FontFamily {
  const FontFamily();

  static const edward = 'Edward';
  static const epilogue = 'Epilogue';
}

class VideoAssets {
  const VideoAssets();

  // static const video = 'assets/video/video.mp4';
  static const video = 'assets/video/video_breathe.mp4';
}
