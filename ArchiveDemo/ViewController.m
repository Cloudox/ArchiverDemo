//
//  ViewController.m
//  ArchiveDemo
//
//  Created by Cloudox on 2017/2/8.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 归档单个对象-----------------------
    NSString *homeDirectory = NSHomeDirectory();// 根目录
    NSString *demoPath = [homeDirectory stringByAppendingPathComponent:@"demo.archiver"];// 添加存储的文件名
    BOOL flag = [NSKeyedArchiver archiveRootObject:@"Cloudox" toFile:demoPath];// 归档一个字符串，并返回成功与否的标记
    
    if (flag) NSLog(@"归档成功");
    
    NSLog(@"解档后为：%@", [NSKeyedUnarchiver unarchiveObjectWithFile:demoPath]);
    // ----------------------------------
    
    // 归档多个对象------------------------
    NSString *name = @"Cloudox";
    NSInteger age = 24;
    // 路径
    NSString *multiPath = [homeDirectory stringByAppendingPathComponent:@"multi.archiver"];
    // 存储多个对象的容器
    NSMutableData *multiData = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *multiArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:multiData];
    [multiArchiver encodeObject:name forKey:@"name"];
    [multiArchiver encodeInteger:age forKey:@"age"];
    [multiArchiver finishEncoding];// 结束对多个对象的归档
    [multiData writeToFile:multiPath atomically:YES];
    
    // 解档
    // 存储解档后多个对象的容器
    NSMutableData *unMultiData = [[NSMutableData alloc] initWithContentsOfFile:multiPath];
    NSKeyedUnarchiver *multiUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unMultiData];
    NSString *unName = [multiUnarchiver decodeObjectForKey:@"name"];
    NSInteger unAge = [multiUnarchiver decodeIntegerForKey:@"age"];
    [multiUnarchiver finishDecoding];// 结束对多个对象的解档
    NSLog(@"多对象解档后为：%@的年龄为%ld", unName, unAge);
    // ----------------------------------
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
