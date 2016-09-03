Let's get into the nuts and bolts of TDD.

In this example, we're going to build a calculator through a test-driven process. For our Ruby tests, we're going to use RSpec, a popular testing library with an expressive DSL and excellent community support. We'll use RSpec's autorun feature during this example to run tests every time we update our files. We don't typically use this feature, but it will make checking our work during the Trail faster.

Writing the First TestJump to Topic In Video
We'll start by writing a test. RSpec uses nested blocks to group tests together. The outermost block describes the class (Calculator), and the next level in describes our method, #add. One more level in, and we write the spec for our first behavior inside an it block.

describe Calculator do
  describe "#add" do
    it "adds two numbers" do
      calculator = Calculator.new

      expect(calculator.add(1, 1)).to eq(2)
    end
  end
end
The contents of the spec are mostly the Ruby you already know. RSpec's DSL provides some methods that give your tests some English readability. #expect is how you tell RSpec to perform some verification of test results.

Our First Error: RedJump to Topic In Video
The first run of the test suite gives us an error. This is good! Errors in TDD help us determine what incremental step to take next. The new code should implement the simplest possible logic (within reason) to resolve the error.

First, we add the class, as our error is due to Calculator not being defined. Adding the class will then lead to an error about an undefined method #add. Implementing Calculator#add will then lead to an error about an incorrect number of arguments. Giving #add arguments will then lead to an error about the returned value being nil rather than the sum. Now it's time to implement our method logic.

class Calculator
  def add(a, b)

  end
end
Tests Pass: GreenJump to Topic In Video
Hard-coding #add to return 15 and make the test pass may seem like a bad idea, but we're not done yet. Now that our test passes, we'll write another test that requires a more generalized solution. A second test exposes our hard-coded return value as an inadequate solution and requires a better implementation to make both tests pass.

It's not always necessary to resolve tests initially through a hard-coded value, but the initial implementation and the quick iteration to a general implementation illustrates how TDD can guide you to the minimum code needed to deliver the feature.

Implementing the Next Feature: FactorialJump to Topic In Video
With the #add method working as we want, it's time to add a new capability to our calculator, to return the result of a factorial.

Factorial has two cases: factorial for a number is all of the positive integers from one up to that number multiplied by each other. Factorial 0, the special case, is 1. We'll write a test to handle each of these cases:

describe "#factorial" do
  it "returns 1 when given 0 (0! = 1)" do
    calc = calculator.new

    expect(calc.factorial(0)).to eq(1)
  end

  it "returns 120 when given 5 (5! = 120)" do
    calc = calculator.new

    expect(calc.factorial(5)).to eq(120)
  end
end
We'll resolve errors for each of the tests individually, starting with the simplest case, factorial 0. First, we define the method, then we give the method an argument, then we return the expected result.

def factorial(n)
  1
end
Our spec passes, and we can move on to the more complicated general case, which is still failing. A recursive solution is straightforward approach, with an if clause guarding against the 0 case.

def factorial(n)
  if n == 0
    1
  else
    n * factorial(n-1)
  end
end
RefactoringJump to Topic In Video
With passing tests, we're green across the board. This state is a great time to do some refactoring, while your understanding of the code is fresh and your test suite is ready to backstop you against regressions.
