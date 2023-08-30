using Arrow, DataFrames, Colors, GLMakie

const dfc = DataFrame(Arrow.Table("./place_color.feather"))
dfc.color = reinterpret.(RGB24, dfc.pixel_color)
gdfs = groupby(dfc, :timestamp)
const xmin, xmax = extrema(dfc.cord1)
const ymin, ymax = extrema(dfc.cord2)

function prep_scene()
    scene = Figure(; backgroundcolor = :white)
    ax = Axis(scene[1,1]; autolimitaspect = 1, yreversed=true)

    canvas_matrix = Observable(fill(RGB24(colorant"white"), xmax-xmin+1, ymax-ymin+1))
    image!(ax, canvas_matrix)
    limits!(ax, (1500, 1850), (1300, 1150))

    scene, ax, canvas_matrix
end

function update_pixel!(img, cord1::Integer, cord2::Integer, color)
    idx1 = cord1 - xmin + 1
    idx2 = cord2 - ymin + 1
    img[][idx1, idx2] = color
    return nothing
end

function update_notify_pixels!(img, df::AbstractDataFrame)
    update_notify_pixels!(img, df.cord1, df.cord2, df.color)
    return nothing
end

function update_notify_pixels!(img, cord1::AbstractVector, cord2::AbstractVector, color)
    for (c1, c2, c) in zip(cord1, cord2, color)
        update_pixel!(img, c1, c2, c)
    end
    return nothing
end

function main(output="bad_apple.mp4")
    scene, ax, canvas_matrix = prep_scene(dfc)
    record(scene, output, 1:30:462849-19; framerate=30) do i
        for O = 0:29
            update_notify_pixels!(canvas_matrix, gdfs[i+O])
        end
        notify(canvas_matrix)
    end
    return output
end
