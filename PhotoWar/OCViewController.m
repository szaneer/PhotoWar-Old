//
//  OCViewController.m
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

#import "OCViewController.h"
#import "RapidAPISDK.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RapidConnect *rapid = [[RapidConnect alloc] initWithProjectName:@"HackHunt" andToken:@"b575baee-8f4b-44d7-acd9-f399e1ca3b95"];
    
    [rapid callPackage:@"MicrosoftComputerVision" block:@"tagImage" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                    @"5bea5ab175934b5985ab3a3ecc083702", @"subscriptionKey",
                                                                                    @"test.jpg", @"image",
                                                                                    
                                                                                    nil]
               success:^(NSDictionary *responseDict){
                   NSLog(@"%@",responseDict);
               }failure:^(NSError *error){
                   NSLog(@"%@",[error localizedDescription]);
               }];
}
     // Do any additional setup after loading the view.
     

     
     - (void)didReceiveMemoryWarning {
         [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }
     
     /*
      #pragma mark - Navigation
      
      // In a storyboard-based application, you will often want to do a little preparation before navigation
      - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
      // Get the new view controller using [segue destinationViewController].
      // Pass the selected object to the new view controller.
      }
      */
     
     @end
