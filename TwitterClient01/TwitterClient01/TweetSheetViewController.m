//
//  TweetSheetViewController.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/20/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "TweetSheetViewController.h"

@interface TweetSheetViewController ()

@property NSArray *twitterAccounts;
@property NSString *httpErrorMessege;



@end

@implementation TweetSheetViewController

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
    // Do any additional setup after loading the view.
   
    /*
    UIButton *tweetButton =[UIButton buttonWithType:UIButtonTypeCustom];
    tweetButton.frame = CGRectMake(44,420, 80, 30);
    tweetButton.backgroundColor = [UIColor redColor];
    tweetButton.titleLabel.font = [UIFont systemFontOfSize:14]; //書式とサイズで対応
    [tweetButton setTitle:@"Tweet" forState:UIControlStateNormal];
    [tweetButton setTitle:@"Done" forState:UIControlStateHighlighted];
    [tweetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tweetButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [tweetButton addTarget:self
                    action:@selector(tweetAction:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:tweetButton];
    
    UIButton *editDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editDoneButton.frame = CGRectMake(44, 20, 120, 30);
    editDoneButton.backgroundColor = [UIColor redColor];
    editDoneButton.titleLabel.font = [UIFont systemFontOfSize:14]; //書式とサイズで対応
    [editDoneButton setTitle:@"Close Keboard" forState:UIControlStateNormal];
    [editDoneButton setTitle:@"Done" forState:UIControlStateHighlighted];
    [editDoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editDoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [tweetButton addTarget:self
                    action:@selector(editEndAction:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:editDoneButton];
    
    UIButton *backHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeButton.frame = CGRectMake(190, 20, 120, 30);
    backHomeButton.backgroundColor = [UIColor redColor];
    backHomeButton.titleLabel.font = [UIFont systemFontOfSize:14]; //書式とサイズで対応
    [backHomeButton setTitle:@"Back home" forState:UIControlStateNormal];
    [backHomeButton setTitle:@"Done" forState:UIControlStateHighlighted];
    [backHomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backHomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    NSLog(@"%@",backHomeButton.titleLabel.text);
    [tweetButton addTarget:self
                    action:@selector(cancelAction:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backHomeButton];
     */

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)tweetAction:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    NSString *tweetString = self.tweetTextView.text;
    NSLog(@"アイで %@",self.identifier);
    NSLog(@"アカウント %@",account);
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
    NSDictionary *params = @{@"status" : tweetString};
    NSLog(@"サイト %@",url);
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url
                                               parameters:params];
   //UIImage *image = [UIImage imageNamed:@"testIon.png"];
   // NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
   // NSData *imageData = UIImagePNGRepresentation(image);
   // [request addMultipartData:imageData
   //                  withName:@"medial"
   //                      type:@"image/png"
   //                 filename:(@"testIcon.png")];
    
    request.account = account;
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,
                                         NSHTTPURLResponse *urlResponse,
                                         NSError *error) {
        if(responseData){
            self.httpErrorMessege = nil;
            if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingMutableContainers
                                                  error:NULL];
                NSLog(@"[成功！]Created Tweet with ID: %@",postResponseData[@"id_str"]);
            }
            else{
                self.httpErrorMessege =
                [NSString stringWithFormat:@"The response status code is %d",
                 urlResponse.statusCode];
                NSLog(@"HTTP Error : %@", self.httpErrorMessege);
            }
        }
        dispatch_async(dispatch_get_main_queue(),^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
            [self dismissViewControllerAnimated:YES
                                     completion:^{
                                         NSLog(@"Tweet sheet has been dismissed");
                                     }];
        });
    }];
    
     
}



- (IBAction)editEndAction:(id)sender {
 [self.tweetTextView resignFirstResponder];//キーボードを閉じる
    NSLog(@"edit pass");
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];//Animation 消える
    NSLog(@"cancel pass");
}












@end
