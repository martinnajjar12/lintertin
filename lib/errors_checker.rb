module HelperModule
  def delete_beginning_spaces(str)
    spaces_counter = 0
    str.each_char do |char|
      break unless char == ' '

      str = str.delete_prefix char
      spaces_counter += 1
    end
    [str, spaces_counter]
  end

  def iterate_thrgh_lines
    @file_lines.each_with_index do |line, index|
      without_spaces_line = delete_beginning_spaces(line)[0]
      next if without_spaces_line.start_with?('#')

      words_array = without_spaces_line.split
      first_word_in_line = words_array[0]
      yield(words_array, first_word_in_line, index, line, without_spaces_line)
    end
  end

  def count_spaces
    iterate_thrgh_lines do |_, first_word_in_line, index, line|
      spaces_counter_line = delete_beginning_spaces(line)[1]

      spaces_counter_next_line = if @file_lines[index + 1].nil?
                                   spaces_counter_line + 2
                                 else
                                   delete_beginning_spaces(@file_lines[index + 1])[1]
                                 end

      spaces_counter_previous_line = if @file_lines[index + 1].nil?
                                       -2
                                     else
                                       delete_beginning_spaces(@file_lines[index - 1])[1]
                                     end

      yield(index, first_word_in_line, spaces_counter_next_line, spaces_counter_line, spaces_counter_previous_line)
    end
  end
end

class ErrorsChecker
  include HelperModule
  attr_reader :keywords, :no_offenses, :errors
  def initialize(file_lines, file_name)
    @file_lines = file_lines
    @file_name = file_name
    @keywords = %w[def class do if unless module begin while]
    @no_offenses = true
    @opening_tokens = ['{', '[', '(']
    @closing_tokens = ['}', ']', ')']
    @tokens_hash = { '}' => '{', ']' => '[', ')' => '(' }
    @errors = []
  end

  def trailing_spaces
    got_offenses = false
    @file_lines.each_with_index do |line, index|
      next unless line.end_with? ' '

      @no_offenses = false
      got_offenses = true
      @errors << "Trailing space at the end of the line number #{index + 1} in #{@file_name}"
    end
    got_offenses
  end

  def correct_indentation
    got_offenses = false

    count_spaces do |index, first_word, s_counter_next_line, s_counter_line, s_counter_prev_line|
      without_s_prev_line = delete_beginning_spaces(@file_lines[index - 1])[0]

      @keywords.each do |keyword|
        next unless keyword == first_word && s_counter_next_line - s_counter_line != 2

        @no_offenses = false
        got_offenses = true
        @errors << "Wrong indentation at line #{index + 2} in #{@file_name}"
      end
      next unless first_word == 'end' && without_s_prev_line != 'end' && s_counter_prev_line - s_counter_line != 2

      @no_offenses = false
      got_offenses = true
      @errors << "End keyword isn't indented correctly at line #{index + 1} in #{@file_name}"
    end
    got_offenses
  end

  def empty_lines
    got_offenses = false
    iterate_thrgh_lines do |_, first_word_in_line, index|
      @keywords.each do |keyword|
        next unless keyword == first_word_in_line && @file_lines[index + 1].empty?

        @no_offenses = false
        got_offenses = true
        @errors << "Unnecessary empty line (number: #{index + 2}) in #{@file_name}"
      end
    end
    got_offenses
  end

  def empty_line_at_bottom
    got_offenses = false
    if @file_lines[-1].empty? == false
      @no_offenses = false
      got_offenses = true
      @errors << "Please add an empty line at the bottom of your file #{@file_name}"
    end
    got_offenses
  end

  def end_keyword
    got_offenses = false
    keyword_counter = 0
    end_counter = 0
    iterate_thrgh_lines do |words_array|
      @keywords.each do |keyword|
        keyword_counter += 1 if words_array.include?(keyword)
      end
      end_counter += 1 if words_array.include?('end')
    end

    if keyword_counter > end_counter
      @no_offenses = false
      got_offenses = true
      @errors << "An end keyword is missing in #{@file_name}"
    elsif end_counter > keyword_counter
      @no_offenses = false
      got_offenses = true
      @errors << "Your file #{@file_name} has an extra end keyword."
    end
    got_offenses
  end

  def tokens
    got_offenses = false
    stack = []

    iterate_thrgh_lines do |_, _, _, _, without_spaces_line|
      without_spaces_line.each_char do |bracket|
        if @opening_tokens.include?(bracket)
          stack << bracket
        elsif @closing_tokens.include?(bracket)
          got_offenses = true unless stack.pop == @tokens_hash[bracket]
        end
      end
    end
    got_offenses = true unless stack.empty?
    if got_offenses
      @errors << "Missing '{', '}', '[', ']', '(' or ')' in #{@file_name}"
      @no_offenses = false
    end
    got_offenses
  end

  def pipes
    got_offenses = false
    pipe_spaces = after_before_pipe_space
    return pipe_spaces if pipe_spaces

    opening_pipes_counter = 0
    closing_pipes_counter = 0

    iterate_thrgh_lines do |words_array|
      words_array.each do |word|
        opening_pipes_counter += 1 if word.start_with?('|')
        closing_pipes_counter += 1 if word.end_with?('|')
      end
    end

    if opening_pipes_counter != closing_pipes_counter
      @no_offenses = false
      got_offenses = true
      @errors << "'|' is missing in #{@file_name}"
    end
    got_offenses
  end

  private

  def after_before_pipe_space
    got_offenses = false

    iterate_thrgh_lines do |words_array, _, index|
      words_array.each do |word|
        next unless word == '|'

        @no_offenses = false
        got_offenses = true
        @errors << "Unwanted space before/after '|' in line number #{index + 1}"
      end
    end
    got_offenses
  end
end
