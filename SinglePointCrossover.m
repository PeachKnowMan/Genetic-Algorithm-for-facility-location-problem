function [y1 y2]=SinglePointCrossover(x1,x2,h)

    nVar=numel(x1);
    
    cc=randsample(nVar-1,1);
    
    y1=[x1(1:cc) x2(cc+1:end)];
    y2=[x2(1:cc) x1(cc+1:end)];
    while sum(y1)<h || sum(y2)<h
        cc=randsample(nVar-1,1);
    
        y1=[x1(1:cc) x2(cc+1:end)];
        y2=[x2(1:cc) x1(cc+1:end)];
    end
end