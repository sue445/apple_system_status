describe AppleSystemStatus::Crawler do
  let(:crawler){ AppleSystemStatus::Crawler.new }

  describe "#perform" do
    context "no args" do
      it "should return system statuses" do
        actual = crawler.perform

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:statuses]).not_to be_empty
          expect(actual[:statuses]).to all(be_a_system_status)
        end
      end
    end

    context "has country" do
      let(:country) { "jp" }

      it "should return system statuses" do
        actual = crawler.perform(country)

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:statuses]).not_to be_empty
          expect(actual[:statuses]).to all(be_a_system_status)
        end
      end
    end
  end
end
