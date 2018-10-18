function y=Mutate(x,mu,h)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    y=x;
    y(j)=1-x(j);
    while sum(y)<h
        j=randsample(nVar,nmu);
    
        y=x;
        y(j)=1-x(j);
    end
end