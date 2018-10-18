function f=CreateRandomSolution(model)

    M=model.M;
    H=model.H;
    f=randi([0 1],1,M);
    while sum(f)<H
        f=randi([0 1],1,M);
    
    end
end