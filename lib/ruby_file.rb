class RubyFile
  attr_reader :name
  def initialize(file)
    @file = file
    @name = File.basename(@file)
  end

  def lines_maker
    opened_file = File.open(@file)
    read_file = File.read(opened_file)
    lines_array = []
    File.foreach(opened_file) do |line|
      lines_array << line.chomp
    end
    # Add an empty string to the end of the array if the file has an empty line at the end.
    lines_array << '' if read_file.end_with?("\n") || read_file.end_with?("\r\n")
    opened_file.close
    lines_array
  end
end
