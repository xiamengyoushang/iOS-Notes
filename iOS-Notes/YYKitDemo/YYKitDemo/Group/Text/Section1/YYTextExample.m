//
//  YYTextExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYTextExample.h"

@interface YYTextExample ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation YYTextExample

#pragma mark - Initialize
- (void)InitializeData{
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"Text Attributes 1" class:@"YYTextAttributeExample"];
    [self addCell:@"Text Attributes 2" class:@"YYTextTagExample"];
    [self addCell:@"Text Attachments" class:@"YYTextAttachmentExample"];
    [self addCell:@"Text Parser (Markdown)" class:@"YYTextMarkdownExample"];
    [self addCell:@"Text Parser (Emoticon)" class:@"YYTextEmoticonExample"];
    [self addCell:@"Text Binding" class:@"YYTextBindingExample"];
    [self addCell:@"Copy and Paste" class:@"YYTextCopyPasteExample"];
    [self addCell:@"Undo and Redo" class:@"YYTextUndoRedoExample"];
    [self addCell:@"Ruby Annotation" class:@"YYTextRubyExample"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
