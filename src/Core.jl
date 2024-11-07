abstract type AbstractProset{T<:Integer} end


struct Proset{T<:Integer} <: AbstractProset{T}
	d::DiGraph{T}

	function Proset(d::DiGraph{T}) where T<:Integer
		return new{T}(d)
	end
end

function Proset(n::T) where T<:Integer
	d = DiGraph{T}(n)
	return Proset(d)
end

nv(p::Proset{T}) where T<:Integer = nv(p.d)

ne(p::Proset{T}) where T<:Integer = ne(p.d)

add_vertex!(p::Proset{T}) where T<:Integer = add_vertex!(p.d)

add_vertices!(p::Proset{T}, n::Integer) where {T<:Integer} = add_vertices!(p.d, n)

add_edge!(p::Proset{T}, e::Tuple{T, T}) where T<:Integer = add_edge!(p.d, e...)


function add_edges!(p::Proset{T}, es::AbstractVector{Tuple{T,T}}) where {T<:Integer} 
	for e in es	
		add_edge!(p.d, e...)
	end
end

function is_succsim(p::Proset{T}, x::T, y::T) where {T<:Integer}
	(has_vertex(p.d, x) && has_vertex(p.d,y) ) || throw(ArgumentError("Vertices $x and/or $y is not in the proset."))
    return has_path(p.d, x, y)
end
