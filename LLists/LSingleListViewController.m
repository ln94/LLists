//
//  LSingleListViewController.m
//  
//
//  Created by Lana Shatonova on 29/10/16.
//
//

#import "LSingleListViewController.h"
#import "LSingleListViewCell.h"


@interface LSingleListViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) List *list;

@property (nonatomic) NSFetchedResultsController<Item *> *items;

@property (nonatomic) UITextView *editingTextView;

@end

@implementation LSingleListViewController

- (instancetype)initWithList:(List *)list {
    self = [super init];
    if (!self) return nil;
    
    self.list = list;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // DEBUG:
//    Item *item = [Item create];
//    item.text = @"Sup cunts";
//    [item addListsObject:self.list];
    
    // Fetch Results Controller
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[Item class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ IN lists" argumentArray:@[self.list]];
    self.items = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:request];
    [self.items performFetch];
    
    // Table View
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[LSingleListViewCell class] forCellReuseIdentifier:[LSingleListViewCell reuseIdentifier]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //  Editing Text View
    self.editingTextView = [[UITextView alloc] initInSuperview:self.view];
    self.editingTextView.tag = -1;
    self.editingTextView.backgroundColor = C_CLEAR;
    self.editingTextView.textColor = C_CLEAR;
    self.editingTextView.font = F_MAIN_TEXT;
    self.editingTextView.textContainerInset = i(kTextContainerInsetY, kPaddingTiny, kTextContainerInsetY, 0);
    self.editingTextView.hidden = YES;
    self.editingTextView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSingleListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LSingleListViewCell reuseIdentifier]];
    cell.item = [self.items objectAtIndexPath:indexPath];
    
//    [cell setText:self.text[indexPath.row] forEditingCell:(self.editingTextView.tag == indexPath.row)];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LSingleListViewCell rowHeightForText:[self.items objectAtIndexPath:indexPath].text];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LSingleListViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    self.editingTextView.frame = [cell textViewFrame];
//    self.editingTextView.tag = indexPath.row;
////    self.editingTextView.text = self.text[indexPath.row];
//    self.editingTextView.hidden = NO;
//    [self.editingTextView becomeFirstResponder];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.editingTextView resignFirstResponder];
    self.editingTextView.hidden = YES;
    
    // Reload last edited cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.editingTextView.tag inSection:0];
    self.editingTextView.tag = -1;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (newText.length >= kTextViewTextLengthMax) {
        return NO;
    }
    
//    self.text[textView.tag] = newText;
    
    CGFloat newHeight = [LSingleListViewCell rowHeightForText:newText];
    
    if (newHeight != self.editingTextView.height) {
        // Update whole table
        self.editingTextView.height = newHeight;
        [self.tableView reloadData];
    }
    else {
        // Update only cell
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:textView.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    return YES;
}

@end
