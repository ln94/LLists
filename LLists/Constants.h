//
//  Constants.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// Fonts
#define F_MAIN_TEXT [UIFont systemFontOfSize:16]
#define F_TITLE [UIFont systemFontOfSize:17]

// Colors
#define C_MAIN_TEXT C_GRAY(0.15)
#define C_SEPARATOR C_GRAY(0.82)
#define C_ICON C_GRAY(0.75)
#define C_SHADOW C_BLACK_ALPHA(0.25)
#define C_SELECTED C_GRAY(0.9)

// Padding
static const CGFloat kPaddingTiny = 5;
static const CGFloat kPaddingSmall = 12;
static const CGFloat kPaddingMed = 20;

// Item Sizes
static const CGFloat kAllListsViewCellHeight = 43;

static const CGFloat kSeparatorLineHeight = 0.75;
static const CGFloat kSeparatorHeight = 7;

static const CGFloat kDoneButtonLength = 20;

static const CGFloat kColorTagWidth = 15;

static const CGFloat kTextFieldLeftViewWidth = 36;
static const CGFloat kTextViewHeighthMax = 300;

static const CGFloat kHeaderViewHeight = 40;
static const CGFloat kHeaderViewMiddleButtonWidth = 60;
static const CGFloat kHeaderViewSideButtonWidth = 75;
static const CGFloat kHeaderViewSideButtonInset = 15;

static const CGFloat kRightSwipeViewWidth = 100;
static const CGFloat kSwipeViewIconButtonWidth = 30;

// Animation
static const CGFloat addViewAnimationDuration = 0.3;
static const CGFloat plusButtonAnimationDuration = 0.5;
static const CGFloat viewControllerTransitionDuration = 0.3;
static const CGFloat swipeAnimationDuration = 0.3;

static const UIViewAnimationOptions showingAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
static const UIViewAnimationOptions hidingAnimation = UIViewAnimationOptionTransitionFlipFromRight;

#endif
