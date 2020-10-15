class ErrorsChecker
  attr_reader :keywords
  def initialize(file_lines, file_name)
    @file_lines = file_lines
    @file_name = file_name
    @keywords = %w(def class do if module begin for)
  end

  def trailing_space
    @file_lines.each_with_index do |line, index|
      if line.end_with?(" ")
        puts "Trailing space at the end of the line number #{index + 1} in the file #{@file_name}"
      end
    end
  end

  # def correct_identation
  #   @file_lines.each_with_index do |line, index|
  #     for keyword in @keywords do
  #       if line.include?(keyword)
  #         keyword_index = line.index(keyword[0])
  #         next_line = @file_lines[index + 1]
  #         next_line.start_with?(" ") ? spaces_number_next_line = next_line.sub(next_line.delete_prefix(" "), "").count(" ") : spaces_number_next_line = 0
  #         if spaces_number_next_line - keyword_index != 2
  #           puts "Wrong indentation at line #{index + 2} in file #{@file_name}"
  #         end
  #       end
  #     end
  #   end
  # end
end
