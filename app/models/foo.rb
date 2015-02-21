class Foo
	attr_accessor :project_name, :total_surface, :total_tree

	def initialize(project_name, total_surface, total_tree)
      @project_name = project_name
      @total_surface = total_surface
      @total_tree = total_tree
   end
end