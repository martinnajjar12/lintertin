def select_files
  ruby_files = Dir.glob("*.rb")
  for file in ruby_files do
    opened_file = File.open(file)
    lines_array = []
    File.foreach(opened_file) do |line|
      lines_array << line.chomp
    end
    opened_file.close
  end
  lines_array
end
