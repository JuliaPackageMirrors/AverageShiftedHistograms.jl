module AverageShiftedHistograms

import StatsBase
import StatsBase: nobs, fit!
import Distributions
import UnicodePlots
using RecipesBase


export
    ash, fit!, extendrange, xy, xyz, nout, nobs,
    # Kernels
    Kernels,
    biweight, cosine, epanechnikov, triangular, tricube, triweight, uniform,
    gaussian, logistic


# common
abstract AbstractAsh
StatsBase.nobs(o::AbstractAsh) = o.nobs
nout(o::AbstractAsh) = nobs(o) - sum(o.v)

"""
`extendrange(x, s = .5, n = 200)`

Create a `LinSpace` of length `n` starting at `s` standard deviations below
`minimum(x)` and ending at `s` standard deviations above `maximum(x)`
"""
function extendrange(y::AbstractVector, s = 0.5, n = 200)
    σ = std(y)
    linspace(minimum(y) - s * σ, maximum(y) + s * σ, n)
end

include("kernels.jl")
include("univariate.jl")
include("bivariate.jl")
end
