% Checks if any row is all 1s

function [out] = isAnyRowAll(A, num)
    out = 0;

    [n, m] = size(A);
    for r = 1:n % loop each row
        row = A(r,:); % select a row
        s = sum(row); % sum

        if s/m == num % if average = 1
            out = 1; % then all 1s
            return;
        end
    end

end