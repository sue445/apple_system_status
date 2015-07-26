describe AppleSystemStatus do
  describe "#format_response" do
    subject { AppleSystemStatus.format_response(hash, format) }

    let(:hash) do
      {
        title: "System Status as of 1:07 AM JST",
        services: [
          { title: "App Store", description: "No Issues: App Store", status: "allgood" },
        ]
      }
    end

    context "plain format" do
      let(:format) { "plain" }
      let(:expected) do
        <<-EOS.strip_heredoc
          System Status as of 1:07 AM JST
          App Store,allgood,No Issues: App Store
        EOS
      end

      it { should eq expected }
    end

    context "json format" do
      let(:format) { "json" }
      let(:expected) do
        <<-JSON.strip_heredoc.strip
          {"title":"System Status as of 1:07 AM JST","services":[{"title":"App Store","description":"No Issues: App Store","status":"allgood"}]}
        JSON
      end

      it { should eq expected }
    end
  end
end
