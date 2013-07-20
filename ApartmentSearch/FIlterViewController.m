//
//  FilterViewController.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)searchTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
