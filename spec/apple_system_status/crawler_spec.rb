describe AppleSystemStatus::Crawler do
  let(:crawler){ AppleSystemStatus::Crawler.new }

  describe "#perform" do
    after do
      crawler.quit!
    end

    context "no args" do
      it "should return system services" do
        actual = crawler.perform

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:services]).not_to be_empty
          expect(actual[:services]).to all(be_a_service)
        end
      end
    end

    context "has country" do
      let(:country) { "jp" }

      it "should return system services" do
        actual = crawler.perform(country: country)

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:services]).not_to be_empty
          expect(actual[:services]).to all(be_a_service)
        end
      end
    end

    context "has country (with blank cell)" do
      let(:country) { "tw" }

      it "should return system services" do
        actual = crawler.perform(country: country)

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:services]).not_to be_empty
          expect(actual[:services]).to all(be_a_service)
        end
      end
    end

    context "has title" do
      let(:title) { "App Store" }

      it "should return system services" do
        actual = crawler.perform(title: title)

        aggregate_failures do
          expect(actual[:title]).not_to be_blank
          expect(actual[:services].length).to eq 1

          service = actual[:services].first
          expect(service).to be_a_service
          expect(service[:title]).to eq title
        end
      end
    end
  end

  describe "#apple_url" do
    subject { crawler.apple_url(country) }

    using RSpec::Parameterized::TableSyntax

    where(:country, :url) do
      nil  | "https://www.apple.com/support/systemstatus/"
      "jp" | "https://www.apple.com/jp/support/systemstatus/"
      "us" | "https://www.apple.com/support/systemstatus/"
      ""   | "https://www.apple.com/support/systemstatus/"
    end

    with_them do
      it { should eq url }
    end
  end
end
