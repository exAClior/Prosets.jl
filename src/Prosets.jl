module Prosets

	using Graphs
	# Write your package code here.

	import Graphs: nv, add_vertex!, add_vertices!, add_edge!, add_edges!, ne

	include("Core.jl")

	export Proset, nv, add_vertex!, add_vertices!, add_edge!, add_edges!, ne, is_succsim
end
