//
//  KVParkedTextField.h
//  KVParkedTextField
//
//  Created by Tran Manh Tuan on 7/7/16.
//  Copyright © 2016 Citigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVParkedTextField : UITextField

@property (nonatomic, strong) NSString *parkedText;
@property (nonatomic, strong) NSString *placeholderText;
@property (nonatomic, strong) NSString *typedText;
@property (nonatomic, strong) UIFont *parkedTextFont;
@property (nonatomic, strong) UIColor *parkedTextColor;

@end
