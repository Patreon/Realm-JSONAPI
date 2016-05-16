#import "Fixtures.h"
#import "Article.h"
#import "Person.h"
#import "Comment.h"

SpecBegin(CanonicalExample)

describe(@"Parsing the canonical jsonapi.org example", ^{
  before(^{
    [Fixtures loadFixtures];
  });

  it(@"creates one article by Dan with two comments", ^{
    expect([Article allObjects].count).to.equal(1);

    Article *article = [Article objectForPrimaryKey:@"1"];
    expect(article.uid).to.equal(@"1");
    expect(article.title).to.equal(@"JSON API paints my bikeshed!");
    expect(article.author.uid).to.equal(@"9");
    expect(article.comments.count).to.equal(2);
    Comment *firstComment = [[article.comments objectsWhere:@"uid == '5'"] firstObject];
    expect(firstComment.uid).to.equal(@"5");
    Comment *secondComment = [[article.comments objectsWhere:@"uid == '12'"] firstObject];
    expect(secondComment.uid).to.equal(@"12");
  });

  it(@"creates two people: Dan, and one unnamed commenter", ^{
    Person *dan = [Person objectForPrimaryKey:@"9"];
    expect(dan.uid).to.equal(@"9");
    expect(dan.firstName).to.equal(@"Dan");
    expect(dan.lastName).to.equal(@"Gebhardt");
    expect(dan.twitterHandle).to.equal(@"dgeb");

    Person *anonymous = [Person objectForPrimaryKey:@"2"];
    expect(anonymous.uid).to.equal(@"2");
    expect(anonymous.firstName).to.beNil;
    expect(anonymous.lastName).to.beNil;
    expect(anonymous.twitterHandle).to.beNil;
  });

  it(@"creates two comments: one by Dan, and one by an unnamed commenter", ^{
    Comment *firstComment = [Comment objectForPrimaryKey:@"5"];
    expect(firstComment.uid).to.equal(@"5");
    expect(firstComment.body).to.equal(@"First!");
    expect(firstComment.author.uid).to.equal(@"2");

    Comment *secondComment = [Comment objectForPrimaryKey:@"12"];
    expect(secondComment.uid).to.equal(@"12");
    expect(secondComment.body).to.equal(@"I like XML better");
    expect(secondComment.author.uid).to.equal(@"9");
  });
});

SpecEnd

