require "apple_system_status/version"
require "apple_system_status/crawler"

module AppleSystemStatus
  def self.format_response(hash, format)
    case format
    when "plain"
      str = "#{hash[:title]}\n"
      hash[:services].each do |service|
        str << "#{service[:title]},#{service[:status]},#{service[:description]}\n"
      end
      str

    when "json"
      hash.to_json

    else
      raise "Unknown format: #{format}"
    end
  end
end
