//
//  ViewController.m
//  testCoreData
//
//  Created by mediawork on 16/7/24.
//  Copyright © 2016年 BEN. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TestTitle.h"
#import "PersonT.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UITextField *textFieldName;
@property(nonatomic, strong)UITextField *textFieldAge;
@property(nonatomic, strong)UIButton *conformBtn;
@property(nonatomic, strong)UIButton *fetchBtn;
@property(nonatomic, strong)UIButton *deleteFirstObjBtn;
@property(nonatomic, strong)UIButton *getFirstObjBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 10 * 2, SCREEN_HEIGHT / 10)];
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];
    
    self.textFieldAge = [[UITextField alloc]initWithFrame:CGRectMake(10, self.textField.frame.origin.y + self.textField.frame.size.height + 30, SCREEN_WIDTH - 10 * 2, SCREEN_HEIGHT / 10)];
    self.textFieldAge.backgroundColor = [UIColor grayColor];
    self.textFieldAge.placeholder = @"Age";
    [self.view addSubview:self.textFieldAge];
    
    self.textFieldName = [[UITextField alloc]initWithFrame:CGRectMake(10, self.textFieldAge.frame.origin.y + self.textFieldAge.frame.size.height + 30, SCREEN_WIDTH - 10 * 2, SCREEN_HEIGHT / 10)];
    self.textFieldName.backgroundColor = [UIColor grayColor];
    self.textFieldName.placeholder = @"Name";
    [self.view addSubview:self.textFieldName];
    
    self.conformBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, self.textFieldName.frame.origin.y + self.textFieldName.frame.size.height + 30, SCREEN_WIDTH - 30 * 2, 50)];
    
    [self.conformBtn setTitle:@"OK!" forState:UIControlStateNormal];
    [self.conformBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.conformBtn.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.conformBtn];
    
    
    self.fetchBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, self.conformBtn.frame.origin.y + self.conformBtn.frame.size.height + 30, SCREEN_WIDTH - 30 * 2, 50)];
    
    [self.fetchBtn setTitle:@"Fetch!" forState:UIControlStateNormal];
    [self.fetchBtn addTarget:self action:@selector(fetchEntities) forControlEvents:UIControlEventTouchUpInside];
    self.fetchBtn.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.fetchBtn];
    
    self.deleteFirstObjBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, self.fetchBtn.frame.origin.y + self.fetchBtn.frame.size.height + 30, SCREEN_WIDTH - 30 * 2, 50)];
    
    [self.deleteFirstObjBtn setTitle:@"Delete!" forState:UIControlStateNormal];
    [self.deleteFirstObjBtn addTarget:self action:@selector(deleteFirstAction) forControlEvents:UIControlEventTouchUpInside];
    self.deleteFirstObjBtn.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.deleteFirstObjBtn];
    
    self.getFirstObjBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, self.deleteFirstObjBtn.frame.origin.y + self.deleteFirstObjBtn.frame.size.height + 30, SCREEN_WIDTH - 30 * 2, 50)];
    
    [self.getFirstObjBtn setTitle:@"getFirst!" forState:UIControlStateNormal];
    [self.getFirstObjBtn addTarget:self action:@selector(getFirst) forControlEvents:UIControlEventTouchUpInside];
    self.getFirstObjBtn.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.getFirstObjBtn];
    
}

-(void)btnAction
{
    NSLog(@"\n\n\n Button pressed! /n/n/n");
    NSLog(@" self.textField.text: %@",self.textField.text);
//    TestTitle *newTitle = [TestTitle MR_createEntity];
//    newTitle.title = self.textField.text.length>0 ? self.textField.text : @"default";
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
        
                
        TestTitle *newTitle = [TestTitle MR_createEntityInContext:localContext];
        newTitle.title = self.textField.text ? self.textField.text : @"default";
        PersonT *person = [[PersonT alloc]init];
        person.age = @(self.textFieldAge.text.integerValue);
        person.name = self.textFieldName.text;
        
        [localContext MR_saveToPersistentStoreAndWait];
    }completion:^(BOOL success, NSError *error){
        NSLog(@" BOOL success: %@, NSError *error :%@",@(success),error);
    }];
    
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error){
//        NSLog(@" BOOL success: %@, NSError *error :%@",@(contextDidSave),error);
//    }];
}

-(void)fetchEntities
{
    NSLog(@"\n\n all:");
    NSArray *titls = [TestTitle MR_findAll];
    NSLog(@"count: %@",@(titls.count));
    for (TestTitle *title in titls)
    {
        PersonT *person = title.person;
        NSLog(@"title: %@  age:%@  name: %@",title.title,person.age,person.name);
        
    }
   
}

- (void)deleteFirstAction
{
    TestTitle *first = (TestTitle *)[TestTitle MR_findFirst];
    NSLog(@"\n \n first: %@",first.title);
    ;
    NSLog(@"\n \n delete success? %@",@([first MR_deleteEntity]));
}

- (void)getFirst
{
    TestTitle *first = (TestTitle *)[TestTitle MR_findFirst];
    NSLog(@"\n \n first: %@",first.title);
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end














