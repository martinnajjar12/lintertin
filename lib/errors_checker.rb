require 'pry'
class ErrorsChecker
  attr_reader :keywords, :no_offenses
  def initialize(file_lines, file_name)
    @file_lines = file_lines
    @file_name = file_name
    @keywords = %w[def class do if module begin for]
    @no_offenses = true
  end

  def trailing_spaces
    @file_lines.each_with_index do |line, index|
      if line.end_with? (' ')
        @no_offenses = false
        puts "Trailing space at the end of the line number #{index + 1} in #{@file_name}"
      end
    end
  end

  def correct_indentation
    @file_lines.each_with_index do |line, index|
      without_spaces_line = delete_beginning_spaces(line)[0]
      without_spaces_previous_line = delete_beginning_spaces(@file_lines[index - 1])[0]
      spaces_counter_line = delete_beginning_spaces(line)[1]
      @file_lines[index + 1].nil? ? spaces_counter_next_line = spaces_counter_line + 2 : spaces_counter_next_line = delete_beginning_spaces(@file_lines[index + 1])[1]
      @file_lines[index - 1].nil? ? spaces_counter_previous_line = -2 : spaces_counter_previous_line = delete_beginning_spaces(@file_lines[index - 1])[1]
      words_array = without_spaces_line.split
      first_word_in_line = words_array[0]
      @keywords.each do |keyword|
        if keyword == first_word_in_line && spaces_counter_next_line - spaces_counter_line != 2
          @no_offenses = false
          puts "Wrong indentation at line #{index + 2} in #{@file_name}"
        end
      end
      if first_word_in_line == 'end' && without_spaces_previous_line != 'end' && spaces_counter_previous_line - spaces_counter_line != 2
        @no_offenses = false
        puts "End keyword isn't indented correctly at line #{index + 1} in #{@file_name}"
      end
    end
  end

  def empty_lines
    @file_lines.each_with_index do |line, index|
      without_spaces_line = delete_beginning_spaces(line)[0]
      words_array = without_spaces_line.split
      first_word_in_line = words_array[0]
      @keywords.each do |keyword|
        if keyword == first_word_in_line && @file_lines[index + 1].empty?
          @no_offenses = false
          puts "Unnecessary empty line (number: #{index + 2}) in #{@file_name}"
        end
      end
    end
  end

  def empty_line_at_bottom
    if @file_lines[-1].empty? == false
      @no_offenses = false
      puts "Please add an empty line at the bottom of your file #{@file_name}"
    end
  end

  private

  def delete_beginning_spaces(str)
    spaces_counter = 0
    str.each_char do |char|
      break unless char == ' '

      str = str.delete_prefix char
      spaces_counter += 1
    end
    [str, spaces_counter]
  end
end
