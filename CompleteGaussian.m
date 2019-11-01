function x = Gaussian(A,b);
    [row,col]=size(A);
    n = row;
    x = zeros(n,1);
    pointer = [1:n];
    for k=1:n-1  
        %select row 
        maxRowCol = -1;
        for i = k:n
            for j = k:n
                if (A(i,j)>= maxRowCol)
                    maxRowCol = A(i,k);
                    maxRowIdx = i;
                    maxColIdx = j;
                end
            end
        end
        %row change
        A( [k, maxRowIdx], : ) = A( [maxRowIdx, k], : );
        b([k,maxRowIdx]) = b([maxRowIdx,k]);
        %column change
        A( : ,[k, maxColIdx])  = A( : ,[maxColIdx , k]);
        %x([k, maxColIdx]) = x([maxColIdx , k]);
        pointer([k, maxColIdx]) = pointer([maxColIdx , k]);

        for i=k+1:n
            xMultiplier = A(i,k)/A(k,k);
            for j=k:col
                A(i,j) = A(i,j)-xMultiplier*A(k,j);
            end
            b(i) = b(i)-xMultiplier*b(k);
        end
    end
    A
    b
    % backsubstitution:
    x(n) = b(n)/A(n,n);
    for i=n-1:-1:1
        summation = b(i);
        for j=i+1:n
            summation = summation-A(i,j)*x(j);
        end
        x(i) = summation/A(i,i);
    end
    pointer
end