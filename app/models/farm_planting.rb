class FarmPlanting
	attr_accessor :name, :total_surface, :total_tree

	def initialize(name, total_surface, total_tree)
      @name = name
      @total_surface = total_surface
      @total_tree = total_tree
   end
end