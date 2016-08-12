//
//  ViewController.m
//  coredatademo
//
//  Created by yong on 16/8/5.
//  Copyright © 2016年 iosYong. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Dog.h"
#import "AppDelegate.h"
@interface ViewController ()
{
    AppDelegate *app;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = [UIApplication sharedApplication].delegate;
    [self createButtons];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)createButtons
{
    NSArray *array = @[@"增",@"删",@"改",@"查"];
    for(int i = 0 ; i < 4;  i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30+i*60, 100, 40, 40);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
    }
}
-(void)buttonClick:(UIButton *)button{
    switch (button.tag) {
        case 0:
            [self coreDataAdd];
            break;
        case 1:
            [self coreDataDelete];
            break;
        case 2:
            [self coreDataUpdate];
            break;
        case 3:
            [self coreDataSearch];
            break;
            
        default:
            break;
    }
}
-(void)coreDataAdd
{
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    dog.name = [NSString stringWithFormat:@"花花%d",arc4random()%100];
    dog.sex = (arc4random()%100)%2== 0?@"公":@"母";
    dog.age = [NSString stringWithFormat:@"%d",arc4random()%100];
    NSLog(@"%@",[NSString stringWithFormat:@"新增了一条数据%@",dog.name]);
    [app.managedObjectContext save:nil];
}
- (void)coreDataDelete
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    if(array.count)
    {
        Dog *newDog = [array lastObject];
        [app.managedObjectContext deleteObject:newDog];
        [app.managedObjectContext save:nil];
        NSLog(@"删除完成,还剩%lu个",(unsigned long)array.count-1);
    }
    else
    {
        NSLog(@"没有数据啦");
    }
}
- (void)coreDataUpdate
{
    //读取类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    //建立请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    //建立检索条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"花花10"];
    [request setPredicate:predicate];
    //遍历所有数据，获取所有信息，存到array
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    if(array.count)
    {
        for(Dog *newDog in array)
        {
            newDog.name = @"小白107";
        }
        //保存
        [app.managedObjectContext save:nil];
        NSLog(@"修改完成");
    }
    else
    {
        NSLog(@"无检索结果");
    }
    
}
- (void)coreDataSearch
{
    //读取类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dog" inManagedObjectContext:app.managedObjectContext];
    //建立请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //建立请求的是哪个类
    [request setEntity:entity];
    
    //建立检索条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"花花10"];
    [request setPredicate:predicate];
    
    //遍历所有狗，获取所有信息，存到array
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    if(array.count)
    {
        NSLog(@"找到了一共有%lu个",(unsigned long)array.count);
    }
    else
    {
        NSLog(@"无检索结果");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
