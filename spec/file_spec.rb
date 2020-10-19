require_relative '../lib/ruby_file'

files = Dir.glob('*.rb')

describe RubyFile do
  let(:ruby_object) { RubyFile.new(files[0]) }

  describe '#initialize' do
    it 'returns a new object' do
      expect(RubyFile.new(files.sample)).to be_an(Object)
    end

    it 'lets you only read the name of the file' do
      expect(ruby_object.name).to eql('for_test.rb')
    end
  end

  describe '#lines_maker' do
    it 'returns an array contains only strings' do
      expect(ruby_object.lines_maker).to be_an(Array)
    end
  end
end