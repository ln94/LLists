//
//  LSingleListViewController.m
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSingleListViewController.h"
#import "LSingleListViewCell.h"
#import "LAddItemView.h"


@interface LSingleListViewController () <NSFetchedResultsControllerDelegate, LTextViewDelegate, LShadowViewDelegate, LSwipeCellDelegate>

@property (nonatomic, strong) List *list;

@property (nonatomic) NSFetchedResultsController<Position *> *positions;
@property (nonatomic) NSFetchedResultsController<Item *> *items;

@property (nonatomic) LAddItemView *addItemView;

@property (nonatomic) LTextView *editingTextView;

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
    
    // Header
    [self.header.addButton addTarget:self action:@selector(didPressAddButton)];
    [self.header.backButton addTarget:self action:@selector(didPressBackButton)];
    
    // Fetch Results Controllers
    [self setupPositionFRC];
    
    // Table View
    [self.tableView registerClass:[LSingleListViewCell class] forCellReuseIdentifier:[LSingleListViewCell reuseIdentifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Shadow View
    self.shadowView.delegate = self;
    
    // Empty View
    self.emptyView.text = @"Your List is empty";
    
    //  Editing Text View
    self.editingTextView = [[LTextView alloc] initInSuperview:self.tableView];
    self.editingTextView.tag = -1;
    self.editingTextView.font = F_MAIN_TEXT;
    self.editingTextView.hidden = YES;
    self.editingTextView.lDelegate = self;
    
    // Add Item View
    self.addItemView = [[LAddItemView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kSingleListViewCellMinHeight+kSeparatorBottomLineHeight insets:inset_top(LLists.statusBarHeight)];
    self.addItemView.hidden = YES;
    
    // GR
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didPressBackButton)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    
    [self.view bringSubviewToFront:self.header];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.items.numberOfObjects) {
        self.emptyView.hidden = NO;
        
        run_delayed(0.25, ^{
            [self showAddItemView];
        });
    }
}

- (void)didPressBackButton {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupPositionFRC {
    // Get position
    NSFetchRequest *positionRequest = [NSFetchRequest fetchRequestWithEntity:[Position class]];
    positionRequest.predicate = [NSPredicate predicateWithKey:@"list" value:self.list];
    positionRequest.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    self.positions = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:positionRequest];
    [self.positions performFetch];
    self.positions.delegate = self;
    
    [self setupItemFRC];
}

- (void)setupItemFRC {
    // Update item current position
    for (Position *position in self.positions.fetchedObjects) {
        position.item.currentIndex = position.index;
    }
    
    // Get items
    NSFetchRequest *itemRequest = [NSFetchRequest fetchRequestWithEntity:[Item class]];
    itemRequest.predicate = [NSPredicate predicateWithFormat:@"%@ IN lists" argumentArray:@[self.list]];
    itemRequest.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"currentIndex" ascending:YES];
    self.items = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:itemRequest];
//    self.items.delegate = self;
    [self.items performFetch];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSingleListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LSingleListViewCell reuseIdentifier]];
    cell.backgroundColor = C_CLEAR;
    cell.item = [self.items objectAtIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LSingleListViewCell rowHeightForText:[self.items objectAtIndexPath:indexPath].text];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView setEditing:NO];
    
    if (scrollView.contentOffset.y < -kPaddingSmall && self.header.showingAddButton) {
        [self showAddItemView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [DataStore save];
    
    [self.editingTextView resignFirstResponder];
    self.editingTextView.hidden = YES;
    
    // Reload last edited cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.editingTextView.tag inSection:0];
    self.editingTextView.tag = -1;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (controller == self.positions) {
        [self setupItemFRC];
        [self.tableView reloadData];
        self.emptyView.hidden = self.items.numberOfObjects;
    }
}


#pragma mark - Add List View

- (void)didPressAddButton {
    [self showAddItemView];
}

- (void)showAddItemView {
    // Hide Add Button
    [self.header setShowingAddButton:NO];
    
    // Show Add Item View
    self.addItemView.hidden = NO;
    
    [UIView animateWithDuration:addViewAnimationDuration animations:^{
        self.addItemView.top = self.header.bottom;
        self.shadowView.hidden = NO;
        
    } completion:^(BOOL finished) {
        // Show keyboard
        [self.addItemView.textView becomeFirstResponder];
        
        [self.addItemView setShowingPlusButton:YES completion:nil];
    }];
}

- (void)hideAddItemView:(void (^)())completion {
    // Hide keyboard
    [self.addItemView.textView resignFirstResponder];
    
    // Hide Add Item View
    [self.addItemView setShowingPlusButton:NO completion:^{
        [UIView animateWithDuration:addViewAnimationDuration animations:^{
            self.addItemView.bottom = self.header.bottom;
            self.shadowView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self.addItemView.hidden = YES;
            
            if (completion) {
                completion();
            }
        }];
        
        // Show Add button
        [self.header setShowingAddButton:YES];
    }];
}

- (void)addNewItem {
    if (!self.addItemView.textView.text.isEmpty) {
        // Save new list
        NSInteger position = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
        [ListsManager saveItemWithText:self.addItemView.textView.text onPosition:position inList:self.list];
        
        // Hide and clear Add List View
        [self hideAddItemView:^{
            self.addItemView.textView.text = @"";
        }];
    }
}

#pragma mark - LTextViewDelegate

- (void)textViewShouldBeginEditing:(LTextView *)textView {
    LSingleListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
    [cell setTextViewShowing:NO];
}

- (void)textViewShouldEndEditing:(LTextView *)textView {
    LSingleListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
    [cell setTextViewShowing:YES];
}

- (void)textViewShouldChangeText:(LTextView *)textView to:(NSString *)text {
    [self.items objectAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]].text = text;
}

- (void)textViewShouldChangeHeight:(LTextView *)textView by:(CGFloat)by {
    [self.tableView reloadData];
    
    // Rearrange text view position
    LSingleListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
    textView.frame = [cell getTextViewFrame];
}

- (void)textViewDidChangeHeight:(LTextView *)textView {
    textView.frame = [textView.cell getTextViewFrame];
}


#pragma mark - LShadowViewDelegate

- (void)shadowViewDidSwipeUp {
    [self hideAddItemView:nil];
}

- (void)shadowViewDidTap {
    if (self.addItemView.textView.text.isEmpty) {
        [self hideAddItemView:nil];
    }
    else {
        [self addNewItem];
    }
}

- (void)shadowViewDidSwipeDown {
    if (self.addItemView.textView.text.isEmpty) {
        [self hideAddItemView:nil];
    }
    else {
        [self addNewItem];
    }
}


#pragma mark - LSwipeCellDelegate

- (void)didTapCell:(LSwipeCell *)cell {
    self.editingTextView.frame = [(LSingleListViewCell *)cell getTextViewFrame];
    self.editingTextView.tag = [self.tableView indexPathForCell:cell].row;
    self.editingTextView.text = ((LSingleListViewCell *)cell).item.text;
    self.editingTextView.hidden = NO;
    [self.editingTextView becomeFirstResponder];
}

- (void)didSwipeCell:(LSwipeCell *)cell {
    
}

- (void)didPressDeleteButtonForCell:(LSwipeCell *)cell {
    
}

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress cell:(LSwipeCell *)cell {
    
}

@end
