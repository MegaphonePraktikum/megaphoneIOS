//
//  Paths.swift
//  FavoriteStart
//
//  Created by Rafael Machado on 2/9/15.
//  Copyright (c) 2015 Rafael Machado. All rights reserved.
//

import UIKit

struct Paths {
    
    
    
    static var Logo: CGPath {
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(10.3, 45.2))
        bezierPath.addCurveToPoint(CGPointMake(9.1, 45.3), controlPoint1: CGPointMake(9.8, 45.2), controlPoint2: CGPointMake(9.4, 45.3))
        bezierPath.addCurveToPoint(CGPointMake(5.9, 43.6), controlPoint1: CGPointMake(6.9, 45.6), controlPoint2: CGPointMake(6.7, 45.6))
        bezierPath.addCurveToPoint(CGPointMake(4.2, 31.8), controlPoint1: CGPointMake(4.3, 39.8), controlPoint2: CGPointMake(3.7, 35.9))
        bezierPath.addCurveToPoint(CGPointMake(6.7, 29.3), controlPoint1: CGPointMake(4.4, 29.8), controlPoint2: CGPointMake(4.7, 29.6))
        bezierPath.addCurveToPoint(CGPointMake(22.3, 27.1), controlPoint1: CGPointMake(11.8, 28.6), controlPoint2: CGPointMake(17, 27.8))
        bezierPath.addCurveToPoint(CGPointMake(24.6, 43.2), controlPoint1: CGPointMake(23, 32.4), controlPoint2: CGPointMake(23.8, 37.7))
        bezierPath.addCurveToPoint(CGPointMake(21.9, 43.6), controlPoint1: CGPointMake(23.7, 43.3), controlPoint2: CGPointMake(22.8, 43.5))
        bezierPath.addCurveToPoint(CGPointMake(21.8, 43.9), controlPoint1: CGPointMake(21.8, 43.8), controlPoint2: CGPointMake(21.8, 43.9))
        bezierPath.addCurveToPoint(CGPointMake(22.3, 49.6), controlPoint1: CGPointMake(22.7, 45.7), controlPoint2: CGPointMake(22.7, 47.6))
        bezierPath.addCurveToPoint(CGPointMake(24.2, 58.1), controlPoint1: CGPointMake(21.7, 52.6), controlPoint2: CGPointMake(22.5, 55.5))
        bezierPath.addCurveToPoint(CGPointMake(24.7, 58.8), controlPoint1: CGPointMake(24.4, 58.3), controlPoint2: CGPointMake(24.5, 58.6))
        bezierPath.addCurveToPoint(CGPointMake(23.5, 62.6), controlPoint1: CGPointMake(26.2, 61.1), controlPoint2: CGPointMake(26.1, 61.5))
        bezierPath.addCurveToPoint(CGPointMake(21.4, 63.5), controlPoint1: CGPointMake(22.8, 62.9), controlPoint2: CGPointMake(22.1, 63.2))
        bezierPath.addCurveToPoint(CGPointMake(18.8, 62.4), controlPoint1: CGPointMake(20, 64.1), controlPoint2: CGPointMake(19.2, 63.9))
        bezierPath.addCurveToPoint(CGPointMake(16.7, 55.4), controlPoint1: CGPointMake(18, 60.1), controlPoint2: CGPointMake(17.3, 57.8))
        bezierPath.addCurveToPoint(CGPointMake(12.6, 49.1), controlPoint1: CGPointMake(16.1, 52.8), controlPoint2: CGPointMake(15.1, 50.5))
        bezierPath.addCurveToPoint(CGPointMake(10.3, 45.2), controlPoint1: CGPointMake(11, 48.4), controlPoint2: CGPointMake(10.6, 46.9))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        bezierPath.moveToPoint(CGPointMake(44.3, 14))
        bezierPath.addCurveToPoint(CGPointMake(46.6, 14.5), controlPoint1: CGPointMake(45, 13.4), controlPoint2: CGPointMake(45.9, 13.7))
        bezierPath.addCurveToPoint(CGPointMake(48.8, 17.9), controlPoint1: CGPointMake(47.5, 15.6), controlPoint2: CGPointMake(48.4, 16.7))
        bezierPath.addCurveToPoint(CGPointMake(51.7, 27.4), controlPoint1: CGPointMake(49.9, 21), controlPoint2: CGPointMake(51, 24.1))
        bezierPath.addCurveToPoint(CGPointMake(52.8, 44), controlPoint1: CGPointMake(52.8, 32.9), controlPoint2: CGPointMake(53.7, 38.4))
        bezierPath.addCurveToPoint(CGPointMake(51.6, 47.7), controlPoint1: CGPointMake(52.6, 45.3), controlPoint2: CGPointMake(52.2, 46.5))
        bezierPath.addCurveToPoint(CGPointMake(48.8, 49), controlPoint1: CGPointMake(51.1, 48.7), controlPoint2: CGPointMake(50.2, 49.3))
        bezierPath.addCurveToPoint(CGPointMake(50.9, 40.2), controlPoint1: CGPointMake(50.8, 46.3), controlPoint2: CGPointMake(50.9, 43.2))
        bezierPath.addCurveToPoint(CGPointMake(47, 19.1), controlPoint1: CGPointMake(50.8, 32.9), controlPoint2: CGPointMake(49.8, 25.8))
        bezierPath.addCurveToPoint(CGPointMake(44.3, 14), controlPoint1: CGPointMake(46.4, 17.2), controlPoint2: CGPointMake(45.3, 15.6))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        
        //// Bezier 3 Drawing
        bezierPath.moveToPoint(CGPointMake(4, 43.2))
        bezierPath.addCurveToPoint(CGPointMake(-0.4, 38.6), controlPoint1: CGPointMake(1.6, 42.7), controlPoint2: CGPointMake(0, 41.1))
        bezierPath.addCurveToPoint(CGPointMake(2.6, 32.9), controlPoint1: CGPointMake(-0.8, 36.2), controlPoint2: CGPointMake(0.3, 34))
        bezierPath.addCurveToPoint(CGPointMake(4, 43.2), controlPoint1: CGPointMake(3.1, 36.3), controlPoint2: CGPointMake(3.6, 39.8))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        
        //// Bezier 4 Drawing
        bezierPath.moveToPoint(CGPointMake(22.9, 49.7))
        bezierPath.addCurveToPoint(CGPointMake(23.1, 54.1), controlPoint1: CGPointMake(24.7, 52), controlPoint2: CGPointMake(24.8, 53.3))
        bezierPath.addCurveToPoint(CGPointMake(22.9, 49.7), controlPoint1: CGPointMake(23, 52.6), controlPoint2: CGPointMake(23, 51.1))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        
        return bezierPath.CGPath

    }
   
    static var star: CGPath {
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(57, 156.2))
        bezierPath.addCurveToPoint(CGPointMake(49.7, 155.8), controlPoint1: CGPointMake(54.1, 156), controlPoint2: CGPointMake(51.9, 155.8))
        bezierPath.addCurveToPoint(CGPointMake(32.5, 143.1), controlPoint1: CGPointMake(36.8, 155.7), controlPoint2: CGPointMake(35.7, 155.4))
        bezierPath.addCurveToPoint(CGPointMake(32.2, 72.3), controlPoint1: CGPointMake(26.5, 119.6), controlPoint2: CGPointMake(26.1, 95.9))
        bezierPath.addCurveToPoint(CGPointMake(48.8, 59.8), controlPoint1: CGPointMake(35.2, 60.5), controlPoint2: CGPointMake(36.8, 59.8))
        bezierPath.addCurveToPoint(CGPointMake(142.4, 59.8), controlPoint1: CGPointMake(79.6, 59.8), controlPoint2: CGPointMake(110.4, 59.8))
        bezierPath.addCurveToPoint(CGPointMake(142.4, 156.2), controlPoint1: CGPointMake(142.4, 91.3), controlPoint2: CGPointMake(142.4, 123.5))
        bezierPath.addCurveToPoint(CGPointMake(126.3, 156.2), controlPoint1: CGPointMake(137.3, 156.2), controlPoint2: CGPointMake(131.7, 156.2))
        bezierPath.addCurveToPoint(CGPointMake(125.4, 157.9), controlPoint1: CGPointMake(125.8, 157.2), controlPoint2: CGPointMake(125.3, 157.7))
        bezierPath.addCurveToPoint(CGPointMake(123.6, 191.9), controlPoint1: CGPointMake(129.4, 169.5), controlPoint2: CGPointMake(127.5, 180.5))
        bezierPath.addCurveToPoint(CGPointMake(127.6, 243.4), controlPoint1: CGPointMake(117.7, 209.3), controlPoint2: CGPointMake(119.9, 226.7))
        bezierPath.addCurveToPoint(CGPointMake(129.8, 248.1), controlPoint1: CGPointMake(128.3, 245), controlPoint2: CGPointMake(129.1, 246.5))
        bezierPath.addCurveToPoint(CGPointMake(119.5, 269.6), controlPoint1: CGPointMake(136.6, 262.9), controlPoint2: CGPointMake(135.5, 265.1))
        bezierPath.addCurveToPoint(CGPointMake(106.6, 273.3), controlPoint1: CGPointMake(115.2, 270.8), controlPoint2: CGPointMake(110.9, 272.1))
        bezierPath.addCurveToPoint(CGPointMake(91.9, 264.7), controlPoint1: CGPointMake(97.8, 275.6), controlPoint2: CGPointMake(93.7, 273.7))
        bezierPath.addCurveToPoint(CGPointMake(85.6, 222), controlPoint1: CGPointMake(89.2, 250.6), controlPoint2: CGPointMake(87.1, 236.3))
        bezierPath.addCurveToPoint(CGPointMake(66.5, 181.8), controlPoint1: CGPointMake(84, 206.2), controlPoint2: CGPointMake(80.4, 191.8))
        bezierPath.addCurveToPoint(CGPointMake(57, 156.2), controlPoint1: CGPointMake(58.4, 175.9), controlPoint2: CGPointMake(57.3, 166.5))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(282.8, 1.1))
        bezierPath.addCurveToPoint(CGPointMake(295.7, 5.7), controlPoint1: CGPointMake(287.6, -1.5), controlPoint2: CGPointMake(292.7, 0.7))
        bezierPath.addCurveToPoint(CGPointMake(306, 27.7), controlPoint1: CGPointMake(299.9, 12.6), controlPoint2: CGPointMake(304.4, 20))
        bezierPath.addCurveToPoint(CGPointMake(315, 85.6), controlPoint1: CGPointMake(310, 46.8), controlPoint2: CGPointMake(313.9, 66.2))
        bezierPath.addCurveToPoint(CGPointMake(307.7, 183.9), controlPoint1: CGPointMake(317, 118.6), controlPoint2: CGPointMake(317.4, 151.7))
        bezierPath.addCurveToPoint(CGPointMake(297.7, 204.5), controlPoint1: CGPointMake(305.5, 191.1), controlPoint2: CGPointMake(301.9, 198.2))
        bezierPath.addCurveToPoint(CGPointMake(280.4, 209.6), controlPoint1: CGPointMake(294, 210.2), controlPoint2: CGPointMake(288.1, 212.9))
        bezierPath.addCurveToPoint(CGPointMake(299.8, 159.6), controlPoint1: CGPointMake(294.3, 195.6), controlPoint2: CGPointMake(297.4, 177.5))
        bezierPath.addCurveToPoint(CGPointMake(294.6, 32.3), controlPoint1: CGPointMake(305.5, 116.9), controlPoint2: CGPointMake(305, 74.3))
        bezierPath.addCurveToPoint(CGPointMake(282.8, 1.1), controlPoint1: CGPointMake(292.1, 21.7), controlPoint2: CGPointMake(286.9, 11.7))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(21.7, 139.4))
        bezierPath.addCurveToPoint(CGPointMake(-0.4, 108.8), controlPoint1: CGPointMake(7.9, 134.7), controlPoint2: CGPointMake(-0.3, 123.5))
        bezierPath.addCurveToPoint(CGPointMake(21.7, 77.9), controlPoint1: CGPointMake(-0.5, 94.1), controlPoint2: CGPointMake(7.7, 82.6))
        bezierPath.addCurveToPoint(CGPointMake(21.7, 139.4), controlPoint1: CGPointMake(21.7, 98.4), controlPoint2: CGPointMake(21.7, 118.9))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(127.2, 193.3))
        bezierPath.addCurveToPoint(CGPointMake(124.6, 219.5), controlPoint1: CGPointMake(135.8, 208.3), controlPoint2: CGPointMake(135.2, 215.8))
        bezierPath.addCurveToPoint(CGPointMake(127.2, 193.3), controlPoint1: CGPointMake(125.5, 210.3), controlPoint2: CGPointMake(126.4, 201.8))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(273.4, 206))
        bezierPath.addCurveToPoint(CGPointMake(154.5, 158), controlPoint1: CGPointMake(238.1, 179.6), controlPoint2: CGPointMake(199.3, 162.4))
        bezierPath.addCurveToPoint(CGPointMake(154.5, 58), controlPoint1: CGPointMake(154.5, 124.3), controlPoint2: CGPointMake(154.5, 91.3))
        bezierPath.addCurveToPoint(CGPointMake(273.9, 7.7), controlPoint1: CGPointMake(199.4, 52.4), controlPoint2: CGPointMake(241.4, 41.1))
        bezierPath.addCurveToPoint(CGPointMake(273.4, 206), controlPoint1: CGPointMake(297.8, 37.1), controlPoint2: CGPointMake(301.6, 177))
        bezierPath.closePath()

        return bezierPath.CGPath
    }
    
    static var swift: CGPath {
        var swiftPath = UIBezierPath()
        swiftPath.moveToPoint(CGPointMake(376.2, 283.2))
        swiftPath.addCurveToPoint(CGPointMake(349.8, 238.4), controlPoint1: CGPointMake(367.4, 258.4), controlPoint2: CGPointMake(349.8, 238.4))
        swiftPath.addCurveToPoint(CGPointMake(236.5, 0), controlPoint1: CGPointMake(349.8, 238.4), controlPoint2: CGPointMake(399.7, 105.6))
        swiftPath.addCurveToPoint(CGPointMake(269, 180.8), controlPoint1: CGPointMake(303.7, 101.6), controlPoint2: CGPointMake(269, 180.8))
        swiftPath.addCurveToPoint(CGPointMake(181.29, 117.07), controlPoint1: CGPointMake(269, 180.8), controlPoint2: CGPointMake(211.4, 140.8))
        swiftPath.addCurveToPoint(CGPointMake(85, 33.6), controlPoint1: CGPointMake(151.18, 93.35), controlPoint2: CGPointMake(85, 33.6))
        swiftPath.addCurveToPoint(CGPointMake(145, 117.07), controlPoint1: CGPointMake(85, 33.6), controlPoint2: CGPointMake(128.15, 96.31))
        swiftPath.addCurveToPoint(CGPointMake(185.78, 163.66), controlPoint1: CGPointMake(161.85, 137.84), controlPoint2: CGPointMake(185.78, 163.66))
        swiftPath.addCurveToPoint(CGPointMake(136.36, 129.42), controlPoint1: CGPointMake(185.78, 163.66), controlPoint2: CGPointMake(161.07, 147.39))
        swiftPath.addCurveToPoint(CGPointMake(34.6, 50.4), controlPoint1: CGPointMake(111.65, 111.46), controlPoint2: CGPointMake(34.6, 50.4))
        swiftPath.addCurveToPoint(CGPointMake(133.8, 169.2), controlPoint1: CGPointMake(34.6, 50.4), controlPoint2: CGPointMake(82.69, 119.24))
        swiftPath.addCurveToPoint(CGPointMake(214.6, 244), controlPoint1: CGPointMake(184.91, 219.16), controlPoint2: CGPointMake(214.6, 244))
        swiftPath.addCurveToPoint(CGPointMake(129.8, 264.8), controlPoint1: CGPointMake(214.6, 244), controlPoint2: CGPointMake(196.2, 263.2))
        swiftPath.addCurveToPoint(CGPointMake(0, 221), controlPoint1: CGPointMake(63.4, 266.4), controlPoint2: CGPointMake(0, 221))
        swiftPath.addCurveToPoint(CGPointMake(206.6, 339.2), controlPoint1: CGPointMake(0, 221), controlPoint2: CGPointMake(62.5, 339.2))
        swiftPath.addCurveToPoint(CGPointMake(325, 304.8), controlPoint1: CGPointMake(270.6, 339.2), controlPoint2: CGPointMake(288.93, 304.8))
        swiftPath.addCurveToPoint(CGPointMake(383.3, 339.2), controlPoint1: CGPointMake(361.07, 304.8), controlPoint2: CGPointMake(381.7, 340))
        swiftPath.addCurveToPoint(CGPointMake(376.2, 283.2), controlPoint1: CGPointMake(384.9, 338.4), controlPoint2: CGPointMake(385, 308))
        return swiftPath.CGPath
    }
    
    static func circle(inFrame: CGRect) -> CGPath {
        let circle = UIBezierPath(ovalInRect: inFrame)
        return circle.CGPath
    }
}
