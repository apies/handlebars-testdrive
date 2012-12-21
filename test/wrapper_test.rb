class Move

  def self.method_missing(method, *args)
    puts method
    puts args
  end


end
 




Move.old_all('stufgg')
# # ["Bob", "Steve"]
# p Person.all
# # ["Bob", "Steve", "Peter", "Owen"]