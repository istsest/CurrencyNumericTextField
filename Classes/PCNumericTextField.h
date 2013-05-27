//
//  PCNumericTextField.h
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 15..
//  Copyright (c) 2013년 Joon. All rights reserved.
//


@interface PCNumericTextField : UITextField

@property						BOOL			isComma;
@property						int				decimalCount;
@property (nonatomic, readonly)	NSString		*numericString;
@property (nonatomic, strong)	NSString		*currencyPrefix;

@end
