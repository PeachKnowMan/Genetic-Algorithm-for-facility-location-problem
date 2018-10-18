clc;
clear;
close all;

%% Problem Definition
ANSWER1=questdlg('Choose Minimum number of Hubs you want to open:','Creating Model','2','3','4','5');
model=CreateModel(str2num(ANSWER1));
global NFE;
NFE=0;
CostFunction=@(f) MyCost(f,model);
nVar=model.M;
VarSize=[1 nVar];
H=model.H;
%% GA Parameters

MaxIt=100;      % Maximum Number of Iterations

nPop=100;        % Population Size

pc=0.8;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)

pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants

mu=0.05;         % Mutation Rate

ANSWER=questdlg('Choose selection method:','Genetic Algorith',...
    'Roulette Wheel','Tournament','Random','s');

UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');
UseRandomSelection=strcmp(ANSWER,'Random');

if UseRouletteWheelSelection
    beta=5;         % Selection Pressure
end

if UseTournamentSelection
    TournamentSize=3;   % Tournamnet Size
end

pause(0.1);

%% Initialization

emptyf.Position=[];
emptyf.Cost=[];
emptyf.sol=[];
pop=repmat(emptyf,nPop,1);

for i=1:nPop
    
    pop(i).Position = CreateRandomSolution(model);
    [pop(i).Cost, pop(i).sol]=CostFunction(pop(i).Position);
    
end

%Sort Population
Costs = [pop.Cost];
[Costs, SortOrder] = sort(Costs);
pop = pop(SortOrder);

% Store Best Solution
BestSol = pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;

% Array to Hold Number of Function Evaluations
nfe=zeros(MaxIt,1);

%% Main Loop
for it = 1:MaxIt
    % Crossover
    popc = repmat(emptyf,nc/2,2);
    for k =1:nc/2
        % Select Parents Indices
        if UseRouletteWheelSelection
            P = exp(-beta*Costs/WorstCost);
            P = P/sum(P);
            i1 = RouletteWheelSelection(P);
            i2 = RouletteWheelSelection(P);
        end
        if UseTournamentSelection
            i1=TournamentSelection(pop,TournamentSize);
            i2=TournamentSelection(pop,TournamentSize);
        end
        if UseRandomSelection
            i1=randi([1 nPop]);
            i2=randi([1 nPop]);
        end
                % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=Crossover(p1.Position,p2.Position,H);
        
        % Evaluate Offsprings
        popc(k,1).Cost=CostFunction(popc(k,1).Position);
        popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
    end
    popc = popc(:);
    %Mutation
    popm = repmat(emptyf,nm,1);
    for m = 1:nm
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(m).Position=Mutate(p.Position,mu,H);
        
        % Evaluate Mutant
        popm(m).Cost=CostFunction(popm(m).Position);
            
    end
    % Create Merged Population
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);    
        
    % Truncation
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);    
        
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;        
        
    % Store NFE
    nfe(it)=NFE;

    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': NFE = ' num2str(nfe(it)) ', Best Cost = ' num2str(BestCost(it))]);
    
end
%% Result
figure;
PlotSolution(BestSol.Position,model)
figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('Cost');