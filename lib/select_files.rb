def select_files
  if ARGV == []
    Dir.glob('*.rb')
  else
    ARGV
  end
end
