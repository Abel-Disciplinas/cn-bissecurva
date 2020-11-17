using Plots, LinearAlgebra, Random
gr(size=(160 * 5, 90 * 5))

include("bissecurva.jl")

#--- Não mexer
num_sin = 30
Random.seed!(0)
cossenos = rand(num_sin) / 10
senos    = rand(num_sin) / 10

g(x) = begin
  sum(cos.(x * k / 4) * cossenos[k] for k = 1:num_sin) + sum(sin.(x * k / 4) * senos[k] for k = 1:num_sin)
end
altura_funcao(x) = 1 ./ (1 .+ exp.(-g(x)))
#---

"""
Um canhão está posicionado em x=-1.7, numa altura dada por uma função altura_funcao(x).
Ele tenta acertar uma localidade em x=alvo_x, com altura dada pela mesma função.
Para acertar a localidade, é precisa encontrar a inclinação θ e a velocidade inicial v
do tiro.
A trajetória do canhão em função de θ e v, é dada pela função canhao:

    X, Y = canhao(θ, v)

Para visualizar a trajetória você pode usar a função plot_canhao:

    plot_canhao(X, Y, alvo_x)

Seu objetivo é acertar a localidade, encontrando θ e v. Note que temos 2 variáveis, e os
métodos que vimos são para apenas uma variável. Você pode inventar a estratégia que quiser, mas ela precisa fazer sentido - você deve explicá-la.

Use as opções max_sols=50, ϵ=0.01, e max_iter=1000.

Hipótese: o valor alvo_x estará entre e 1.3 e 1.7.
Dica: A solução satisfaz θ ∈ [0, π/2] e v ∈ [1, 3]
"""
function todas_solucoes_do_canhao(alvo_x)
  # AQUI

  # return bissecurva(... max_sols=50, ϵ=0.01, max_iter=1000)
end

"""
    escolha_solucao_do_canhao(S, obj, alvo_x)

Dentre todas as soluções S, esta função escolhe uma de acordo com o objetivo passado pelo valor `obj`.
Casos:
- Se `obj == :min_v`, retorna a solução em `S` com o menor `v`.
- Se `obj == :max_v`, retorna a solução em `S` com o maior `v`.
- Se `obj == :min_θ`, retorna a solução em `S` com o menor `θ`.
- Se `obj == :max_θ`, retorna a solução em `S` com o maior `θ`.
"""
function escolhe_solucao_do_canhao(S, obj, alvo_x)
  if obj == :min_v
    # AQUI
  else
    error("$obj desconhecido")
  end
end

####################################
#---- DAQUI PRA BAIXO NÃO MEXA ----#
####################################

"""
    X, Y = canhao(θ, v)

Calcula um tiro de canhão saindo com ângulo θ e velocidade inicial v.
X e Y são vetores com a trajetória da bala de canhão.
h é uma função que retorna a altura do terreno.
"""
function canhao(θ, v)
  xc = -1.7
  yc = altura_funcao(xc)

  Δt = 1e-2
  vx = v * cos(θ)
  vy = v * sin(θ)
  X = [xc]
  Y = [yc]
  μ = 0.1
  while true
    ax = (yc - 1) * 0.2
    xc += vx * Δt
    yc += vy * Δt
    vx, vy = vx + ax * Δt, vy - Δt
    push!(X, xc)
    push!(Y, yc)
    if altura_funcao(xc) ≥ yc
      break
    end
  end

  return X, Y
end

"""
    plot_canhao(X, Y, θ, v, alvo_x)

Desenha o terreno e a trajetoria da bala de canhão.
"""
function plot_canhao(X, Y, θ, v, alvo_x)
  x = range(-16/9, 16/9, length=100)
  y = altura_funcao.(x)
  plot(x, y, leg=false, fill=true, c="#9b7653", grid=false, axis=false)
  Random.seed!(0)
  for yi = 1.1:0.1:2.0
    Δx = (yi - 0.7)
    xi = x[1] + 0.1 - rand() * 0.3
    while xi < x[end]
      plot!([xi, xi + Δx], [yi, yi], c=:lightblue, l=:arrow)
      xi += Δx + 0.1
    end
  end
  plot!(X, Y, c=:darkgreen, l=:dash)
  scatter!([X[1]], [Y[1]], c=:blue, ms=4)
  plot!(X[1] .+ [0, v * cos(θ)] / 5, Y[1] .+ [0, v * sin(θ)] / 5, l=:arrow, c=:blue)
  scatter!([X[end]], [Y[end]], c=:red, ms=10, m=:x)
  xc = alvo_x
  yc = altura_funcao(xc)
  scatter!([xc], [yc], c=:red, ms=4)

  θr = round(Int, θ * 180 / π)
  vr = round(v, digits=2)
  ar = round(alvo_x, digits=2)
  title!("θ = $(θr)°, v = $vr, alvo = $ar")
  xlims!(-16/9, 16/9)
  ylims!(0, 2)
end

function imagens_auxiliares()
  k = 1
  for (θ, v, alvo_x) in [
    (π / 4, 1.2, 1.5),
    (π / 2, 2.1, 1.5),
    (π / 3, 2.0, 1.6)
  ]
    X, Y = canhao(θ, v)
    plot_canhao(X, Y, θ, v, alvo_x)
    png("plots/canhao-$k")
    k += 1
  end
end