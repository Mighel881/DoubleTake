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
