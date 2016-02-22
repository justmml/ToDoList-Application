//
//  ViewController.h
//  ToDoList
//
//  Created by Mac on 04.02.16.
//  Copyright © 2016 justmml. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSDate * eventDate;
@property (nonatomic, strong) NSString * eventInfo;
@property (nonatomic, assign) BOOL isDetail;

@end

