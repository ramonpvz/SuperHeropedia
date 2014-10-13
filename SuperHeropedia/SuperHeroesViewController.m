//
//  ViewController.m
//  SuperHeropedia
//
//  Created by GLBMXM0002 on 10/13/14.
//  Copyright (c) 2014 asda. All rights reserved.
//

#import "SuperHeroesViewController.h"

@interface SuperHeroesViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *superHeroes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SuperHeroesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *supermanDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Superman", @"name", @"Krypton", @"home", nil];
//    NSLog(@"%@", [supermanDictionary objectForKey:@"name"]);
//    NSLog(@"%@", [supermanDictionary objectForKey:@"home"]);
    
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * connectionError) {
        NSLog(@"%@", connectionError);
        NSString *jsonString =[[NSString alloc]  initWithData:data encoding: NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        NSError *jsonError = nil;
        self.superHeroes =[NSJSONSerialization JSONObjectWithData:data options:0 error: &jsonError];
        [self.tableView reloadData]; // INSIDE THE BLOCK!!!
        NSLog(@"Conn error: : %@", connectionError);
        NSLog(@"JSON error: %@", jsonError);
    }];

}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.superHeroes.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *superHero = [self.superHeroes objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];
    cell.textLabel.text = [superHero objectForKey:@"name"];
    cell.detailTextLabel.text = [superHero objectForKey:@"description"];
    return cell;
}

@end
