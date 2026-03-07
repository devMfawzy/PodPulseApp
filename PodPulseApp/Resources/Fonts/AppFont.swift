//
//  AppFont.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.

import SwiftUI

enum AppFont {
    static func regular(size: CGFloat) -> Font {
        .custom("IBMPlexSansArabic-Regular", size: size)
    }

    static func medium(size: CGFloat) -> Font {
        .custom("IBMPlexSansArabic-Medium", size: size)
    }

    static func semiBold(size: CGFloat) -> Font {
        .custom("IBMPlexSansArabic-SemiBold", size: size)
    }

    static func bold(size: CGFloat) -> Font {
        .custom("IBMPlexSansArabic-Bold", size: size)
    }

    static func light(size: CGFloat) -> Font {
        .custom("IBMPlexSansArabic-Light", size: size)
    }
}
