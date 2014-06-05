require 'csv'
require 'json'

module CSVtoJSON

  # Take a CSV file and spit out a JSON file
  #
  # If a column's header begins with a pound sign (#), the entire column is ignored  
  def self.convert_csv(input, output)
    rows = CSV.open(input).read
    rows = convert_booleans(rows)

    # nullify headers that begin with pound sign (#)
    # ['#a','#b','#c','e','f','g'] becomes [nil,nil,nil,'e','f','g']
    keys = rows.shift
    keys_nulled = keys.map.with_index(0) { |e,i| e.match(/\A\#.*/) ? nil : i }

    File.open(output, 'w') do |file|
      data = rows.map do |values|
        # ignore values whose header was nullified
        Hash[keys_nulled.zip(keys,values).map{|f| f[0].nil? ? nil : f[1,2]}.compact ]
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