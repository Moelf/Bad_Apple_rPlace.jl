## Downloading data

Data source: https://placedata.reddit.com/data/canvas-history/2023/index.html

But I have cleaned up it into Apache Arrow format for sanity. [Download here]()
and put it at the repo's root directory.

Btw, you can always copy code blocks including `julia>`, the Julia REPL is smart enough to ignore
them when pasting.

## Setting up Julia

Download Julia, `juliaup` is recommended ([here](https://github.com/JuliaLang/juliaup)).

Navigate (e.g. `cd`) to this repo's root directory. And run:
```bash
julia --project=.

julia>
```

For first time only, you need to instantiate the dependencies, hit `]` once to enter `pkg>` mode:
```julia
(Bad_Apple_rPlace) pkg>
```

enter `instantiate` and hit enter:
```julia
(Bad_Apple_rPlace) pkg> instantiate
```

Afterwards you can hit `backspace` to return to REPL mode.

## Running

You should now be able to run the following:
```julia
julia> include("./main.jl");

julia> main(; test_run=true)
Progress:  97%|███████████████████████████████████████████████████████████▎ |  ETA: 0:00:00
Done!
```

You should see a `bad_apple.mp4`, if you set `test_run=false`, it should take about 10 minutes to
render the full movie.
