import 'dart:convert';

class ScanData {
  final String? on;
  final Off? off;

  ScanData({this.on, this.off});

  factory ScanData.fromJson(Map<String, dynamic> json) {
    return ScanData(
      on: json['on'] as String?,
      off: json['off'] != null ? Off.fromJson(json['off']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'on': on, 'off': off?.toJson()};

  static ScanData fromRawJson(String str) =>
      ScanData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Off {
  final String? ci;
  final String? cn;
  final String? cp;
  final String? vn;
  final String? vt;
  final String? dn;
  final String? dmn;
  final String? dpd;
  final String? dpl;
  final String? dtd;
  final String? dtl;
  final String? ddt;
  final String? ds;
  final String? rm;
  final Dl? dl;
  final String? ml;
  final List<Mld>? mld;

  Off({
    this.ci,
    this.cn,
    this.cp,
    this.vn,
    this.vt,
    this.dn,
    this.dmn,
    this.dpd,
    this.dpl,
    this.dtd,
    this.dtl,
    this.ddt,
    this.ds,
    this.rm,
    this.dl,
    this.ml,
    this.mld,
  });

  factory Off.fromJson(Map<String, dynamic> json) {
    return Off(
      ci: json['ci'] as String?,
      cn: json['cn'] as String?,
      cp: json['cp'] as String?,
      vn: json['vn'] as String?,
      vt: json['vt'] as String?,
      dn: json['dn'] as String?,
      dmn: json['dmn'] as String?,
      dpd: json['dpd'] as String?,
      dpl: json['dpl'] as String?,
      dtd: json['dtd'] as String?,
      dtl: json['dtl'] as String?,
      ddt: json['ddt'] as String?,
      ds: json['ds'] as String?,
      rm: json['rm'] as String?,
      dl: json['dl'] != null ? Dl.fromJson(json['dl']) : null,
      ml: json['ml'] as String?,
      mld: json['mld'] != null
          ? List<Mld>.from(json['mld'].map((x) => Mld.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'ci': ci,
    'cn': cn,
    'cp': cp,
    'vn': vn,
    'vt': vt,
    'dn': dn,
    'dmn': dmn,
    'dpd': dpd,
    'dpl': dpl,
    'dtd': dtd,
    'dtl': dtl,
    'ddt': ddt,
    'ds': ds,
    'rm': rm,
    'dl': dl?.toJson(),
    'ml': ml,
    'mld': mld?.map((x) => x.toJson()).toList(),
  };
}

class Dl {
  final String? b;
  final String? c;
  final String? p;
  final String? dr;
  final String? o;
  final String? cr;
  final String? nb;

  Dl({this.b, this.c, this.p, this.dr, this.o, this.cr, this.nb});

  factory Dl.fromJson(Map<String, dynamic> json) {
    return Dl(
      b: json['b'] as String?,
      c: json['c'] as String?,
      p: json['p'] as String?,
      dr: json['dr'] as String?,
      o: json['o'] as String?,
      cr: json['cr'] as String?,
      nb: json['nb'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'b': b,
    'c': c,
    'p': p,
    'dr': dr,
    'o': o,
    'cr': cr,
    'nb': nb,
  };
}

class Mld {
  final String? mlid;
  final String? mlcid;
  final String? mldd;
  final String? mlvt;
  final String? mlvn;
  final String? mlvid;
  final String? mldn;
  final String? mlmn;
  final String? mlds;
  final String? mlq;
  final String? mlrm;

  Mld({
    this.mlid,
    this.mlcid,
    this.mldd,
    this.mlvt,
    this.mlvn,
    this.mlvid,
    this.mldn,
    this.mlmn,
    this.mlds,
    this.mlq,
    this.mlrm,
  });

  factory Mld.fromJson(Map<String, dynamic> json) {
    return Mld(
      mlid: json['mlid'] as String?,
      mlcid: json['mlcid'] as String?,
      mldd: json['mldd'] as String?,
      mlvt: json['mlvt'] as String?,
      mlvn: json['mlvn'] as String?,
      mlvid: json['mlvid'] as String?,
      mldn: json['mldn'] as String?,
      mlmn: json['mlmn'] as String?,
      mlds: json['mlds'] as String?,
      mlq: json['mlq'] as String?,
      mlrm: json['mlrm'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'mlid': mlid,
    'mlcid': mlcid,
    'mldd': mldd,
    'mlvt': mlvt,
    'mlvn': mlvn,
    'mlvid': mlvid,
    'mldn': mldn,
    'mlmn': mlmn,
    'mlds': mlds,
    'mlq': mlq,
    'mlrm': mlrm,
  };
}
