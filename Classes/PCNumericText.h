//
//  PCNumericText.h
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 27..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDecialFreeCount			-1

@interface PCNumericText : NSObject

@property						BOOL			isComma;
@property						int				decimalCount;
@property (nonatomic, strong)	NSString		*currencyPrefix;


- (NSString *)stringForDisplay:(NSString *)numeric;
- (NSString *)stringForNumeric:(NSString *)str;

@end
