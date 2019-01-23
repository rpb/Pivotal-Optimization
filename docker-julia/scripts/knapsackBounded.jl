using JuMP, MathProgBase, MathOptInterface
using GLPK, GLPKMathProgInterface
using Cbc, Clp, Gurobi

struct KPDSupply{T<:Integer}
    item::String
    weight::T
    value::T
    quant::T
end
KPDSupply(itm::AbstractString, w::T, v::T, q::T=one(T)) where T<: Integer = KPDSupply(itm, w, v, q)
Base.show(io::IO, kdps::KPDSupply) = print(io, kdps.quant, " ", kdps.item, " ($(kdps.weight) kg, $(kdps.value) €)")

function solveIt(gear::Vector{KPDSupply{T}}, capacity::Integer, solver::DataType) where T<:Integer
    w = getfield.(gear, :weight)
    v = getfield.(gear, :value)
    q = getfield.(gear, :quant)
    sol = mixintprog(-v, w', '<', capacity, :Int, 0, q, solver())
    sol.status == :Optimal || error("this problem could not be solved")

    if all(q .== 1) # simpler case
        return gear[sol.sol == 1.0]
    else
        pack = similar(gear, 0)
        s = round.(Int, sol.sol)
        for (i, g) in enumerate(gear)
            iszero(s[i]) && continue
            push!(pack, KPDSupply(g.item, g.weight, g.value, s[i]))
        end
        return pack
    end
end


gear = [KPDSupply("map", 9, 150, 1),
        KPDSupply("compass", 13, 35, 1),
        KPDSupply("water", 153, 200, 2),
        KPDSupply("sandwich", 50, 60, 2),
        KPDSupply("glucose", 15, 60, 2),
        KPDSupply("tin", 68, 45, 3),
        KPDSupply("banana", 27, 60, 3),
        KPDSupply("apple", 39, 40, 3),
        KPDSupply("cheese", 23, 30, 1),
        KPDSupply("beer", 52, 10, 3),
        KPDSupply("suntan cream", 11, 70, 1),
        KPDSupply("camera", 32, 30, 1),
        KPDSupply("T-shirt", 24, 15, 2),
        KPDSupply("trousers", 48, 10, 2),
        KPDSupply("umbrella", 73, 40, 1),
        KPDSupply("waterproof trousers", 42, 70, 1),
        KPDSupply("waterproof overclothes", 43, 75, 1),
        KPDSupply("note-case", 22, 80, 1),
        KPDSupply("sunglasses", 7, 20, 1),
        KPDSupply("towel", 18, 12, 2),
        KPDSupply("socks", 4, 50, 1),
        KPDSupply("book", 30, 10, 2)]
mySolver = CbcSolver
pack = solveIt(gear, 400, mySolver)
println("The hiker should pack: \n - ", join(pack, "\n - "))
println("\nPacked weight: ", sum(getfield.(pack, :weight)), " kg")
println("Packed value: ", sum(getfield.(pack, :value)), " €")
