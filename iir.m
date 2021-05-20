% Implementação filtro IIR Passa Alta
function [y] = iir(x, bm, an)
    N = length(x);

    buffer_in = zeros(length(bm),1);
    buffer_out = zeros(length(an),1);

    b_total = length(bm);
    a_total = length(an);

    for n=1:N
        buffer_in_a = buffer_in;
        for k=1:b_total-1
            buffer_in(k+1) = buffer_in_a(k); 
        end 
        buffer_in(1) = x(n);

        sum1 = 0;
        for k=1:b_total
           sum1 = sum1 + buffer_in(k)*bm(k); 
        end

        sum2 = 0;
        for k=1:a_total-1
           sum2 = sum2 + buffer_out(k)*an(k+1); 
        end

        y(n) = sum1 - sum2;

        buffer_out_a = buffer_out;
        for k=1:a_total-1
            buffer_out(k+1) = buffer_out_a(k); 
        end 
        buffer_out(1) = y(n);    
    end
end

