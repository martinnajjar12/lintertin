require 'pry'
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
        puts "Trailing space at the end of the line number #{index + 1} in #{@file_name}"
      end
    end
  end

  def delete_beginning_spaces(str)
    spaces_counter = 0
    str.each_char do |char|
      if char == " "
        str = str.delete_prefix char
        spaces_counter += 1
      else
        break
      end
    end
    [str, spaces_counter]
  end

  def correct_identation
    @file_lines.each_with_index do |line, index|
      without_spaces_line = delete_beginning_spaces(line)[0]
      spaces_counter_line = delete_beginning_spaces(line)[1]
      @file_lines[index + 1].nil? ? spaces_counter_next_line = spaces_counter_line + 2 : spaces_counter_next_line = delete_beginning_spaces(@file_lines[index + 1])[1]
      words_array = without_spaces_line.split
      first_word_in_line = words_array[0]
      for keyword in @keywords do
        if keyword == first_word_in_line && spaces_counter_next_line - spaces_counter_line != 2
          puts "Wrong indentation at line #{index + 2} in #{@file_name}"
        end
      end
    end
  end

  def empty_lines
    @file_lines.each_with_index do |line, index|
      without_spaces_line = delete_beginning_spaces(line)[0]
      words_array = without_spaces_line.split
      first_word_in_line = words_array[0]
      for keyword in @keywords do
        if keyword == first_word_in_line && @file_lines[index + 1].empty?
          puts "Unnecessary empty line (number: #{index + 2}) in #{@file_name}"
        end
      end
    end
  end
end
