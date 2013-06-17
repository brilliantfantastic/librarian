require 'test_helper'

describe 'A new', Book do
  it 'requires confirmation of name'
  it 'is invalid if it has no name'
  it 'is valid if it has a name, confirmation, and no ISBN'
  it 'is invalid if the name has already been taken'
  it 'is invalid if the ISBN contains letters'
  it 'is invalid if the ISBN is not 10 or 13 characters'
  it 'is valid if the ISBN is 10 or 13 digits'
end
