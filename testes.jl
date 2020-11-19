using LinearAlgebra, Test

include("bissecurva.jl")

@testset "Zera uma galera" begin
  for f in [
    (x,y) -> x + y - 1,
    (x,y) -> x^2 + y^2 - 1,
    (x,y) -> log(x^2 + y^2 + 1e-4),
    (x,y) -> cos(y * x * π),
    (x,y) -> exp(x) - exp(y)
  ]
    S = bissecurva(f, 0.0, 1.0, 0.0, 1.0, ϵ=1e-2, max_iter=1000, max_sols=10)
    for sol in S
      @test abs(f(sol...)) < 1e-2
    end
  end
end

@testset "Casos específicos" begin
  box = [0.0, 1.0, 0.0, 1.0]
  @testset "x + y = 1 -> (0.5, 0.5)" begin
    S = bissecurva((x,y) -> x + y - 1, box..., max_sols=1)
    @test S[1] == (0.5, 0.5)
    @test length(S) == 1
  end

  @testset "Failure" begin
    f(x,y) = x^2 + y^2 + 1
    @test_throws ErrorException bissecurva(f, box...)
  end

  @testset "quatre" begin
    f(x,y) = x > 0.9 ? -10 : (x - 0.5)^2 + (y - 0.5)^2 - 0.125
    S = bissecurva(f, box..., max_sols=4)
    @test length(S) == 4
    sort!(S)
    @test S[1] == (0.25, 0.25)
    @test S[2] == (0.25, 0.75)
    @test S[3] == (0.75, 0.25)
    @test S[4] == (0.75, 0.75)
  end

  @testset "dot" begin
    f(x, y) = x^2 + y^2
    S = bissecurva(f, box..., max_sols=50, ϵ=1e-6, max_iter=1000)
    @test all([norm([sol...]) < 1e-3 for sol in S])
  end

  @testset "empty" begin
    S = bissecurva((x,y) -> x + y - 1.2, box..., max_iter=1)
    @test length(S) == 0
  end
end