4 phases of testing

- Break down what happens in a single test into four distinct phases
  - setup
  - exercise
  - verify
  - teardown
- Benefits
  - similar to conven over config, know what is going, increase readibilty of tests
- Setup
  - prepare data and objects to use in test
- exercise
  - move data through the motion we want it to go through
- Verfiy
  - assert what is expected to what happens
- split each phase wiht new line
- teardowns
  - not common
  - happens with cleaning a database after each test ie database cleaner
- Downsides of not following this convention
  - mixing verify with exercise -> use spies

  ```ruby
  describe PreFixedLogger do
    describe '#debug' do
      it "delegates to its loggerwith a prefix" do
        logger = double('logger')
        logger.stub(:debug)
        prefixed = PreFixedLogger.new(logger,"prefix:")

        prefix.debug("message")

        expect(logger).to have_recieved(:debug).wiht("prefix: message")
      end
    end
  end

  ```

  - test smell: Can I see cleaerly what is in the tests?
  - Ok to have multiple assertions in verify
    - but must verify one condition
    - reduces time if many tests
      - conditions, is how it setup, and exercised
        - occurs a lot in feature test


http://xunitpatterns.com/
