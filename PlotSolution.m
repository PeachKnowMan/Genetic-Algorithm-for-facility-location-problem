function PlotSolution(f,model)

    [~, sol]=MyCost(f,model);
    A=sol.A;
    if isempty(A)
        return;
    end

    N=model.N;
    xc=model.xc;
    yc=model.yc;
    xs=model.xs;
    ys=model.ys;
    
    for i=1:N
        j=A(i);
        plot([xc(i) xs(j)],[yc(i) ys(j)],'LineWidth',2);
        hold on;
    end
    
    plot(xc,yc,'ko');
    
    plot(xs(f==1),ys(f==1),'rs','MarkerSize',12,'MarkerFaceColor','y');
    plot(xs(f==0),ys(f==0),'rs','MarkerSize',10);
    
    hold off;

end