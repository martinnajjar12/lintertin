require_relative '../lib/errors_checker'
files = Dir.glob('*.rb')
opened_file = File.open(files[0])
lines_array = []
File.foreach(opened_file) { |line| lines_array << line.chomp }

describe 'ErrorsChecker' do
  let(:errors_instance) { ErrorsChecker.new(lines_array, 'file.rb') }
  let(:simple_instance) { ErrorsChecker.new(['hi'], 'simple_file.rb') }
  let(:string) { "I'm a string" }

  describe '#delete_beginning_spaces' do
    it 'accepts a string and returns an array' do
      expect(errors_instance.delete_beginning_spaces(string)).to be_an Array
    end
  end

  describe '#iterate_thrgh_lines' do
    it 'gives access to 5 variables' do
      expect { |b| simple_instance.iterate_thrgh_lines(&b) }.to yield_successive_args([['hi'], 'hi', 0, 'hi', 'hi'])
    end
  end

  describe '#count_spaces' do
    it 'gives access to 5 variables' do
      expect { |b| simple_instance.count_spaces(&b) }.to yield_successive_args([0, 'hi', 2, 0, -2])
    end
  end
end
