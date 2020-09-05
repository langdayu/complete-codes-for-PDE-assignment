function showvarysolution (X,T,U)
    M = size(U ,2);
    figure
    xlabel('X');
    ylabel('U');
    s = [X(1) ,X(end),min(min(U)), max(max(U))];
    axis(s);
    for i = 1:M
        plot(X,U(:,i));
        axis(s);
        pause(0.0001) ;
        title([ 'T=',num2str(T(i)),' temperature at'])
    end
end