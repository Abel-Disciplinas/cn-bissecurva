"""
    soluções = bissecurva(f, xa, xb, ya, yb)

Esta função encontra diversas soluções para a equação

    f(x,y) = 0.

No retângulo (x,y) ∈ [xa,xb]×[ya,yb]. Para tanto, a função f nos vértices
do retângulo não podem ter o mesmo sinal.

O método consiste de separar o retângulo em 4 partes, dividindo no meio
em x e em y. Para cada retângulo que sobrou:

- Se todos os sinais nos vértices são iguais, remova o retângulo.
- Para cada retângulo que sobrou, repita o processo.

Vamos usar a notação R(xa, xb, ya, yb) para indicar um retângulo.

Segue um pseudo-código:

1. Crie um vetor V = [R(xa, xb, ya, yb)] dos retângulos ainda considerados.
2. Crie um vetor S = [] que vai guardar as soluções.
3. Enquanto V ≂̸ ∅
  3.1. Pegue o primeiro elemento de V, digamos que R(xa, xb, ya, yb).
  3.2. Calcule xm = (xa + xb) / 2 e ym = (ya + yb) / 2.
  3.3. Se |f(xm, ym)| < ϵ ou |xb - xa| + |yb - ya| < ϵ
    3.3.1. Adicione (xm, ym) a S.
    3.3.2. volte a 3
  3.4. Crie T com os 4 retângulos formados com o vértice (xm, ym).
  3.5. Para cada retângulo r em T
    3.5.1. Se os valores de f em r tiverem o mesmo sinal, ignore rand
    3.5.2. Caso contrário, coloque r no fim de V.
"""
function bissecurva(f, xa, xb, ya, yb; ϵ = 1e-3, max_sols = 10, max_iter = 1000)
  # Use pares (x,y), não vetores [x;y].
  # Sugestão:
  box = [(xa, ya)  (xb, ya); (xa, yb)  (xb, yb)]

  fbox = [f(xy...) for xy in box]
  if all(fbox .> 0) || all(fbox .< 0)
    # erro
  end
  boxes = [box]
  solutions = []
  iter = 0
  while length(boxes) > 0
    # AQUI

    iter += 1
    if iter > max_iter
      break
    end
  end

  return solutions
end