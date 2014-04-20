Gem::Specification.new do |s|
  s.name        = 'huff'
  s.version     = '0.0.0'
  s.executables << 'huff'
  s.date        = '2010-04-28'
  s.summary     = 'Compresses documents using Huffman encoding'
  s.description = 'A command line huffman compression tool'
  s.authors     = ['Zane Woodfin']
  s.email       = 'pzwoodfin@gmail.com'
  s.files       = ['lib/huff.rb', 'lib/huff/priority_queue.rb', 'lib/huff/tree.rb', 'lib/huff/node.rb']
  s.homepage    = 'http://www.zanewoodfin.com'
  s.add_runtime_dependency 'ptools'
end
