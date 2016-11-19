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


@interface LSingleListViewController () <NSFetchedResultsControllerDelegate, LTextViewDelegate, LShadowViewDelegate, LTableCellDelegate>

@property (nonatomic, strong) List *list;

@property (nonatomic) NSFetchedResultsController<Position *> *positions;
@property (nonatomic) NSFetchedResultsController<Item *> *items;

@property (nonatomic) LAddItemView *addItemView;

@property (nonatomic) LTextView *editingTextView;

@property (nonatomic) LTableViewCell *swipedCell;

@property (nonatomic) UIAlertController *deleteItemAlert;

@end


@implementation LSingleListViewController {
    BOOL addViewAnimationInProgress;
}

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
    
    //  Editing Text View
    self.editingTextView = [[LTextView alloc] initInSuperview:self.tableView];
    self.editingTextView.backgroundColor = C_CLEAR;// C_GRAY_ALPHA(0.3, 0.2);
    self.editingTextView.font = F_MAIN_TEXT;
    self.editingTextView.tag = -1;
    self.editingTextView.hidden = YES;
    self.editingTextView.lDelegate = self;
    
    // Add Item View
    self.addItemView = [[LAddItemView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kSingleListCellMinHeight insets:inset_top(LLists.statusBarHeight)];
    self.addItemView.hidden = YES;
    [self.addItemView.plusButton addTarget:self action:@selector(addNewItem)];
    
    // Delete List Alert
    self.deleteItemAlert = [UIAlertController alertControllerWithTitle:@"Delete Item" message:@"Are you sure you want to delete this item?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self unswipeCell];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [ListsManager deleteItem:((LSingleListViewCell *)self.swipedCell).item inList:self.list completion:^(BOOL finished) {
            
        }];
        [self unswipeCell];
    }];
    [self.deleteItemAlert addAction:cancelAction];
    [self.deleteItemAlert addAction:deleteAction];
    
    // GR
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didPressBackButton)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    
    addViewAnimationInProgress = NO;
    
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


#pragma mark - FRC

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
    [self.items performFetch];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSingleListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LSingleListViewCell reuseIdentifier]];
    cell.item = [self.items objectAtIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [LSingleListViewCell rowHeightForText:[self.items objectAtIndexPath:indexPath].text];
    LOG(@"- Row %ld Height %.2f", indexPath.row, height);
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Center Text View
    LTextView *textView = ((LSingleListViewCell *)cell).itemView.textView;
    textView.height = [textView heightForText:textView.text];
    [((LSingleListViewCell *)cell).itemView centerTextView];
    
    // Hide Text View for editing cell
    textView.hidden = self.editingTextView.tag == indexPath.row;
    
    // Rearrange Editing Text View position
    if (self.editingTextView.tag == indexPath.row) {
        self.editingTextView.frame = [(LSingleListViewCell *)cell getTextViewFrame];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView setEditing:NO];
    
    // End editing cell
    if (self.editingTextView.tag >= 0) {
        [self textViewShouldEndEditing:self.editingTextView];
    }
    
    // Hide swiped view
    [self unswipeCell];
    
    // Show Add Item View
    if (scrollView.contentOffset.y < -kPaddingSmall && !self.header.addButton.hidden) {
        [self showAddItemView];
    }
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
    if (!addViewAnimationInProgress) {
        addViewAnimationInProgress = YES;
     
        // Hide swiped cell
        [self unswipeCell];
        
        // Hide Add Button
        self.header.addButton.hidden = YES;
        
        // Show Add Item View
        self.addItemView.hidden = NO;
        
        [UIView animateWithDuration:kAnimationDurationSmall animations:^{
            self.addItemView.top = self.header.bottom;
            self.shadowView.hidden = NO;
            
        } completion:^(BOOL finished) {
            // Show keyboard
            [self.addItemView.textView becomeFirstResponder];
            
            [self.addItemView setShowingPlusButton:YES completion:^{
                addViewAnimationInProgress = NO;
            }];
            
            // Disable Table View scrolling
            [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                self.tableView.scrollEnabled = NO;
            }];
        }];
    }
}

- (void)hideAddItemView:(void (^)())completion {
    if (!addViewAnimationInProgress) {
        addViewAnimationInProgress = YES;
        
        // Hide keyboard
        [self.addItemView.textView resignFirstResponder];
        
        // Hide Add Item View
        [self.addItemView setShowingPlusButton:NO completion:^{
            [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                self.addItemView.bottom = self.header.bottom;
                self.shadowView.hidden = YES;
                
            } completion:^(BOOL finished) {
                self.addItemView.hidden = YES;
                addViewAnimationInProgress = NO;
                
                // Enable Table View scrolling
                self.tableView.scrollEnabled = YES;
                
                if (completion) {
                    completion();
                }
            }];
            
            // Show Add button
            self.header.addButton.hidden = NO;
        }];
    }
}

- (void)addNewItem {
    NSString *text = [ListsManager updateText:self.addItemView.textView.text];
    
    if (!text.isEmpty) {
        // Save new list
        NSInteger position = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
        [ListsManager saveItemWithText:text onPosition:position inList:self.list];
    }
    
    // Hide and clear Add List View
    [self hideAddItemView:^{
        [self.addItemView clear];
    }];
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


#pragma mark - LTextViewDelegate

- (void)textViewShouldBeginEditing:(LTextView *)textView {
    
}

- (void)textViewShouldEndEditing:(LTextView *)textView {
    // Update last editing cell
    [self updateLastEditedCell];

    [self.tableView reloadData];
    
    // Null Editing Text View
    textView.tag = -1;
    textView.hidden = YES;
}

- (void)textViewShouldChangeText:(LTextView *)textView to:(NSString *)text {
    self.items.fetchedObjects[textView.tag].text = text;
}

- (void)textViewShouldChangeHeight:(LTextView *)textView to:(CGFloat)height {
    // Reload editing cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textView.tag inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)textViewDidChangeHeight:(LTextView *)textView {
    // Get new frame
    LSingleListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
    textView.frame = [cell getTextViewFrame];
}

#pragma mark - Editing Text View

- (void)updateLastEditedCell {
    if (self.editingTextView.tag >= 0) {
        LSingleListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.editingTextView.tag inSection:0]];
        cell.item.text = [ListsManager updateText:self.editingTextView.text];
        
        [DataStore save];
    }
}


#pragma mark - LTableCellDelegate

- (void)didTapCell:(LTableViewCell *)cell {
    // Hide swiped cell
    [self unswipeCell];
    
    // Update last edited cell
    [self updateLastEditedCell];
    
    // Start editing new cell
    self.editingTextView.tag = [self.tableView indexPathForCell:cell].row;
    self.editingTextView.text = ((LSingleListViewCell *)cell).item.text;
    self.editingTextView.hidden = NO;
    [self.editingTextView becomeFirstResponder];
    
    [self.tableView reloadData];
}

- (void)didSwipeCell:(LTableViewCell *)cell {
    // Hide previously swiped cell
    [self unswipeCell];
    self.swipedCell = cell.swiped ? cell : nil;
}

- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell {
    // Show alert
    [self presentViewController:self.deleteItemAlert animated:YES completion:nil];
}

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress cell:(LTableViewCell *)cell {
    
}

#pragma mark - Swipe

- (void)unswipeCell {
    if (self.swipedCell) {
        self.swipedCell.swiped = NO;
        self.swipedCell = nil;
    }
}

@end
