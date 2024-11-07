using Prosets, Test
using Graphs


@testset "Construction" begin
	d = DiGraph(4)
	p = Proset(d)

	@test p isa Proset{Int}
end

@testset "Properties" begin

	d = DiGraph(4)
	p = Proset(d)

	@test nv(p) == 4
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

@testset "Relation testing" begin
	p = Proset(4)
	add_edge!(p, (1, 2))

	@test_throws ArgumentError is_succsim(p, 50, 2)
	@test_throws ArgumentError is_succsim(p, 1, 76)

	@test is_succsim(p, 1, 2) 
	@test !is_succsim(p, 2, 1)
end