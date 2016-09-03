Now that we've built something more involved using TDD, it's time to do some refactoring informed by our test coverage.

Fixing a BugJump to Topic In Video
Currently the UnitConverter can't convert same units to the same units (i.e. cups to cups). Rather than fixing this problem by adding a same unit-to-same unit mapping and deepening our growing list of unit conversion possibilities, instead we'll refactor the converter to more elegantly handle conversions of units that share the same dimension.

Trust Me, I'm a ProgrammerJump to Topic In Video
The refactoring begins with an update to the structure of the CONVERSION_FACTORS constant, which supplies the unit-to-unit mappings. As this constant is a private implementation detail, we don't have to modify our existing tests. In fact, they shouldn't have to change at all, as they are our reference to confirm that the converter continues to work as expected.

When refactoring, after each small change, resist the temptation to write the code you expect to be the final implementation. Let the error messages from your tests guide you to the solution. Here Ian and Harry find that the tests help them find a misnamed block variable, which they then update to achieve a green test suite.

Refactored With ConfidenceJump to Topic In Video
A good test suite gives you fantastic leverage when you want to perform a refactoring. With tests in place, you can make changes to your code with the assurance that your intended functionality continues to work after your work is completed, protecting against regressions. Without a test suite, refactorings are much riskier, as each change may introduce subtle bugs, particularly ones that have already been fixed in previous revisions.
