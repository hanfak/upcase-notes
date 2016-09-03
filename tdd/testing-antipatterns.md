xUnit Test PatternsJump to Topic In Video
The basis for the discussion today comes from the xUnit Test Patterns book. This is a classic book that covers the ins and outs of of refactoring test code to make it as useful and robust as possible. While the concepts in the book are rather broad and foundational, the specific examples are in Java. In this video we'll review some of the core concepts laid out in the book using more familiar Ruby and Rspec examples.

Test SmellsJump to Topic In Video
The specific antipatterns or test smells covered in this video are:

Obscure Tests - where it is hard to figure out exactly what is being tested.
Fragile Tests - tests which seem to break when they shouldn't.
Erratic Tests - tests that will pass or fail without you changing anything.
Test Hooks - having specific methods or branches in your production code for testing.
Obscure TestsJump to Topic In Video
The "Rspec DSL Puzzle" is one particular form of obscure tests that are common in Rspec test suites. To aid in the discussion we'll use the following Rspec sample test suite:

describe Post do
  let(:user) { build_stubbed(:user) }
  let(:title) { "Example Post" }
  subject(:post) { build_stubbed(:post, user: user, title: title) }

  describe "#slug" do
    it "generates a slug from the title" do
      expect(post.slug).to eq("example-post")
    end
  end

  describe "#author_name" do
    context "with an author" do
      let(:user) { build_stubbed(:user, name: "Willy") }

      it "returns the author's name" do
        expect(post.author_name).to eq("Willy")
      end
    end

    context "without an author" do
      before { post.user = nil }

      it "returns an anonymous author" do
        expect(post.author_name).to eq("Anonymous")
      end
    end
  end
end
To start, we can take a look at our first assertion:

  describe "#slug" do
    it "generates a slug from the title" do
      expect(post.slug).to eq("example-post")
    end
  end
This line provides no context as to how a slug is generated. Instead, we could refactor to build the post using a factory, thus providing a bit more context:

  describe "#slug" do
    it "generates a slug from the title" do
      post = build_stubbed(:post, title: "Example Post")

      expect(post.slug).to eq("example-post")
    end
  end
The original form of the test was reliant on specific attributes of the post object, but that object was defined far from our test (in the subject line at the top of the suite).

Mystery GuestJump to Topic In Video

A "Mystery Guest" is an object defined outside your test case that is used within the test case. Mystery guests are similar to magic numbers in that they appear in our code, are clearly important, but their source and or meaning are not clear. Check out the Giant Robots post on the Mystery Guest for a deeper dive.

A common source of mystery guests is using Rails fixtures to populate test data. Often, fixtures provide very specific instances of the objects used in a test, but that specificity is found in the fixture file, not the test case.

FactoryGirl provides an alternative to fixtures that was designed to make it very easy to build objects as needed in specs with exactly the attributes needed. The build_stubbed line above is using FactoryGirl to generate the post instance.

Tests as DocumentationJump to Topic In Video

Although zero duplication is often the goal, tests are one area where this is not ideal. Instead, we want to focus on treating our Tests as Documentation. Each test case should ideally provide all the needed context within the test itself, while avoiding extraneous code that can distract from the test. This is a delicate balance to strike, but tools like FactoryGirl and extracting helper methods can certainly help abstract away the specific how of building up our test objects, while still keeping their creation explicit and traceable from the test.

Fragile TestsJump to Topic In Video
While the "Rspec DSL puzzle" tests are certainly obscure, they also can often behave as "fragile tests" meaning that they a given test will fail when seemingly unrelated changes are made.

When your test is reliant on objects that are created far from the test case itself, it can be easy for someone to change that setup code or before block, unaware of how that will effect other tests.

This issue can be compounded if we modify aspects of the setup state:

describe Post do
  let(:user) { build_stubbed(:user) }
  let(:title) { "Example Post" }
  subject(:post) { build_stubbed(:post, user: user, title: title) }

  # ...

  context "with an author" do
    let(:user) { build_stubbed(:user, name: "Willy") }

    it "returns the author's name" do
      expect(post.author_name).to eq("Willy")
    end
  end
end
This test case overrides the user locally, but relies on the post created in the subject block to use this local user object.

Again the fix is to bring that context in our test, and build the needed objects within the test:

context "with an author" do
  it "returns the author's name" do
    author = build_stubbed(:user)
    post = build_stubbed(:post, user: author)

    expect(post.author_name).to eq(author.name)
  end
end
Erratic TestsJump to Topic In Video
Erratic tests are tests which will fail intermittently. These are some of the most frustrating issues you can have with a test suite, and perhaps more importantly, they can undermine your trust in the test suite.

Interacting TestsJump to Topic In Video

One potential cause of erratic test failures is interaction between tests. To verify this, run yours specs in random order using the --order rand option (or by setting this in your spec_helper.rb as we do in suspenders). Rspec will run in random order, but it will also display the random seed which you can use to duplicate a particular execution order in the event of a failure.

If you can consistently reproduce a given failure by running in a specific order, then you have an interacting test. If the failure remains erratic with a fixed order, then you have an erratic test.

JavaScript Feature SpecsJump to Topic In Video

One potential source of erratic tests is timing issues. When running feature specs that use JavaScript, your whole test is actually running asynchronously in the JS context. Capybara jumps through a ton of hoops to eliminate the inherent race conditions and synchronize your test and app state.

While Capybara works hard for us, there are a number of ways we can thwart it's efforts and introduce erratic behavior into feature specs:

first(".active").click

all(".active").each(&:click)

execute_script("$('.active').focus()")

expect(find_field("Username").value).to eq("Joe")

expect(find(".user")["data-name"]).to eq("Joe")

expect(has_css?(".active")).to eq(false)
Capybara can only help when it has visibility to what we are trying to do. Instead, we want to try to build our feature specs using method calls that clearly express our intent so Capybara can ensure we are in sync. Joe has written a great post on Async Capybara Tests that provides all the dos and don'ts for writing solid, reliable feature specs.

Date and Times in SpecsJump to Topic In Video

Another potential source of erratic test failures is just about anything using dates and times. Whenever you use specific dates and times in your test examples you can expose yourself to potential erratic failures based on the current date and time.

Instead, check out the Timecop gem or the travel_to helper method in Rails which provide ways to robustly use dates and times in your specs.

Source of Interacting TestsJump to Topic In Video

By definition, "interacting tests" are cases where there are side effects of a given test that can interfere with another subsequent test. In general, most would agree that this is something to avoid, but subtle interactions can sneak into a test suite from many angles.

While there are some more obvious sources of test interaction like leaving behind database records between test runs, there are also more subtle potential causes in code. As an example, memoizing a value in a class method is essentially a form of caching and can cause test case interactions:

class Post
  def self.recent
    @recent ||= order(created_at: :desc).limit(10)
  end
end
Similarly, the Rails mailer test helpers if not configured properly may leave emails in the queue between tests, causing potential issues with assertions like:

expect(ActionMailer::Base.deliveries).to be_empty
More generally, any form of caching can potentially introducing interacting test behavior and cause erratic test failures:

config.action_controller.perform_caching = true
Test HooksJump to Topic In Video
The final testing smell are "test hooks" which are methods in production code that only run when in testing mode. As an example:

class ApplicationController < ActionController::Base
  unless Rails.env.test?
    before_filter :require_login
  end
end
In this case we disable the login system when running in test mode. Not only does this much up our production code with tangential test-only concerns, but it also means that our code will run differently when in test mode than when in production mode. While this is to a certain degree inevitable, we want to minimize these sort of differences and strive for maximum test to production parity.

An alternative to this is something like the Clearance back door which is a feature of our Rails authentication library, Clearance. It works by injecting a middleware into the stack in test mode that allows for easy authentication in feature specs:

visit root_path(as: user)
We're still technically modifying our application for testing purposes, but we're doing it at a much higher level and away from our production code.

ConclusionJump to Topic In Video
If you're interested in diving deeper into the world of refactoring your tests, be sure to check out xUnit Test Patterns. In addition, if you're looking for something closer to the Ruby and Rails world, check out our Testing Rails book which covers all of the above, and much more.
