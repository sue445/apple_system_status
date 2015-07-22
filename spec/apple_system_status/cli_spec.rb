describe AppleSystemStatus::CLI do
  describe "#fetch" do
    it "should execute" do
      result = system("bundle exec ./exe/apple_system_status fetch")
      expect(result).to be true
    end
  end
end
