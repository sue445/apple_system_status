describe AppleSystemStatus::CLI do
  describe "#fetch" do
    it "should execute" do
      result = system("./exe/apple_system_status fetch")
      expect(result).to be true
    end
  end

  describe "#cli" do
    it "should execute" do
      result = system("./exe/apple_system_status version")
      expect(result).to be true
    end
  end
end
