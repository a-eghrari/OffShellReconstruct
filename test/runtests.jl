using OffShellReconstruct
using Test

@testset "OffShellReconstruct.jl" begin
    @test OffShellReconstruct.SUSY(4, 2).N == 4
end