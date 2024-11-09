abstract type AbstractProset{T<:Integer} end

struct Proset{T<:Integer} <: AbstractProset{T}
    d::DiGraph{T}

    function Proset(d::DiGraph{T}) where {T<:Integer}
        return new{T}(d)
    end
end

function Proset(n::T) where {T<:Integer}
    return Proset(DiGraph{T}(n))
end

struct ProsetElement{T<:Integer}
    idx::T
    p::Proset{T}
end

function (==)(p1::Proset{T}, p2::Proset{T}) where {T<:Integer}
    return p1.d == p2.d
end


nv(p::Proset{T}) where {T<:Integer} = nv(p.d)

ne(p::Proset{T}) where {T<:Integer} = ne(p.d)

add_vertex!(p::Proset{T}) where {T<:Integer} = add_vertex!(p.d)

add_vertices!(p::Proset{T}, n::Integer) where {T<:Integer} = add_vertices!(p.d, n)

add_edge!(p::Proset{T}, e::Tuple{T,T}) where {T<:Integer} = add_edge!(p.d, e...)

function add_edges!(p::Proset{T}, es::AbstractVector{Tuple{T,T}}) where {T<:Integer}
    for e in es
        add_edge!(p.d, e...)
    end
end

function getindex(p::Proset{T}, i::T) where {T<:Integer}
    (1 <= i <= nv(p)) || throw(BoundsError(p, i))
    return ProsetElement(i, p)
end

# Optional: Add integer range indexing
function Base.getindex(p::Proset{T}, is::AbstractVector{T}) where {T<:Integer}
    all(1 .<= is .<= nv(p)) || throw(BoundsError(p, is))
    return [ProsetElement(i, p) for i in is]
end

function (≿)(a::ProsetElement{T}, b::ProsetElement{T}) where {T<:Integer}
    a.p == b.p || throw(ArgumentError("Elements must be from the same proset."))
    return has_path(a.p.d, a.idx, b.idx)
end

function (≾)(a::ProsetElement{T}, b::ProsetElement{T}) where {T<:Integer}
    a.p == b.p || throw(ArgumentError("Elements must be from the same proset."))
    return has_path(a.p.d, a.idx, b.idx)
end

function (≈)(a::ProsetElement{T}, b::ProsetElement{T}) where {T<:Integer}
    return (a ≿ b) && (b ≿ a)
end

function blockdiag(p1::Proset{T}, p2::Proset{T}) where {T<:Integer}
    d = blockdiag(p1.d, p2.d)
    return Proset(d)
end
