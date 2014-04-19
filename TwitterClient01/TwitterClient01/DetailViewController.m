//
//  DetailViewController.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/19/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *nameView;//名前を後から変えるとエラーが起きる。この文章を消して、connectioninspectorでのconnectを消す。
@property (weak, nonatomic) IBOutlet UITextView *textView;//結びつきの大切さ。
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//@property NSString *name; //受け取り口。
//@property NSString *text; //受け取るための箱が必要になってくる。
//@property UIImageView *image;

@end

@implementation DetailViewController

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
    self.navigationItem.title = @"Detail View";
    self.imageView.image = self.image;
    NSLog(@"name:%@",self.name);
    self.nameView.text = self.name;
    self.textView.text = self.text;

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

- (IBAction)retweetAction:(id)sender {
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",self.idStr ];
    NSURL *url = [NSURL URLWithString:urlString];
    SLRequest *request =[SLRequest requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodPOST
                                                     URL:url
                                              parameters:nil];
    [request setAccount:account];
    
    UIApplication *application =[UIApplication sharedApplication];//共通で使える
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,
                                         NSHTTPURLResponse *urlResponse,
                                         NSError *error){
        
        if(responseData){
            NSInteger statusCode = urlResponse.statusCode;
            if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
             NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingMutableContainers
                                                  error:NULL];
                NSLog(@"[Success!!] Createrd Tweet with ID: %@",postResponseData[@"id_str"]);
            }
            else{
                NSLog(@"[ERROR] Server responded: status code %d %@",statusCode,
                      [NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
            }
        }else{
            NSLog(@"[Error] An error occuerd while posting: %@",[error localizedDescription]);
                 
        }
        dispatch_async(dispatch_get_main_queue(),^{ //重たい処理と同時にできる。
            UIApplication *application = [UIApplication sharedApplication];//visible indicatar
            application.networkActivityIndicatorVisible = NO;
        });
    }];
    

    
}


@end
