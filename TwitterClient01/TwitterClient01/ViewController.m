//
//  ViewController.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *tweetActionButton;
@property (weak, nonatomic) IBOutlet UILabel *accountDisplayLabel;


@property ACAccountStore *accountStore;//ゲッター、セッターができている。
@property NSString *identifier;
@property NSArray *twitterAccounts; //accountDisplayLabelはストーリーボード


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterType
                                               options:NULL
                                            completion:^(BOOL granted, NSError *error){
                                                
                                                if(granted){ //認証されたら！
                                                    self.twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];//
                                                    NSLog(@"あいい:%@",self.twitterAccounts);
                                                    
                                                    if (self.twitterAccounts.count > 0) {
                                                        
                                                        ACAccount *account = self.twitterAccounts[0];
                                                        self.identifier = account.identifier;//個人ID
                                                        NSLog(@"へいい:%@",self.identifier);
                                                        dispatch_async(dispatch_get_main_queue(), ^{ //User interface の処理
                                                            self.accountDisplayLabel.text = account.username; //Twitter name
                                                        });
                                                    }
                                                    else{ //Twitterのアカウントがない。
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.accountDisplayLabel.text = @"アカウントなし";
                                                            
                                                        });
                                                    }
                                                }
                                                else{ //エラー
                                                    NSLog(@"Account Error: %@",[error localizedDescription]);//localize = japanese
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        self.accountDisplayLabel.text = @"アカウント認証エラー";
                                                        
                                                    });
                                                    
                                                }
                                                
                                            
                                            }];
}

     

- (void)didReceiveMemoryWarning//枠等を変えたかったら、イチからやる。UItextview
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweetAction:(id)sender {//Tweet処理
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        NSString *serviceType = SLServiceTypeTwitter; 
        SLComposeViewController *composeCtl = [SLComposeViewController
                                               composeViewControllerForServiceType:serviceType];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result){
            
            if (result == SLComposeViewControllerResultDone) {
                //登校成功時の処理
            }
        }];
        [self presentViewController:composeCtl animated:YES completion:NULL];
    }
}

- (IBAction)setAccountAction:(id)sender {
    
   UIActionSheet *sheet = [[UIActionSheet alloc] init];
   sheet.delegate = self;
    
   sheet.title = @"選択してください。";
    for (ACAccount *account in self.twitterAccounts){
        [sheet addButtonWithTitle:account.username];
    }
    [sheet addButtonWithTitle:@"キャンセル"];
    sheet.cancelButtonIndex = self.twitterAccounts.count;
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.twitterAccounts.count > 0) { //cancelは配列の最後に入っているので、次のif文を書くことができる。
        if (buttonIndex != self.twitterAccounts.count) {
            ACAccount *account = [self.twitterAccounts objectAtIndex:buttonIndex];
            self.identifier = account.identifier;
            self.accountDisplayLabel.text = account.username;
            NSLog(@"Account set ! %@", account.username);
        }
        else{
            NSLog(@"cancel!");
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{//segueで情報を渡す
    if([[segue identifier] isEqualToString:@"TimeLineSegue"]) {
        NSLog(@"pass");
        TimeLineTableViewController *timeLineTableViewController =
        [segue destinationViewController];
        if ([timeLineTableViewController isKindOfClass:[TimeLineTableViewController class]]){
            timeLineTableViewController.identifier = self.identifier;//情報を受け渡す。
        }
        
    }else if([[segue identifier] isEqualToString:@"TweetSheetSegue"]){
        TweetSheetViewController *tweetSheetViewController =
        [segue destinationViewController];
        if ([tweetSheetViewController isKindOfClass:[TweetSheetViewController class]]){
            tweetSheetViewController.identifier = self.identifier;//情報を受け渡す。
            NSLog(@"セグエ");
        }
    }else if ([[segue identifier] isEqualToString:@"FavoriteTimeLineSegue"]){
        FavoriteTableViewController *favoriteTableViewController =
        [segue destinationViewController];
        if([favoriteTableViewController isKindOfClass:[FavoriteTableViewController class]]){
            favoriteTableViewController.identifier = self.identifier;
            NSLog(@"お気に入り");
        }
    }
}

//アカウントは、配列で保存されている。
//actionは下。labelは上。

@end
