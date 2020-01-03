//
//  InviteFriendsVC.m
//  Client-mobile
//
//  Created by Apple on 2019/9/26.
//

#import "InviteFriendsVC.h"
#import "ResultOfSearchVC.h"

@interface InviteFriendsVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UISearchControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray  *dataOfFriends;  //原始数据
@property (strong,nonatomic) NSMutableArray  *searchResults;  //搜索结果

@property (nonatomic, strong) UISearchController *searchController;
@property (strong,nonatomic) ResultOfSearchVC *resultVC; //搜索结果展示控制器

@end

@implementation InviteFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, self.view.frame.size.height - 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // Do any additional setup after loading the view.
//    UIView *view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.height-60);
//    view.backgroundColor = [UIColor redColor];
//    view.center = self.view.center;
    
//    UISearchBar *searchBar = [[UISearchBar alloc]init];
    
    //创建显示搜索结果控制器
    _resultVC = [[ResultOfSearchVC alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultVC];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    //_searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = YES;//搜索时隐藏导航栏  默认的是YES

    _searchController.searchBar.placeholder = @"placeholder";
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //_searchController.searchBar.prompt = @"prompt"; //提示语
    _searchController.searchBar.showsCancelButton = YES;
//    _searchController.searchBar.showsBookmarkButton = YES;
    //_searchController.searchBar.showsSearchResultsButton = YES;
    //ScopeBar
    //_searchController.searchBar.showsScopeBar = YES;
    //_searchController.searchBar.scopeButtonTitles = @[@"BookmarkButton" ,@"ScopeButton",@"ResultsListButton",@"CancelButton",@"SearchButton"];
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.height,60);
    self.tableView.tableHeaderView = _searchController.searchBar;

    //解决：退出时搜索框依然存在的问题
    self.definesPresentationContext = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UItableview delegate dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:flag];
    }
    //如果用户正在搜索，则返回搜索结果对应的数据，否则直接返回数据组对应的数据；
    if (self.searchController.active) {
        cell.textLabel.text = self.searchResults[indexPath.row];
    }else{
        cell.textLabel.text = self.dataOfFriends[indexPath.row];
    }
    return cell;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=1;
    if (self.searchController.active) {
        count = self.searchResults.count;
    }else{
        count =self.dataOfFriends.count;
    }
    return count;
}
//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchController.active) {
        
    }else{
        
    }
    //停止搜索
    self.searchController.active = NO;
}

#pragma mark SearchResultsUpdating
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    //获取搜索框里地字符串
    NSString *searchString = searchController.searchBar.text;

    //创建谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] %@",searchString];
//    如果搜索框里有文字，就按谓词的匹配结果初始化结果数组，否则，就用字体列表数组初始化结果数组。
    if (_searchResults != nil&&searchString.length>0) {
        //清除搜索结果
        _searchResults = nil;
        [_searchResults removeAllObjects];
        
        _searchResults = [NSMutableArray arrayWithArray:[_dataOfFriends filteredArrayUsingPredicate:predicate]];
//        NSArray *arr = [_dataOfFriends filteredArrayUsingPredicate:predicate];
//        _searchResults = [NSMutableArray arrayWithArray:y];
        
    }else if(searchString.length == 0)
    {
//        _searchResults = [NSMutableArray arrayWithArray:_dataOfFriends];
        _searchResults = _dataOfFriends;
    }
    //显示结果
    
    self.resultVC.results = _searchResults;
//    self.resultVC.results=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:_searchResults]];
    NSLog(@"never let anything stop you from chasing your dream");
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    
}

- (void)updateFocusIfNeeded {
    
}

#pragma mark 数据源
- (NSMutableArray *) dataOfFriends {
    NSLog(@"datas1=%@",_dataOfFriends);
    if (_dataOfFriends == nil) {
        _dataOfFriends =[[NSMutableArray alloc] initWithObjects: @"0xxx00000",@"1xz1111",@"cv23333", nil];
    }
    return _dataOfFriends;
}

- (NSMutableArray *) searchResults {
    if (_searchResults == nil) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

@end
