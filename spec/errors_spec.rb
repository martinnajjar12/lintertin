require_relative '../lib/errors_checker'
files = Dir.glob('*.rb')
opened_file = File.open(files[0])
lines_array = []
File.foreach(opened_file) { |line| lines_array << line.chomp }

describe ErrorsChecker do
  let(:errors_instance) { ErrorsChecker.new(lines_array, 'file.rb') }

  describe '#trailing_spaces' do
    it "returns an error if there's a trainling space at the end of the line" do
      expect(errors_instance.trailing_spaces).to eql(true)
    end
  end

  describe '#correct_indentation' do
    it "returns an error if the line isn't indented correctly" do
      expect(errors_instance.correct_indentation).to eql(true)
    end
  end

  describe '#empty_lines' do
    it "returns an error if there's an unnecessary empty line" do
      expect(errors_instance.empty_lines).to eql(true)
    end
  end

  describe '#empty_line_at_bottom' do
    it 'returns an error if there is no empty line at the of the file' do
      expect(errors_instance.empty_line_at_bottom).to eql(true)
    end
  end

  describe '#end_keyword' do
    it 'returns an error if there is a missing end or an extra end' do
      expect(errors_instance.end_keyword).to eql(true)
    end
  end

  # rubocop:disable Layout/LineLength
  describe '#tokens' do
    it 'returns an error if there is a missing curly brace, square bracket or parenthesis' do
      expect(errors_instance.tokens).to eql(true)
    end
  end
  # rubocop:enable Layout/LineLength

  describe '#pipes' do
    it 'returns an error if there is a space before or after the pipe or a missing pipe' do
      expect(errors_instance.pipes).to eql(true)
    end
  end
end

opened_file.close
