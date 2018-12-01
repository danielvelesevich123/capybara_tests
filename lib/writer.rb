require 'csv'
class Writer
  def self.write_into_file(name_file, result)
    CSV.open(name_file, 'w', write_headers: true, headers: result.first.keys) do |csv|
      result.each do |info|
        csv << info.values
      end
    end
  end
end
