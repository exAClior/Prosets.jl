using Prosets, Test
using Graphs


@testset "Proset Construction / Properties" begin
	d = DiGraph(4)
	p1 = Proset(d)
	@test p1 isa Proset{Int}

	p2 = Proset(4)
	@test p2 isa Proset{Int}

	@test p1 == p2
	@test p1 != Proset(5)
end


@testset "Add vertices" begin
	p = Proset(4)
	add_vertex!(p)
	@test nv(p.d) == 5
	add_vertices!(p, 3)
	@test nv(p.d) == 8 
end

@testset "Update relation" begin
	p = Proset(4)
	add_edge!(p, (1, 2))
	add_edge!(p, (2, 3))
	@test ne(p) == 2
	add_edges!(p, [(1, 2), (2, 3)])
	@test ne(p) == 2
    add_edges!(p, [(3, 4), (4, 1)])
	@test ne(p) == 4
	@test !add_edge!(p, (10, 20))
end

@testset "Indexing" begin
	p = Proset(4)

	@test p[1] isa ProsetElement 
	@test p[1:2] isa Vector{ProsetElement{Int64}}
	@test_throws BoundsError p[5]
end

@testset "Relation testing" begin
	p = Proset(4)
	add_edge!(p, (1, 2))

	@test p[1] ≿ p[2]

	@test !(p[2] ≾ p[1])


    add_edge!(p, (1, 3))
    add_edge!(p, (3, 1))

	@test p[1] ≈ p[3]
end

@testset "Block Diagonal" begin
	p1 = Proset(3)
	p2 = Proset(2)

    add_edges!(p1, [(1, 2), (1, 3), (2, 3)])
    add_edges!(p2, [(1, 2)])
	p_block = blockdiag(p1, p2)

	p_res = Proset(5)
	add_edges!(p_res, [(1, 2), (1, 3), (2, 3), (4, 5)])

	@test p_block == p_res
end
