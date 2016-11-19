//
//  Constants.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef NS_ENUM(NSInteger, LTableType) {
    LTableTypeList = 0,
    LTableTypeItem
};

// Fonts
#define F_MAIN_TEXT [UIFont systemFontOfSize:16]
#define F_TITLE [UIFont systemFontOfSize:17]

// Colors
#define C_MAIN_TEXT C_GRAY(0.15)
#define C_SEPARATOR C_GRAY(0.82)
#define C_ICON C_GRAY(0.75)
#define C_SHADOW C_BLACK_ALPHA(0.2)
#define C_SELECTED C_GRAY(0.97)
#define C_EMPTY_VIEW C_GRAY(0.98)
//#define C_MOVING_CELL C_GRAY(0.99)
#define C_MOVING_SEPARATOR C_GRAY(0.85)

// Padding
static const CGFloat kPaddingTiny = 5;
static const CGFloat kPaddingSmall = 12;
static const CGFloat kPaddingMed = 20;

// Item Sizes
static const CGFloat kAllListsCellHeight = 47;
static const CGFloat kAllListsCellLeftViewWidth = 36;

static const CGFloat kSingleListCellMinHeight = 43;
static const CGFloat kSingleListCellLeftViewWidth = 43;

static const CGFloat kAllListsSeparatorTopLineHeight = 0.75;
static const CGFloat kAllListsSeparatorBottomLineHeight = 0.25;
static const CGFloat kAllListsSeparatorHeight = 7;

static const CGFloat kSingleListSeparatorHeight = 0.5;

static const CGFloat kIconHeight = 18;

static const CGFloat kColorTagWidth = 15;

static const CGFloat kDoneButtonLength = 20;

static const CGFloat kTextViewHeighthMax = 300;

static const CGFloat kHeaderViewHeight = 70;
static const CGFloat kHeaderViewButtonWidth = 85;
static const CGFloat kHeaderViewButtonHeight = 50;

static const CGFloat kRightSwipeViewWidth = 100;
static const CGFloat kSwipeViewIconButtonWidth = 50;

//static const CGFloat kMovingCellAlpha = 0.7;
static const CGFloat kMovingCellSeparatorHeight = 0.6;
static const CGFloat kMovingCellLeftOffset = 21;


// Animation
static const CGFloat kAnimationDurationTiny = 0.2;
static const CGFloat kAnimationDurationSmall = 0.3;
static const CGFloat kAnimationDurationMed = 0.4;


static const UIViewAnimationOptions kShowingAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
static const UIViewAnimationOptions kHidingAnimation = UIViewAnimationOptionTransitionFlipFromRight;

#endif
