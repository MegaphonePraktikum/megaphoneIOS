

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
   
    static var megaphone: CGPath {
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
    
    static var play: CGPath {
        
        var shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(101.63, 40.09))
        shapePath.addCurveToPoint(CGPointMake(70.85, 27.35), controlPoint1: CGPointMake(93.41, 31.87), controlPoint2: CGPointMake(82.48, 27.35))
        shapePath.addCurveToPoint(CGPointMake(40.08, 40.09), controlPoint1: CGPointMake(59.23, 27.35), controlPoint2: CGPointMake(48.3, 31.87))
        shapePath.addCurveToPoint(CGPointMake(40.08, 101.64), controlPoint1: CGPointMake(23.11, 57.06), controlPoint2: CGPointMake(23.12, 84.67))
        shapePath.addCurveToPoint(CGPointMake(70.86, 114.39), controlPoint1: CGPointMake(48.3, 109.86), controlPoint2: CGPointMake(59.23, 114.39))
        shapePath.addCurveToPoint(CGPointMake(101.63, 101.64), controlPoint1: CGPointMake(82.48, 114.39), controlPoint2: CGPointMake(93.41, 109.86))
        shapePath.addCurveToPoint(CGPointMake(114.38, 70.87), controlPoint1: CGPointMake(109.85, 93.42), controlPoint2: CGPointMake(114.38, 82.49))
        shapePath.addCurveToPoint(CGPointMake(101.63, 40.09), controlPoint1: CGPointMake(114.38, 59.24), controlPoint2: CGPointMake(109.85, 48.31))
        shapePath.closePath()
        shapePath.moveToPoint(CGPointMake(100.21, 100.23))
        shapePath.addCurveToPoint(CGPointMake(70.86, 112.39), controlPoint1: CGPointMake(92.37, 108.07), controlPoint2: CGPointMake(81.95, 112.39))
        shapePath.addCurveToPoint(CGPointMake(41.5, 100.22), controlPoint1: CGPointMake(59.77, 112.39), controlPoint2: CGPointMake(49.34, 108.07))
        shapePath.addCurveToPoint(CGPointMake(41.5, 41.51), controlPoint1: CGPointMake(25.31, 84.04), controlPoint2: CGPointMake(25.31, 57.7))
        shapePath.addCurveToPoint(CGPointMake(70.85, 29.35), controlPoint1: CGPointMake(49.34, 33.66), controlPoint2: CGPointMake(59.77, 29.35))
        shapePath.addCurveToPoint(CGPointMake(100.21, 41.51), controlPoint1: CGPointMake(81.95, 29.35), controlPoint2: CGPointMake(92.37, 33.66))
        shapePath.addCurveToPoint(CGPointMake(112.38, 70.87), controlPoint1: CGPointMake(108.06, 49.35), controlPoint2: CGPointMake(112.38, 59.78))
        shapePath.addCurveToPoint(CGPointMake(100.21, 100.23), controlPoint1: CGPointMake(112.38, 81.96), controlPoint2: CGPointMake(108.06, 92.38))
        shapePath.closePath()
        
        shapePath.moveToPoint(CGPointMake(65.89, 55.98))
        shapePath.addCurveToPoint(CGPointMake(64.48, 55.98), controlPoint1: CGPointMake(65.5, 55.59), controlPoint2: CGPointMake(64.87, 55.59))
        shapePath.addCurveToPoint(CGPointMake(64.48, 57.4), controlPoint1: CGPointMake(64.09, 56.37), controlPoint2: CGPointMake(64.09, 57.01))
        shapePath.addLineToPoint(CGPointMake(77.95, 70.86))
        shapePath.addLineToPoint(CGPointMake(64.48, 84.33))
        shapePath.addCurveToPoint(CGPointMake(64.48, 85.75), controlPoint1: CGPointMake(64.09, 84.72), controlPoint2: CGPointMake(64.09, 85.35))
        shapePath.addCurveToPoint(CGPointMake(65.19, 86.04), controlPoint1: CGPointMake(64.67, 85.94), controlPoint2: CGPointMake(64.93, 86.04))
        shapePath.addCurveToPoint(CGPointMake(65.89, 85.75), controlPoint1: CGPointMake(65.44, 86.04), controlPoint2: CGPointMake(65.7, 85.94))
        shapePath.addLineToPoint(CGPointMake(80.07, 71.57))
        shapePath.addCurveToPoint(CGPointMake(80.07, 70.16), controlPoint1: CGPointMake(80.46, 71.18), controlPoint2: CGPointMake(80.46, 70.55))
        shapePath.addLineToPoint(CGPointMake(65.89, 55.98))
        shapePath.closePath()
        
        return shapePath.CGPath

    }
    
    static var sound: CGPath {
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(137.7, 97.7))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 11.7), controlPoint1: CGPointMake(137.7, 69), controlPoint2: CGPointMake(137.7, 40.4))
        bezierPath.addCurveToPoint(CGPointMake(132.6, 1.3), controlPoint1: CGPointMake(137.7, 7.3), controlPoint2: CGPointMake(137.2, 3.3))
        bezierPath.addCurveToPoint(CGPointMake(121.4, 4.3), controlPoint1: CGPointMake(128, -0.8), controlPoint2: CGPointMake(124.7, 1.4))
        bezierPath.addCurveToPoint(CGPointMake(67, 51.4), controlPoint1: CGPointMake(103.3, 20), controlPoint2: CGPointMake(85.1, 35.7))
        bezierPath.addCurveToPoint(CGPointMake(59.8, 54.1), controlPoint1: CGPointMake(64.8, 53.3), controlPoint2: CGPointMake(62.7, 54.1))
        bezierPath.addCurveToPoint(CGPointMake(11.8, 54.1), controlPoint1: CGPointMake(43.8, 54), controlPoint2: CGPointMake(27.8, 54))
        bezierPath.addCurveToPoint(CGPointMake(-0.2, 65.9), controlPoint1: CGPointMake(2.5, 54.1), controlPoint2: CGPointMake(-0.2, 56.8))
        bezierPath.addCurveToPoint(CGPointMake(-0.2, 128.4), controlPoint1: CGPointMake(-0.2, 86.7), controlPoint2: CGPointMake(-0.2, 107.6))
        bezierPath.addCurveToPoint(CGPointMake(12.2, 140.5), controlPoint1: CGPointMake(-0.2, 137.6), controlPoint2: CGPointMake(2.8, 140.5))
        bezierPath.addCurveToPoint(CGPointMake(57.7, 140.4), controlPoint1: CGPointMake(27.4, 140.5), controlPoint2: CGPointMake(42.5, 140.6))
        bezierPath.addCurveToPoint(CGPointMake(67.5, 144.1), controlPoint1: CGPointMake(61.6, 140.3), controlPoint2: CGPointMake(64.6, 141.5))
        bezierPath.addCurveToPoint(CGPointMake(121.9, 191.3), controlPoint1: CGPointMake(85.5, 159.9), controlPoint2: CGPointMake(103.8, 175.5))
        bezierPath.addCurveToPoint(CGPointMake(132.8, 193.8), controlPoint1: CGPointMake(125.2, 194.1), controlPoint2: CGPointMake(128.5, 195.7))
        bezierPath.addCurveToPoint(CGPointMake(137.8, 183.8), controlPoint1: CGPointMake(137.2, 191.8), controlPoint2: CGPointMake(137.8, 188))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 97.7), controlPoint1: CGPointMake(137.7, 155), controlPoint2: CGPointMake(137.7, 126.3))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(248.7, 97.7))
        bezierPath.addCurveToPoint(CGPointMake(242.5, 54.9), controlPoint1: CGPointMake(248.9, 83.1), controlPoint2: CGPointMake(246.7, 68.8))
        bezierPath.addCurveToPoint(CGPointMake(217.2, 5.9), controlPoint1: CGPointMake(237.1, 37), controlPoint2: CGPointMake(228.7, 20.7))
        bezierPath.addCurveToPoint(CGPointMake(204.2, 3), controlPoint1: CGPointMake(213.3, 0.9), controlPoint2: CGPointMake(208.3, -0.1))
        bezierPath.addCurveToPoint(CGPointMake(203.3, 16.2), controlPoint1: CGPointMake(199.9, 6.3), controlPoint2: CGPointMake(199.6, 11))
        bezierPath.addCurveToPoint(CGPointMake(205.1, 18.6), controlPoint1: CGPointMake(203.9, 17), controlPoint2: CGPointMake(204.5, 17.8))
        bezierPath.addCurveToPoint(CGPointMake(231.3, 95.8), controlPoint1: CGPointMake(222, 41.5), controlPoint2: CGPointMake(230.9, 67.2))
        bezierPath.addCurveToPoint(CGPointMake(204, 178.6), controlPoint1: CGPointMake(231.8, 126.5), controlPoint2: CGPointMake(222.6, 154.1))
        bezierPath.addCurveToPoint(CGPointMake(204.4, 192.3), controlPoint1: CGPointMake(200, 183.9), controlPoint2: CGPointMake(200.2, 188.9))
        bezierPath.addCurveToPoint(CGPointMake(217.7, 189.2), controlPoint1: CGPointMake(208.7, 195.7), controlPoint2: CGPointMake(213.7, 194.5))
        bezierPath.addCurveToPoint(CGPointMake(248.7, 97.7), controlPoint1: CGPointMake(238.3, 162.1), controlPoint2: CGPointMake(248.7, 131.7))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(215.7, 94.3))
        bezierPath.addCurveToPoint(CGPointMake(212.4, 70.4), controlPoint1: CGPointMake(215.8, 88.7), controlPoint2: CGPointMake(214.6, 79.5))
        bezierPath.addCurveToPoint(CGPointMake(193.2, 29), controlPoint1: CGPointMake(208.8, 55.3), controlPoint2: CGPointMake(202.3, 41.5))
        bezierPath.addCurveToPoint(CGPointMake(181.8, 25.9), controlPoint1: CGPointMake(190.1, 24.8), controlPoint2: CGPointMake(185.8, 23.8))
        bezierPath.addCurveToPoint(CGPointMake(177.7, 36.1), controlPoint1: CGPointMake(178.2, 27.8), controlPoint2: CGPointMake(176.3, 32.2))
        bezierPath.addCurveToPoint(CGPointMake(180.5, 40.8), controlPoint1: CGPointMake(178.3, 37.8), controlPoint2: CGPointMake(179.4, 39.3))
        bezierPath.addCurveToPoint(CGPointMake(198.3, 103.5), controlPoint1: CGPointMake(193.6, 59.7), controlPoint2: CGPointMake(199.5, 80.6))
        bezierPath.addCurveToPoint(CGPointMake(180.7, 154.7), controlPoint1: CGPointMake(197.3, 122.2), controlPoint2: CGPointMake(191.4, 139.3))
        bezierPath.addCurveToPoint(CGPointMake(177.6, 162.9), controlPoint1: CGPointMake(179, 157.2), controlPoint2: CGPointMake(177.1, 159.6))
        bezierPath.addCurveToPoint(CGPointMake(184.2, 170.2), controlPoint1: CGPointMake(178.2, 166.7), controlPoint2: CGPointMake(180.5, 169.3))
        bezierPath.addCurveToPoint(CGPointMake(194, 165.8), controlPoint1: CGPointMake(188.5, 171.3), controlPoint2: CGPointMake(191.6, 169.2))
        bezierPath.addCurveToPoint(CGPointMake(215.7, 94.3), controlPoint1: CGPointMake(208.2, 145.5), controlPoint2: CGPointMake(215.6, 122.9))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(180.5, 97.6))
        bezierPath.addCurveToPoint(CGPointMake(168.5, 55.7), controlPoint1: CGPointMake(180.1, 82.8), controlPoint2: CGPointMake(176.4, 68.6))
        bezierPath.addCurveToPoint(CGPointMake(155.9, 51.6), controlPoint1: CGPointMake(165.2, 50.3), controlPoint2: CGPointMake(160.3, 48.8))
        bezierPath.addCurveToPoint(CGPointMake(153.7, 64.7), controlPoint1: CGPointMake(151.5, 54.4), controlPoint2: CGPointMake(150.6, 59.3))
        bezierPath.addCurveToPoint(CGPointMake(154.1, 130.6), controlPoint1: CGPointMake(166.3, 86.6), controlPoint2: CGPointMake(166.3, 108.6))
        bezierPath.addCurveToPoint(CGPointMake(156.2, 143.7), controlPoint1: CGPointMake(151, 136.2), controlPoint2: CGPointMake(151.8, 141))
        bezierPath.addCurveToPoint(CGPointMake(169.1, 139.2), controlPoint1: CGPointMake(160.8, 146.5), controlPoint2: CGPointMake(165.8, 144.8))
        bezierPath.addCurveToPoint(CGPointMake(180.5, 97.6), controlPoint1: CGPointMake(176.6, 126.4), controlPoint2: CGPointMake(180.3, 112.6))
        
        bezierPath.moveToPoint(CGPointMake(137.7, 97.7))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 183.7), controlPoint1: CGPointMake(137.7, 126.4), controlPoint2: CGPointMake(137.7, 155))
        bezierPath.addCurveToPoint(CGPointMake(132.7, 193.7), controlPoint1: CGPointMake(137.7, 187.9), controlPoint2: CGPointMake(137.1, 191.7))
        bezierPath.addCurveToPoint(CGPointMake(121.8, 191.2), controlPoint1: CGPointMake(128.5, 195.6), controlPoint2: CGPointMake(125.1, 194.1))
        bezierPath.addCurveToPoint(CGPointMake(67.4, 144), controlPoint1: CGPointMake(103.7, 175.5), controlPoint2: CGPointMake(85.5, 159.9))
        bezierPath.addCurveToPoint(CGPointMake(57.6, 140.3), controlPoint1: CGPointMake(64.4, 141.4), controlPoint2: CGPointMake(61.5, 140.3))
        bezierPath.addCurveToPoint(CGPointMake(12.1, 140.4), controlPoint1: CGPointMake(42.4, 140.5), controlPoint2: CGPointMake(27.3, 140.4))
        bezierPath.addCurveToPoint(CGPointMake(-0.3, 128.3), controlPoint1: CGPointMake(2.7, 140.4), controlPoint2: CGPointMake(-0.3, 137.5))
        bezierPath.addCurveToPoint(CGPointMake(-0.3, 65.8), controlPoint1: CGPointMake(-0.3, 107.5), controlPoint2: CGPointMake(-0.3, 86.6))
        bezierPath.addCurveToPoint(CGPointMake(11.7, 54), controlPoint1: CGPointMake(-0.3, 56.7), controlPoint2: CGPointMake(2.4, 54))
        bezierPath.addCurveToPoint(CGPointMake(59.7, 54), controlPoint1: CGPointMake(27.7, 54), controlPoint2: CGPointMake(43.7, 53.9))
        bezierPath.addCurveToPoint(CGPointMake(66.9, 51.3), controlPoint1: CGPointMake(62.6, 54), controlPoint2: CGPointMake(64.7, 53.2))
        bezierPath.addCurveToPoint(CGPointMake(121.3, 4.2), controlPoint1: CGPointMake(85, 35.5), controlPoint2: CGPointMake(103.2, 19.9))
        bezierPath.addCurveToPoint(CGPointMake(132.5, 1.2), controlPoint1: CGPointMake(124.6, 1.3), controlPoint2: CGPointMake(127.9, -0.9))
        bezierPath.addCurveToPoint(CGPointMake(137.6, 11.6), controlPoint1: CGPointMake(137.1, 3.3), controlPoint2: CGPointMake(137.6, 7.2))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 97.7), controlPoint1: CGPointMake(137.7, 40.4), controlPoint2: CGPointMake(137.7, 69))
        
        bezierPath.moveToPoint(CGPointMake(137.7, 97.7))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 11.7), controlPoint1: CGPointMake(137.7, 69), controlPoint2: CGPointMake(137.7, 40.4))
        bezierPath.addCurveToPoint(CGPointMake(132.6, 1.3), controlPoint1: CGPointMake(137.7, 7.3), controlPoint2: CGPointMake(137.2, 3.3))
        bezierPath.addCurveToPoint(CGPointMake(121.4, 4.3), controlPoint1: CGPointMake(128, -0.8), controlPoint2: CGPointMake(124.7, 1.4))
        bezierPath.addCurveToPoint(CGPointMake(67, 51.4), controlPoint1: CGPointMake(103.3, 20), controlPoint2: CGPointMake(85.1, 35.7))
        bezierPath.addCurveToPoint(CGPointMake(59.8, 54.1), controlPoint1: CGPointMake(64.8, 53.3), controlPoint2: CGPointMake(62.7, 54.1))
        bezierPath.addCurveToPoint(CGPointMake(11.8, 54.1), controlPoint1: CGPointMake(43.8, 54), controlPoint2: CGPointMake(27.8, 54))
        bezierPath.addCurveToPoint(CGPointMake(-0.2, 65.9), controlPoint1: CGPointMake(2.5, 54.1), controlPoint2: CGPointMake(-0.2, 56.8))
        bezierPath.addCurveToPoint(CGPointMake(-0.2, 128.4), controlPoint1: CGPointMake(-0.2, 86.7), controlPoint2: CGPointMake(-0.2, 107.6))
        bezierPath.addCurveToPoint(CGPointMake(12.2, 140.5), controlPoint1: CGPointMake(-0.2, 137.6), controlPoint2: CGPointMake(2.8, 140.5))
        bezierPath.addCurveToPoint(CGPointMake(57.7, 140.4), controlPoint1: CGPointMake(27.4, 140.5), controlPoint2: CGPointMake(42.5, 140.6))
        bezierPath.addCurveToPoint(CGPointMake(67.5, 144.1), controlPoint1: CGPointMake(61.6, 140.3), controlPoint2: CGPointMake(64.6, 141.5))
        bezierPath.addCurveToPoint(CGPointMake(121.9, 191.3), controlPoint1: CGPointMake(85.5, 159.9), controlPoint2: CGPointMake(103.8, 175.5))
        bezierPath.addCurveToPoint(CGPointMake(132.8, 193.8), controlPoint1: CGPointMake(125.2, 194.1), controlPoint2: CGPointMake(128.5, 195.7))
        bezierPath.addCurveToPoint(CGPointMake(137.8, 183.8), controlPoint1: CGPointMake(137.2, 191.8), controlPoint2: CGPointMake(137.8, 188))
        bezierPath.addCurveToPoint(CGPointMake(137.7, 97.7), controlPoint1: CGPointMake(137.7, 155), controlPoint2: CGPointMake(137.7, 126.3))
        bezierPath.closePath()
        
        
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
