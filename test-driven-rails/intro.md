Why test?
  - IT works
    - Check all logic works
  - it does what you want it to do
  - code goals
    - Easy for others to understand
    - Acts as documentation
    - easy to refactor
      - what aspects need to be decoupled and extracted
      - ie 3rd party service
  - Process goals
    - guide design design
    - validating code writing is correctly
    - Focus on what is necessary
    - Write code that only gets to green
    - establish trust
      - confident that others are push code to master is correct
- Red green refactor
  - refactor should not take long
    - continously
- Outside in development
  - Doing RGR at accepetance then unit 
  - acceptence test
    - high level
      - driven by user/customer of web app
      - perfomrning high level features
      - How use interacts with app
    - Behaviour throughout app and all parts interacting
  - unit tests
    - lower level
    - isolate small component and check it
