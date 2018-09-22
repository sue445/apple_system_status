describe AppleSystemStatus::Crawler do
  let(:crawler){ AppleSystemStatus::Crawler.new }

  describe "#perform" do
    after do
      crawler.quit!
    end

    context "no args" do
      let(:us_service_titles) do
        [
          "App Store",
          "Apple ID",
          "Apple Music",
          "Apple Music Subscriptions",
          "Apple Online Store",
          "Apple Pay",
          "Apple School Manager",
          "Apple TV",
          "Back to My Mac",
          "Beats 1",
          "Dictation",
          "Documents in the Cloud",
          "FaceTime",
          "Find My Friends",
          "Find My iPhone",
          "Game Center",
          "Mac App Store",
          "Mail Drop",
          "Maps Display",
          "Maps Routing & Navigation",
          "Maps Search",
          "Maps Traffic",
          "News",
          "Photo Print Products",
          "Photos",
          "Radio",
          "Siri",
          "Spotlight suggestions",
          "Volume Purchase Program",
          "iBooks Store",
          "iCloud Account & Sign In",
          "iCloud Backup",
          "iCloud Bookmarks & Tabs",
          "iCloud Calendar",
          "iCloud Contacts",
          "iCloud Drive",
          "iCloud Keychain",
          "iCloud Mail",
          "iCloud Notes",
          "iCloud Reminders",
          "iCloud Storage Upgrades",
          "iCloud Web Apps (iCloud.com)",
          "iMessage",
          "iOS Device Activation",
          "iTunes Match",
          "iTunes Store",
          "iTunes U",
          "iTunes in the Cloud",
          "iWork for iCloud",
          "macOS Software Update",
        ]
      end

      it "should return system services" do
        actual = crawler.perform

        aggregate_failures do
          expect(actual[:title]).not_to be_empty
          expect(actual[:services]).not_to be_empty
          expect(actual[:services]).to all(be_a_service)

          service_titles = actual[:services].map { |service| service[:title] }

          us_service_titles.each do |service|
            expect(service_titles).to include service
          end
        end
      end
    end

    context "has country" do
      let(:country) { "jp" }

      let(:jp_service_titles) do
        [
          "App Store",
          "Apple ID",
          "Apple Music",
          "Apple Musicの登録",
          "Apple Online Store",
          "Apple Pay",
          "Apple School Manager",
          "Apple TV",
          "Beats 1",
          "Documents in the Cloud",
          "FaceTime",
          "Game Center",
          "Mac App Store",
          "Mail Drop",
          "Radio",
          "Siri",
          "Spotlightの検索候補",
          "Volume Purchase Program",
          "iBooks Store",
          "iCloud Drive",
          "iCloud Web Apps (iCloud.com)",
          "iCloudアカウントおよびサインイン",
          "iCloudカレンダー",
          "iCloudキーチェーン",
          "iCloudストレージアップグレード",
          "iCloudバックアップ",
          "iCloudブックマークおよびタブ",
          "iCloudメモ",
          "iCloudメール",
          "iCloudリマインダー",
          "iCloud連絡先",
          "iMessage",
          "iOSデバイスアクティベーション",
          "iPhoneを探す",
          "iTunes Match",
          "iTunes Store",
          "iTunes U",
          "iTunes in the Cloud",
          "iWork for iCloud",
          "macOSソフトウェアアップデート",
          "どこでもMy Mac",
          "フォトプリント製品",
          "マップの検索",
          "マップの経路案内とナビゲーション",
          "マップの表示",
          "写真",
          "友達を探す",
          "音声入力",
        ]
      end

      it "should return system services" do
        actual = crawler.perform(country: country)

        aggregate_failures do
          expect(actual[:title]).not_to be_empty
          expect(actual[:services]).not_to be_empty
          expect(actual[:services]).to all(be_a_service)

          service_titles = actual[:services].map { |service| service[:title] }

          jp_service_titles.each do |service|
            expect(service_titles).to include service
          end
        end
      end
    end

    context "has country (with blank cell)" do
      let(:country) { "cn" }

      it "should return system services" do
        actual = crawler.perform(country: country)

        aggregate_failures do
          expect(actual[:title]).not_to be_empty
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
          expect(actual[:title]).not_to be_empty
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

  describe ".perform" do
    let(:country) { "us" }
    let(:title)   { "App Store" }

    it "should return system services" do
      actual = AppleSystemStatus::Crawler.perform(country: country, title: title)

      aggregate_failures do
        expect(actual[:title]).not_to be_empty
        expect(actual[:services].length).to eq 1

        service = actual[:services].first
        expect(service).to be_a_service
        expect(service[:title]).to eq title
      end
    end
  end

  describe "#blank_string?" do
    subject { AppleSystemStatus::Crawler.blank_string?(str) }

    using RSpec::Parameterized::TableSyntax

    where(:str, :expected) do
      nil     | true
      ""      | true
      " "     | true
      "aaa"   | false
      " aaa " | false
    end

    with_them do
      it { should eq expected }
    end
  end
end
