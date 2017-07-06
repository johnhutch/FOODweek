# Helps to loop through a collection in search of one particular item that matches.
RSpec::Matchers.define :contain_one_or_more_records_that do |matcher|
  match do |collection|
    collection.any? do |item|
      matcher.matches?(item)
    end
  end
end
