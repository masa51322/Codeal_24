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
    
    NSLog(@"今回　フォロワー:%@　友達:%@",self.followers,self.friends);
    // Do _followersional setup after loading the view.
    self.navigationItem.title = @"Detail View";
    self.imageView.image = self.image;
    self.nameView.text = self.name;
    self.textView.text = self.text;
    //ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    //ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    
    UIButton *firstbutton =[UIButton buttonWithType:UIButtonTypeCustom];//コンビニエンスコントラクタで初期化
    
    int x = [self.followers intValue];//int型に変換
    NSLog(@"%d",x);
    
    //フォロワー数に応じて場合分けを始める。
    //今回は、http://facebook.boo.jp/twitter-user-survey-2012を参考に、日本のユーザの平均値を319人と設定して場合分け。
    
    if(x > 2892) // 2000人以上フォロワーを持つ。全体の10パーセント以下
    {
        x = 80;
        int y = x * (3/2);
        int basePointx = 164 - x;
        int basePointy = 460 - y;
        firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
        firstbutton.backgroundColor = [UIColor redColor];
        firstbutton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20]; //書式とサイズで対応
        [firstbutton setTitle:@"Retweet" forState:UIControlStateNormal];
        [firstbutton setTitle:@"Done" forState:UIControlStateHighlighted];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [firstbutton addTarget:self
                        action:@selector(retweetAction:)
              forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:firstbutton];


        
    
    }else if((1417 < x) && (x <= 2982)){
        
        NSLog(@"%d",x);
        x = 60;
        int y = x * (3/2);
        int basePointx = 164 - x;
        int basePointy = 460 - y;
        firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
        firstbutton.backgroundColor = [UIColor yellowColor];
        firstbutton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:18]; //書式とサイズで対応
        [firstbutton setTitle:@"Retweet" forState:UIControlStateNormal];
        [firstbutton setTitle:@"Done" forState:UIControlStateHighlighted];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [firstbutton addTarget:self
                        action:@selector(retweetAction:)
              forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:firstbutton];

        
    }else if((319 < x) && (x <= 1417)){
        
        x = 50;
        int y = x * (3/2);
        int basePointx = 164 - x;
        int basePointy = 460 - y;
        firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
        firstbutton.backgroundColor = [UIColor greenColor];
        firstbutton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:16]; //書式とサイズで対応
        [firstbutton setTitle:@"Retweet" forState:UIControlStateNormal];
        [firstbutton setTitle:@"Done" forState:UIControlStateHighlighted];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [firstbutton addTarget:self
                        action:@selector(retweetAction:)
              forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:firstbutton];

        
    }else if((198 < x) && (x <= 319)){
        
        x = 40;
        int y = x * (3/2);
        int basePointx = 164 - x;
        int basePointy = 460 - y;
        firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
        firstbutton.backgroundColor = [UIColor lightGrayColor];
        firstbutton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:14]; //書式とサイズで対応
        [firstbutton setTitle:@"Retweet" forState:UIControlStateNormal];
        [firstbutton setTitle:@"Done" forState:UIControlStateHighlighted];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [firstbutton addTarget:self
                        action:@selector(retweetAction:)
              forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:firstbutton];
    }else{
    
        x = 30;
        int y = x * (3/2);
        int basePointx = 164 - x;
        int basePointy = 460 - y;
        firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
        firstbutton.backgroundColor = [UIColor whiteColor];
        firstbutton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:12]; //書式とサイズで対応
        [firstbutton setTitle:@"Retweet" forState:UIControlStateNormal];
        [firstbutton setTitle:@"Done" forState:UIControlStateHighlighted];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [firstbutton addTarget:self
                        action:@selector(retweetAction:)
              forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:firstbutton];

        
        
    }
    
    
    /*
    if (x >= 80) {
        x = 80;
    }
    
    int y = x * (3/2);
    int basePointx = 164 - x;
    int basePointy = 460 - y;
    
    firstbutton.frame = CGRectMake(basePointx, basePointy, x*2, y*2);
    firstbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    firstbutton.backgroundColor = [UIColor redColor];
    [firstbutton setTitle:@"Push!!" forState:UIControlStateNormal];
    [firstbutton setTitle:@"Nice Push!!" forState:UIControlStateHighlighted];
    [firstbutton setTitle:@"Can't use." forState:UIControlStateDisabled];
    [firstbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstbutton setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [firstbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    
    [firstbutton addTarget:self
                    action:@selector(retweetAction:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:firstbutton]
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

- (IBAction)sendFavorite:(id)sender {
    
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/favorites/create.json"];
    NSDictionary *params = @{@"user_id":self.idStr}; //self.identifierは認証への鍵、idStrはID
    NSLog(@"ここ%@",params[@"id"]);
    SLRequest *request =[SLRequest requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodPOST
                                                     URL:url
                                              parameters:params];
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
