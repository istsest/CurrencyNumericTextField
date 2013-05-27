//
//  PCNumericLabel.h
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 27..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCNumericLabel : UILabel

@property						BOOL			isComma;
@property						int				decimalCount;
@property (nonatomic, readonly)	NSString		*numericString;
@property (nonatomic, strong)	NSString		*currencyPrefix;

@end
