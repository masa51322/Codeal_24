//
//  TimeLineTableViewController.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "TimeLineTableViewController.h"

@interface TimeLineTableViewController ()

@property dispatch_queue_t mainQueue;
@property dispatch_queue_t imageQueue;
@property NSString *httpErrorMessege;
@property NSArray *timeLineData;
//@property CGFloat paddingTop,paddingDown;

@end

@implementation TimeLineTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[TimeLineCell  class] forCellReuseIdentifier:@"TimeLineCell"];
    self.mainQueue = dispatch_get_main_queue();
    self.imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    NSLog(@"identifier = %@", self.identifier);
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                  @"/1.1/statuses/home_timeline.json"];
    NSDictionary *params = @{@"count" : @"100",
                             @"trim_user" : @"0",
                             @"include_entities" : @"0"};
    SLRequest *request =[SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url
                                               parameters:params];
    [request setAccount:account];
    
    UIApplication *application =[UIApplication sharedApplication];//共通で使える
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,
                                    NSHTTPURLResponse *urlResponse,
                                         NSError *error){
        
        if(responseData){
            self.httpErrorMessege =nil;
            if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
                NSError *jsonError;
                self.timeLineData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                if(self.timeLineData){
                    NSLog(@"Timeline Response: %@\n", self.timeLineData);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"pass");
                        [self.tableView reloadData];
                    });
                                   }
                                   else{
                                       NSLog(@"JSON Error : %@",[jsonError localizedDescription]);
                                       }
                                   }
                                   else{
                                       self.httpErrorMessege =
                                       [NSString stringWithFormat:@"The response status code is %d",
                                        urlResponse.statusCode];
                                       NSLog(@"HTTP Error: %@" ,self.httpErrorMessege);
                                   }
                                   
                                }
        dispatch_async(self.mainQueue,^{ //重たい処理と同時にできる。
                        UIApplication *application = [UIApplication sharedApplication];//visible indicatar
                        application.networkActivityIndicatorVisible = NO;
                    });
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(!self.timeLineData){
    return 1;
    }else{
        return [self.timeLineData count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLineCell"
                                                         forIndexPath:indexPath];
    
    // Configure the cell...

    if (self.httpErrorMessege) { //並列処理ならではの書き方。
        cell.tweeTextLabel.text = self.httpErrorMessege;
        cell.tweetTextLabelHeight =  24;
    }else if (!self.timeLineData){
        cell.tweeTextLabel.text = @"Loading...";
        cell.tweetTextLabelHeight =  24;
    }else{
        NSString *name = self.timeLineData[indexPath.row][@"user"][@"screen_name"];
        
        NSLog(@"エラー1 %@",name);
        NSString *text = [[self.timeLineData objectAtIndex:indexPath.row]
                          objectForKey:@"text"];

        //NSString *name = self.timeLineData[indexPath.row][@"user"][@"screen_name"];
    
        //カスタム競るを使わない場合は以下の２行
        //cell.textLabel.font =[UIFont systemFontOfSize:14];
        //cell.textLabel.numberOfLines =0;
        CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:16]
                            constrainedToSize:CGSizeMake(300,10000)
                                lineBreakMode:NSLineBreakByCharWrapping];
        
        cell.tweetTextLabelHeight = labelSize.height;
        cell.tweeTextLabel.text = text;
        
        //カスタム競るを使わない場合は以下の２行
        //cell.textLabel.font =[UIFont systemFontOfSize:12];
        //cell.textLabel.numberOfLines = name;
    
        NSLog(@"エラー2 %@",name);
        cell.nameLabel.text = name;
        cell.profileImageView.image =[UIImage imageNamed:@"blank.png"];
        
        
        
        
        dispatch_async(self.imageQueue,^{
            NSString *url;
            NSDictionary *tweetDictionary = [self.timeLineData objectAtIndex:indexPath.row];
            
            if([[tweetDictionary allKeys] containsObject:@"retweeted_status"]) {
                //リツイートの場合はretweeted_statusキー項目が存在する。
            
                url = [[[tweetDictionary objectForKey:@"retweeted_status"]
                        objectForKey:@"user"]
                       objectForKey:@"profile_image_url"];
            }else {
                url = [[tweetDictionary objectForKey:@"user"]
                       objectForKey:@"profile_image_url"];
            }
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            dispatch_async(self.mainQueue,^ {
                UIApplication *application = [UIApplication sharedApplication];
                application.networkActivityIndicatorVisible = NO;
                UIImage *image = [[UIImage alloc]initWithData:data];
                cell.profileImageView.image = image;
                [cell setNeedsLayout];//tableが夏期変わる。
            });
        });
    }
    
        return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content =
    [[self.timeLineData objectAtIndex:[indexPath row]] objectForKey:@"text"];
    CGSize labelsize = [content sizeWithFont:[UIFont systemFontOfSize:16] //訂正
                           constrainedToSize:CGSizeMake(300, 1000)
                               lineBreakMode:NSLineBreakByCharWrapping ];
    return labelsize.height + 35;
    
}


    /*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//didselectrowatlindexpath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineCell *cell = (TimeLineCell *)[tableView cellForRowAtIndexPath:indexPath]; //clickした場所のindexPath
    
    DetailViewController *detailViewController = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"DetailViewController"];//staryboardIDを書く。
    
    detailViewController.name = cell.nameLabel.text;
    detailViewController.text = cell.tweeTextLabel.text;
    detailViewController.image = cell.profileImageView.image;
    detailViewController.identifier = self.identifier;
    detailViewController.idStr = self.timeLineData[indexPath.row][@"id_str"];
    NSLog(@"ここ%@",detailViewController.idStr);
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}




@end
