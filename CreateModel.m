function model=CreateModel(h)

    % Customer Data
    d=[42 46 10 47 34 9 17 30 49 49 12 49 49 27 41 11 24 47 41 49 35 6 44 47 36 39 39 23 35 12 37 6 17 7 9 42 36 19 48 6];
    xc=[43 38 76 79 18 48 44 64 70 75 27 67 65 16 11 49 95 34 58 22 75 25 50 69 89 95 54 13 14 25 84 25 81 24 92 34 19 25 61 47];
    yc=[35 83 58 54 91 28 75 75 38 56 7 5 53 77 93 12 56 46 1 33 16 79 31 52 16 60 26 65 68 74 45 8 22 91 15 82 53 99 7 44];
    N=numel(d);
    
    % Server Data
    c=[9104 8286 9817 9075 9238 7453 7262 9735 8715 7040 7752 9718 9033 9889 8737 8431 8548 7437 9083 8540];
    xs=[10 96 0 77 81 86 8 39 25 80 43 91 18 26 14 13 86 57 54 14];
    ys=[85 62 35 51 40 7 23 12 18 23 41 4 90 94 49 48 33 90 36 11];
    M=numel(xs);
    H=h; %minimum number of Hubs that have to be opened
    
    D=zeros(N,M);
    for i=1:N
        for j=1:M
            D(i,j)=norm([xc(i)-xs(j) yc(i)-ys(j)],2);
        end
    end
    

    
    model.N=N;
    model.M=M;
    model.d=d;
    model.xc=xc;
    model.yc=yc;
    model.c=c;
    model.xs=xs;
    model.ys=ys;
    model.D=D;
    model.H=H;

end