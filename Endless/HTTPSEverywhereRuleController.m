#import "HTTPSEverywhereRuleController.h"
#import "HTTPSEverywhere.h"
#import "HTTPSEverywhereRule.h"

@interface HTTPSEverywhereRuleController ()

@end

@implementation HTTPSEverywhereRuleController

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.sortedRuleNames = [[NSMutableArray alloc] initWithCapacity:[[HTTPSEverywhere rules] count]];
		
		if ([[self.appDelegate webViewController] curWebViewTab] != nil) {
			self.inUseRuleNames = [[NSMutableArray alloc] initWithArray:[[[[[self.appDelegate webViewController] curWebViewTab] applicableHTTPSEverywhereRules] allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
		}
		else {
			self.inUseRuleNames = [[NSMutableArray alloc] init];
		}
		
		for (NSString *k in [[HTTPSEverywhere rules] allKeys]) {
			if (![self.inUseRuleNames containsObject:k])
				[self.sortedRuleNames addObject:k];
		}
		
		self.sortedRuleNames = [NSMutableArray arrayWithArray:[self.sortedRuleNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
		self.searchResult = [NSMutableArray arrayWithCapacity:[self.sortedRuleNames count]];
		
		self.title = @"HTTPS Everywhere Rules";
	}
	return self;
}

- (NSString *)ruleDisabledReason:(NSString *)rule
{
	return [[HTTPSEverywhere disabledRules] objectForKey:rule];
}

- (void)disableRuleByName:(NSString *)rule withReason:(NSString *)reason
{
	[HTTPSEverywhere disableRuleByName:rule withReason:reason];
}

- (void)enableRuleByName:(NSString *)rule
{
	[HTTPSEverywhere enableRuleByName:rule];
}

@end
