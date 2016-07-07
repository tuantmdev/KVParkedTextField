//
//  ViewController.m
//  Example
//
//  Created by Tran Manh Tuan on 7/7/16.
//  Copyright © 2016 Citigo. All rights reserved.
//

#import "ViewController.h"
#import "KVParkedTextField.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet KVParkedTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Customize parked textfield
    self.textField.parkedText = @".kiotviet.com";
    self.textField.placeholderText = @"kiot-name";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
