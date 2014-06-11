require 'csv'
require 'json'

module CSVtoJSON

  # Take a CSV file and spit out a JSON file.
  # If a column's header begins with a pound sign (#), the entire column is ignored  
  def self.convert_csv(input, output)
    rows = CSV.open(input).read
    rows = convert_scalars(rows)

    keys = rows.shift
    # mark null the headers that begin with pound sign (#)
    # ['#a','#b','#c','e','f','g'] becomes [nil,nil,nil,3,4,5]
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

  def self.convert_scalars(rows)
    booleans = { "true" => true, "false" => false }
    rows.map do |row|
      row.map do |value|
        next unless value.is_a?(String)
        if booleans.include?(value) 
          booleans[value]
        elsif value.match(/\d+\.\d+/)
          value.to_f
        elsif value.match(/\d+/)
          value.to_i
        else
          value
        end
      end
    end
  end
end

#-------For use in the shell-----
if ARGV.size > 0
  abort("Usage: csv_to_json.rb input.csv output.json") unless ARGV.size == 2
  CSVtoJSON.convert_csv(ARGV[0], ARGV[1])
end
