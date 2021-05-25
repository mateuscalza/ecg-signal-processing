% Implementacão filtro IIR Passa Alta
function [y] = fir(x, bm)

    n_total = length(x);
    b_total = length(bm);
    buffer_in = zeros(1,b_total);

    for n=1:n_total
        buffer_in_a = buffer_in;
        for k=1:b_total-1
           buffer_in(k+1) = buffer_in_a(k); 
        end
        buffer_in(1) = x(n);
        y(n) = sum(bm.*buffer_in);
    end

end
