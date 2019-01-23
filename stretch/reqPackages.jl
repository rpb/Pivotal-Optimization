using Pkg
Pkg.update()
Pkg.add(PackageSpec(url="https://github.com/essenciary/Genie.jl"))
Pkg.add(PackageSpec(url="https://github.com/JuliaDB/DBI.jl"))
Pkg.add(PackageSpec(url="https://github.com/JuliaDB/PostgreSQL.jl"))
Pkg.add(PackageSpec(url="https://github.com/essenciary/Flax.jl"))
Pkg.add(PackageSpec(url="https://github.com/essenciary/SearchLight.jl"))
Pkg.add("JuMP")
Pkg.add("Convex")
Pkg.add("MathProgBase")
Pkg.add("MathOptInterface")
Pkg.add("Clp")
Pkg.add("Cbc")
Pkg.add("GLPK")
Pkg.add("GLPKMathProgInterface")
Pkg.add("Ipopt")
Pkg.add("Optim")


#RUN julia -e 'Pkg.clone("https://github.com/JuliaDB/DBI.jl.git")'
