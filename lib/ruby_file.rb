class RubyFile
  attr_reader :name
  def initialize(file)
    @file = file
    @name = File.basename(@file)
  end

  def lines_maker
    opened_file = File.open(@file)
    lines_array = []
    File.foreach(opened_file) do |line|
      lines_array << line.chomp
    end
    opened_file.close
    lines_array
  end
end
