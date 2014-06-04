require 'csv'
require 'json'

module CSVtoJSON
  def self.convert_csv(input, output)
    rows = CSV.open(input).read
    rows = convert_booleans(rows)
    keys = rows.shift

    File.open(output, 'w') do |file|
      data = rows.map do |values|
        Hash[keys.zip(values)]
      end
      file.write(JSON.pretty_generate data)
    end
  end

  private

  def self.convert_booleans(rows)
    booleans = { "true" => true, "false" => false }
    rows.map do |row|
      row.map do |value|
        booleans.include?(value) ? booleans[value] : value
      end
    end
  end
end

#-------For use in the shell-----
if ARGV.size > 0
  abort("Usage: csv_to_json.rb input.csv output.json") unless ARGV.size == 2
  CSVtoJSON.convert_csv(ARGV[0], ARGV[1])
end