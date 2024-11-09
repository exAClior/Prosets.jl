module Prosets

using Graphs
# Write your package code here.

import Graphs: nv, add_vertex!, add_vertices!, add_edge!, ne, blockdiag
import Base: getindex, ≈, ==

include("Core.jl")

export Proset, ProsetElement, nv, add_vertex!, add_vertices!, add_edge!, add_edges!, ne, ≿, ≾

end

