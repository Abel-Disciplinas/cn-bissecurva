using Printf

include("canhao.jl")

function resolve_canhao()
  contador = 1
  for alvo_x in 1.3:0.1:1.7
    S = todas_solucoes_do_canhao(alvo_x)
    for obj in [:min_v, :max_v, :min_θ, :max_θ]
      sol = escolhe_solucao_do_canhao(S, obj, alvo_x)
      println("sol = $sol")
      X, Y = canhao(sol...)
      plot_canhao(X, Y, sol..., alvo_x)
      s = @sprintf("plots/solucao-canhao-%s-%02d", obj, contador)
      png(s)
    end
    contador += 1
  end
end

resolve_canhao()