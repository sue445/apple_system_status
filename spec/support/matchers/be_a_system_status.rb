RSpec::Matchers.define :be_a_system_status do
  match do |actual|
    actual[:title].present? && actual[:description].present? && actual[:status].present?
  end

  description do
    "title, description and status are not blank"
  end
end
