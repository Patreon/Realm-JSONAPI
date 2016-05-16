#import "ArticleListController.h"
#import "Article.h"
#import "Person.h"

static NSString *const kCellReuseIdentifier = @"Cell";

@interface ArticleListController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RLMResults *articles;
@end

@implementation ArticleListController

- (void)loadView {
  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.view = self.tableView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  self.articles = [Article allObjects];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:kCellReuseIdentifier];
  }
  Article *article = self.articles[indexPath.row];
  cell.textLabel.text = article.title;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
                               article.author.firstName, article.author.lastName];
  return cell;
}

@end
