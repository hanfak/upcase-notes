# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # implement your behavior here
  def full_name
    to_string([@first_name, @middle_name, @last_name])
  end

  def full_name_with_middle_initial
    to_string([@first_name, middle_initial , @last_name])
  end

  def initials
    to_string([@first_name[0], middle_initial, @last_name[0]])
  end

  private
    def middle_initial
      @middle_name[0] unless @middle_name.nil?
    end

    def to_string array
      array.compact.join(' ')
    end
end

RSpec.describe Person do
  let(:name_one) {Person.new(first_name: 'Han', middle_name: 'Cloud', last_name: 'Fakira')}
  let(:name_two) {Person.new(first_name: 'Squall',  last_name: 'Lionheart')}

  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      expect(name_one.full_name).to eq('Han Cloud Fakira')
    end

    it "does not add extra spaces if middle name is missing" do
      expect(name_two.full_name).to eq('Squall Lionheart')
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first name, middle name initial and last name with spaces" do
      expect(name_one.full_name_with_middle_initial).to eq('Han C Fakira')
    end

    it "does not add extra spaces if middle name is missing" do
      expect(name_two.full_name_with_middle_initial).to eq('Squall Lionheart')
    end
  end

  describe "#initials" do
    it "concatenates first name initial, middle name initial and last name initial with spaces" do
      expect(name_one.initials).to eq('H C F')
    end

    it "does not add extra spaces if middle name is missing" do
      expect(name_two.initials).to eq('S L')
    end
  end
end
