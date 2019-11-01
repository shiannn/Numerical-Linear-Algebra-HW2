function x = Gaussian(A,b);
    [row,col]=size(A);
    n = row;
    x = zeros(n,1);
    Colname = [1:col];
    for k=1:n-1  
        %select row 
        maxVal = -1;
        for i = k:n
            for j = k:n 
                if (A(i,j)> maxVal)
                    maxRow = A(i,j);
                    maxRowIdx = i;
                    maxColIdx = j;
                end
            end
        end
        %row change
        [maxRowIdx maxColIdx]
        A( [k, maxRowIdx], : ) = A( [maxRowIdx, k], : );
        b([k,maxRowIdx]) = b([maxRowIdx,k]);
        A( :,[k, maxColIdx] ) = A( : ,[k, maxColIdx]);
        Colname([k, maxColIdx]) = Colname([maxColIdx, k]);

        for i=k+1:n
            xMultiplier = A(i,k)/A(k,k);
            for j=k:col
                A(i,j) = A(i,j)-xMultiplier*A(k,j);
            end
            b(i) = b(i)-xMultiplier*b(k);
        end
        Colname
    end
    % backsubstitution:
    x(n) = b(n)/A(n,n);
    for i=n-1:-1:1
        summation = b(i);
        for j=i+1:n
            summation = summation-A(i,j)*x(j);
        end
        x(i) = summation/A(i,i);
    end
end