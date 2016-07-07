//
//  KVParkedTextField.m
//  KVParkedTextField
//
//  Created by Tran Manh Tuan on 7/7/16.
//  Copyright © 2016 Citigo. All rights reserved.
//

#import "KVParkedTextField.h"

typedef NS_ENUM(uint8_t, KVTypingState) {
    KVTypingStart = 0,
    KVTypingTyped
};

@interface KVParkedTextField()

@property (nonatomic, strong) NSString *prevText;
@property (nonatomic, assign) KVTypingState typingState;

@end

@implementation KVParkedTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UIFont *boldfFont = [self bold:self.font];
    if (boldfFont) {
        self.parkedTextFont = boldfFont;
    } else {
        self.parkedTextFont = self.font;
    }
    
    self.parkedTextColor = self.textColor;
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.text = @"";
    self.prevText = @"";
    
    self.typingState = KVTypingStart;
}

#pragma mark - Utils

- (UIFont *)bold:(UIFont *)font {
    UIFontDescriptor *descriptor = [font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    return [UIFont fontWithDescriptor:descriptor size:0];
}

- (void)textChanged:(KVParkedTextField *)sender {
    switch (self.typingState) {
        case KVTypingStart:
        {
            if (self.text.length > 0) {
                self.text = [NSString stringWithFormat:@"%@%@", self.typedText, self.parkedText];
                [self updateAttributedText:self.text];
                self.prevText = self.text;
                [self gotoBeginningOfParkedText];
                self.typingState = KVTypingTyped;
            }
            break;
        }
        case KVTypingTyped:
        {
            if ([self.text isEqualToString:self.parkedText]) {
                self.typingState = KVTypingStart;
                self.text = @"";
                return;
            }
            
            if ([self.text hasSuffix:self.parkedText]) {
                self.prevText = self.text;
            }
            
            [self updateAttributedText:self.prevText];
            [self gotoBeginningOfParkedText];
            
            break;
        }
        default:
            break;
    }
}

- (void)updateAttributedText:(NSString *)text {
    NSRange parkedTextRange = [text rangeOfString:self.parkedText options:NSBackwardsSearch];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:[self parkedTextAttributes] range:parkedTextRange];
    self.attributedText = attributedString;
}

- (void)gotoBeginningOfParkedText {
    UITextPosition *position = [self beginningOfParkedText];
    if (position) {
        [self gotoTextPosition:position];
    }
}

- (void)gotoTextPosition:(UITextPosition *)position {
    self.selectedTextRange = [self textRangeFromPosition:position toPosition:position];
}


#pragma mark - Getters

- (NSString *)typedText {
    NSString *text = self.text;
    if (!text) {
        return @"";
    }
    
    if ([text hasSuffix:self.parkedText]) {
        return [text substringToIndex:(-self.parkedText.length)];
    } else {
        return text;
    }
}

- (NSDictionary *)parkedTextAttributes {
    return @{
             NSFontAttributeName: self.parkedTextFont,
             NSForegroundColorAttributeName: self.parkedTextColor
             };
}

- (UITextPosition *)beginningOfParkedText {
    return [self positionFromPosition:self.endOfDocument offset:(-self.parkedText.length)];
}

#pragma mark - Setters

- (void)setParkedText:(NSString *)parkedText {
    NSString *text = self.text;
    
    if (!text) {
        return;
    }
    
    if (text.length > 0) {
        NSString *typed = [text substringToIndex:(-self.parkedText.length)];
        text = [NSString stringWithFormat:@"%@%@", typed, parkedText];
        self.prevText = text;
        _parkedText = parkedText;
        
        [self textChanged:self];
    } else {
        _parkedText = parkedText;
    }
    
    self.placeholder = [NSString stringWithFormat:@"%@%@", self.placeholderText, parkedText];
}

- (void)setTypedText:(NSString *)typedText {
    self.text = [NSString stringWithFormat:@"%@%@", typedText, self.parkedText];
    [self textChanged:self];
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    self.placeholder = [NSString stringWithFormat:@"%@%@", self.placeholderText, self.parkedText];
}

- (void)setPlaceholder:(NSString *)placeholder {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:placeholder];
    NSRange parkedTextRange = NSMakeRange(self.placeholderText.length, self.parkedText.length);
    if ([placeholder hasSuffix:self.parkedText]) {
        [attributedString addAttributes:[self parkedTextAttributes] range:parkedTextRange];
        self.attributedPlaceholder = attributedString;
    }
}

@end
