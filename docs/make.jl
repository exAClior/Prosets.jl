using Prosets
using Documenter

DocMeta.setdocmeta!(Prosets, :DocTestSetup, :(using Prosets); recursive=true)

makedocs(;
    modules=[Prosets],
    authors="Yusheng Zhao <yushengzhao2020@outlook.com> and contributors",
    sitename="Prosets.jl",
    format=Documenter.HTML(;
        canonical="https://exAClior.github.io/Prosets.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/exAClior/Prosets.jl",
    devbranch="main",
)
