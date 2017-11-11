//
//  ViewController.m
//  Startxlabs_Task
//
//  Created by Venkatesh on 08/11/17.
//  Copyright © 2017 venkatesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSString *finalPattern;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self printMentionedPattern];
    [self reverseVowelsInString:@"Iphone"];
    [self findMinimumDistanceBetwwenTwoElementsWithValue1:4 Value2:5];
}

//    Please solve the below assignment so we can take interview process further.
//    Q1. Print the following pattern.
//    1
//    2 2
//    3 3
//    4 4
//    3 3
//    2 2
//    1
-(void)printMentionedPattern {
    NSString *strPattern;
    for (int i = 1; i<5; i++) {
        for (int j = 2; j< 5; j++) {
            if (strPattern != nil) {
                if (i == j) {
                    strPattern = [strPattern stringByAppendingString:[NSString stringWithFormat:@"\n%d %d",i,j]];
                    if (i == 4 & j == 4) {
                        finalPattern = strPattern;
                        NSMutableString *reversedString = [NSMutableString stringWithCapacity:[strPattern length]];
                        
                        [strPattern enumerateSubstringsInRange:NSMakeRange(0,[strPattern length])
                                                       options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                                                    usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                                        [reversedString appendString:substring];
                                                        if (enclosingRange.location == 0) {
                                                            self->finalPattern = [self->finalPattern stringByAppendingString:[NSString stringWithFormat:@"\n%@",reversedString]];
                                                            NSLog(@"%@",finalPattern);
                                                        }
                                                    }];
                    }
                }
                
            } else {
                strPattern = [NSString stringWithFormat:@"%d",i];
                break;
            }
        }
    }
}


//  Q2. You are given an array and two elements, find the minimum distance between the elements in the array. The array may have duplicates.
//    For example, if the array is (1, 5, 3, 7, 2, 8, 3, 4, 5, 9, 9, 3, 1, 3, 2, 9)
//        Min Distance (4, 7): 4
//        Min Distance (9, 3): 1
//

-(void)findMinimumDistanceBetwwenTwoElementsWithValue1:(int)value1 Value2:(int)value2 {
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@[@1,@2,@4,@5,@2,@7,@8,@0,@3,@6], nil];
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSMutableArray *differenceArray = [[NSMutableArray alloc]init];
    NSMutableDictionary * allDict = [[NSMutableDictionary alloc]init];
    [array[0]
     enumerateObjectsUsingBlock:
     ^(NSString *string1, NSUInteger index, BOOL *stop)
     {
         NSString * string = [NSString stringWithFormat:@"%@",string1];
         NSMutableArray * dummy = [NSMutableArray new];
         BOOL isExist = [allDict.allKeys containsObject:string];
         if (isExist){
             dummy = [allDict objectForKey:string];
             [dummy addObject:[NSNumber numberWithInteger:index]];
             [allDict setValue:dummy forKey:string];
         }else{
             [dummy addObject:[NSNumber numberWithInteger:index]];
             [allDict setValue:dummy forKey:string];
         }
         // NSLog(@"%@",allDict);
     }];
    
    
    
    indexArray = value1 > value2 ? [allDict mutableArrayValueForKey:[NSString stringWithFormat:@"%d",value1]] : [allDict mutableArrayValueForKey:[NSString stringWithFormat:@"%d",value2]] ;
    differenceArray = value1 > value2 ? [allDict mutableArrayValueForKey:[NSString stringWithFormat:@"%d",value2]] : [allDict mutableArrayValueForKey:[NSString stringWithFormat:@"%d",value1]] ;
    NSMutableArray * diffArry = [NSMutableArray new];
    for (NSString *num1 in indexArray) {
        for (NSString *num2 in differenceArray) {
            int val1 = num1.intValue;
            int val2 = num2.intValue;
            int sum = val1 - val2;
            [diffArry addObject:[NSNumber numberWithInt:sum]];
        }
    }
    NSLog(@"Matching Values :::::%@",diffArry);
    int minimumValue = [[diffArry valueForKeyPath: @"@min.self"] intValue];
    NSLog(@" MinimumValue = %d", minimumValue);
}



//        Q3. Write a program that takes a string as input and reverse only the vowels of a string.


-(void)reverseVowelsInString:(NSString *)str {
    NSMutableArray *normalArray = [[NSMutableArray alloc]init];
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSMutableArray *reverseArray = [[NSMutableArray alloc]init];
    NSString *finalString = [[NSString alloc]init];
    for (int index = 0; index < str.length; index++) {
        char ch = [str characterAtIndex:index];
        if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' || ch == 'A' || ch == 'E' || ch == 'I' || ch == 'O' || ch == 'U') {
            [normalArray addObject:[NSString stringWithFormat:@"%c",ch]];
            [indexArray addObject:[NSNumber numberWithInt:index]];
        }
    }
    [reverseArray addObjectsFromArray:[[normalArray reverseObjectEnumerator] allObjects]];
    finalString = str;
    int count = 0;
    for (NSString *value in indexArray) {
        for (int k = 0; k < finalString.length; k++) {
            if (value.intValue == k) {
                finalString  = [self string:finalString ByReplacingACharacterAtIndex:k byCharacter:[NSString stringWithFormat:@"%@",[reverseArray objectAtIndex:count]]];
                count ++;
                break;
            }
        }
    }
    NSLog(@"%@ reverse with vowels::::: %@",str,finalString);
}


-(NSString *)string:(NSString*)string ByReplacingACharacterAtIndex:(int)i byCharacter:(NSString*)StringContainingAChar{
    
    return [string stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:StringContainingAChar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
