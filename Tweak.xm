//Messages
static NSString *contactName;
static NSNumber *total;

@interface CKAvatarContactNameCollectionReusableView : UIView
@property (nonatomic,retain) UILabel * titleLabel;
@end

%hook CKAvatarContactNameCollectionReusableView

-(void)layoutSubviews {
    contactName = nil;
    if(self.titleLabel != nil){
      contactName = self.titleLabel.text;
    }

    %orig;
}

%end

@interface CKAvatarPickerViewController : UIViewController
@end

%hook CKAvatarPickerViewController
-(void)viewWillLayoutSubviews{
  %orig;
  total = @([self.view.layer.sublayers count]);
}
%end

%hook CKMessageEntryContentView

-(void)setPlaceholderText:(NSString *)arg1 {
  if (contactName != nil && [total intValue] == 2) {
    %orig(contactName);
    } else {
      %orig(@"Group Message");
    }
}

%end
//End Messages
//Start Messenger
static NSString *messengerContact;

@interface MNMessagesTitleView : UILabel
@property (nonatomic,retain) NSString *title;
@end

%hook MNMessagesTitleView
-(void)setTitle:(NSString *)arg1 {
  %orig;
  messengerContact = self.title;
}
%end

@interface MNGrowingTextView : UITextView
@end

%hook MNGrowingTextView
-(void)setPlaceholderText:(NSString *)arg1{
  %orig(messengerContact);
}
%end
//End Messenger (That was easy...)
//Start Instagram
static NSString *igContact;

@interface IGUsernameTitleView : UIView
@end

%hook IGUsernameTitleView
-(void)layoutSubviews{
  %orig;
  igContact = MSHookIvar<NSString*>(self, "_username");
}
%end

@interface IGDirectComposer : UIView
@end

%hook IGDirectComposer
-(void)didMoveToWindow{
  %orig;
  MSHookIvar<UILabel*>(self, "_placeholderLabel").text = igContact;
}
%end
//End Instagram
//Start Twitter
@interface TFNTitleView : UIView
@property (nonatomic,retain) NSString *title;
@end
static NSString *twitUser;
%hook TFNTitleView
-(void)setTitle:(NSString *)arg1{
  %orig;
  twitUser = self.title;
}
%end

@interface T1DirectMessageComposeTextView : UITextView
@property (nonatomic,retain) NSString *placeholderText;
@end

%hook T1DirectMessageComposeTextView
-(void)setPlaceholderText:(NSString *)arg1{
  %orig(twitUser);
}
%end
//End Instagram
