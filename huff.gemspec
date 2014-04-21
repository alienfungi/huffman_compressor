Gem::Specification.new do |s|
  s.name        = 'huff'
  s.version     = '0.2.1'
  s.executables = ['huff', 'unhuff']
  s.date        = '2014-04-21'
  s.summary     = 'Compresses documents using Huffman encoding'
  s.description = 'A command line huffman compression tool'
  s.authors     = ['Zane Woodfin']
  s.email       = 'pzwoodfin@gmail.com'
  s.files       = ['lib/huff.rb', 'lib/unhuff.rb', 'lib/huff/priority_queue.rb', 'lib/huff/node.rb']
  s.homepage    = 'http://www.zanewoodfin.com'
end
