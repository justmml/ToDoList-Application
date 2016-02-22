//
//  ViewController.m
//  ToDoList
//
//  Created by Mac on 04.02.16.
//  Copyright © 2016 justmml. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *ButtonSave;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    
    if (self.isDetail) {
        self.textField.text = self.eventInfo;

        self.textField.userInteractionEnabled = NO;
        self.datePicker.userInteractionEnabled = NO;
        self.ButtonSave.alpha = 0;
        
        [self performSelector:@selector(setDatePickerValueWithAnimation) withObject:nil afterDelay:0.5];
    }
    
    else {
    self.ButtonSave.userInteractionEnabled = NO;
    self.datePicker.minimumDate = [NSDate date];
    [self.datePicker addTarget:self action:@selector(datePickerValueChange)
              forControlEvents:UIControlEventValueChanged];
    
    
    [self textField].enabled = YES;
    [super viewDidLoad];
    
    [super viewDidLoad];
    [self.ButtonSave addTarget:self action:@selector(save)
              forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:
                                          self action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
    }
}

- (void) setDatePickerValueWithAnimation {
    
    [self.datePicker setDate:self.eventDate animated:YES];
    
}




- (void) datePickerValueChange{
    
    self.eventDate = self.datePicker.date;
    
    NSLog(@"self.eventDate %@", self.eventDate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleEndEditing{
    
    if ([self.textField isEqual:self.textField]) {
        if ([self.textField.text length] !=0) {
            [self.view endEditing:YES];
            self.ButtonSave.userInteractionEnabled = YES;
        }
        
        
        else {
            
            [self showAlertWithMessage:@"Для сохранения события введите значение в текстовое поле"];
            
        }
    
    }}

- (void) save {
    
    if (self.eventDate) {
        
        if ([self.eventDate compare:[NSDate date]] == NSOrderedSame) {
            [self showAlertWithMessage:@"Дата события не может совпадать с текущей датой"];
        }
             
             else if ([self.eventDate compare:[NSDate date]] == NSOrderedAscending){
            
            [self showAlertWithMessage:@"Дата события не может быть ранее текущей даты"];
        }
                       
        else {
                [self setNotification];
        }
        
        
    }
    
    else {
        [self showAlertWithMessage:@"Для сохранения события измените значение даты на более позднее"];
    }
    
}

- (void) setNotification{
    
    NSString * eventInfo = self.textField.text;
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString * eventDate = [formater stringFromDate:self.eventDate];
    
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           eventInfo, @"eventInfo",
                           eventDate, @"eventDate", nil];
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.userInfo = dict;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewEvent" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{


    if ([self.textField isEqual:self.textField]) {
        if ([self.textField.text length] !=0) {
            [self.textField resignFirstResponder];
            self.ButtonSave.userInteractionEnabled = YES;
            return YES;
        }
        
    
    else {
        
        [self showAlertWithMessage:@"Для сохранения события введите значение в текстовое поле"];
        
    }
}

    return NO;
}


- (void) showAlertWithMessage : (NSString *) message{
    
    /*UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"Внимание!" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];*/
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];//deprecated method
    
    [alert show];
    
}



@end
