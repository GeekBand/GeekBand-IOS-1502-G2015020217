//
//  GlobalTool.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/15.
//  Copyright © 2015年 Ants. All rights reserved.
//

#ifndef GlobalTool_h
#define GlobalTool_h


#endif /* GlobalTool_h */

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]