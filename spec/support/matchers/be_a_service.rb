RSpec::Matchers.define :be_a_service do
  match do |actual|
    actual[:title] && !actual[:title].empty? && actual[:status] && !actual[:status].empty?
  end

  description do
    "title, description and status are not blank"
  end
end
