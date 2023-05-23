function [classification_acc, num_feature ] = BMTLBO(train,test)

CostFunction=@(s) FeatureSelectionCost(s,train, test);     % Cost Function

nVar = size(train,2);       % Number of Decision Variables
nVar = nVar-1;
VarSize = [1 nVar];   % Decision Variables Matrix Size

VarMin = -1;       % Unknown Variables Lower Bound
VarMax = 1;       % Unknown Variables Upper Bound

%% TLBO Parameters

MaxIt = 100;        % Maximum Number of Iterations

nPop = 50;           % Population Size

%% Initialization

% Empty Structure for Individuals
empty_individual.Position = [];
empty_individual.BPosition = [];

empty_individual.Cost = [];
empty_individual.Out=[];

% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);

% Initialize Best Solution
BestSol.Cost = inf;

newP = [];
newPB = [];
newF = [];
% Initialize Population Members
for i = 1:nPop
    
    % Initialize Position
    pop(i).Position=rand(VarSize)*(VarMax-VarMin)+VarMin;
    newP = [newP
        pop(i).Position];
    
    pop(i).BPosition = Mappingg(pop(i).Position);
    
    newPB = [newPB
        pop(i).Position];
    
    
    % Evaluation
    [pop(i).Cost, pop(i).Out]=CostFunction(pop(i).BPosition);
    
    newF = [newF
        pop(i).Cost];
    
    if pop(i).Cost < BestSol.Cost
        BestSol = pop(i);
    end
end

% Initialize Best Cost Record
BestCosts = zeros(MaxIt, 1);

%% TLBO Main Loop

for it = 1:MaxIt
    
    % Calculate Population Mean
    Mean = 0;
    for i = 1:nPop
        Mean = Mean + pop(i).Position;
    end
    Mean = Mean/nPop;
    
    % Select Teacher
    Teacher = pop(1);
    for i = 2:nPop
        if pop(i).Cost < Teacher.Cost
            Teacher = pop(i);
        end
    end
    
    
    
    % Teacher Phase
    for i = 1:nPop
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching Factor
        TF = randi([1 2]);
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position ...
            + rand(VarSize).*(Teacher.Position - TF*Mean);
        
        newP = [newP
            newsol.Position];
        % Clipping
        %         newsol.Position = Mappingg(newsol.Position);
        newsol.BPosition = Mappingg(newsol.Position);
        newPB = [newPB
            newsol.BPosition];
        
        % Evaluation
        [newsol.Cost, newsol.Out]=CostFunction(newsol.BPosition);
        
        newF = [newF
            newsol.Cost];
        
        % Comparision
        if newsol.Cost<pop(i).Cost
            pop(i) = newsol;
            if pop(i).Cost < BestSol.Cost
                BestSol = pop(i);
            end
        end
    end
    
    % Learner Phase
    for i = 1:nPop
        
        A = 1:nPop;
        A(i) = [];
        j = A(randi(nPop-1));
        
        Step = pop(i).Position - pop(j).Position;
        if pop(j).Cost < pop(i).Cost
            Step = -Step;
        end
        
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position + rand(VarSize).*Step;
        
        newP = [newP
            newsol.Position];
        
        % Clipping
        newsol.BPosition = Mappingg(newsol.Position);
        newPB = [newPB
            newsol.BPosition];
        
        % Evaluation
        [newsol.Cost,newsol.Out] = CostFunction(newsol.BPosition);
        newF = [newF
            newsol.Cost];
        
        % Comparision
        if newsol.Cost<pop(i).Cost
            pop(i) = newsol;
            if pop(i).Cost < BestSol.Cost
                BestSol = pop(i);
            end
        end
    end
    
    %%       Pooling
    
    wrost = pop(1);
    for i = 2:nPop
        if pop(i).Cost > wrost.Cost
            wrost = pop(i);
        end
    end
    
    [~, ind] = min(newF);
    Teacher.Position = newP(ind , :);
    Pool = [];
    for p =1:nPop
        B = randi([0 1],VarSize);
        B_reverse= zeros(VarSize);
        B_reverse(B==0)=1;
        
        
        up_teacher = max(Teacher.Position);
        lb_teacher = min(Teacher.Position);
        X_best_rand = rand*(up_teacher-lb_teacher)+lb_teacher;
        
        Xp = (B.*X_best_rand) + (B_reverse.*wrost.Position);
        Pool = [Pool
            Xp];
    end
    
    for i = 1: nPop
        Pp = randi (nPop,[1,2]);
        newsol.Position = pop(i).Position + rand*(Pool(Pp(1),:)-Pool(Pp(2),:));
        
        newP = [newP
            newsol.Position];
        
        % Clipping
        newsol.BPosition = Mappingg(newsol.Position);
        newPB = [newPB
            newsol.BPosition];
        
        % Evaluation
        [newsol.Cost,newsol.Out] = CostFunction(newsol.BPosition);
        newF = [newF
            newsol.Cost];
        
    end
    
    [sortFit,sortInd] = sort(newF);
    newF = sortFit;
    newP = newP(sortInd,:);
    newPB = newPB(sortInd,:);
    newF = newF(1:nPop);
    newP = newP(1:nPop,:);
    newPB = newPB(1:nPop,:);
    
    for ii =1:nPop
        pop(i).Position = newP(i,:);
        pop(i).BPosition = newPB(i,:);
        pop(i).Cost = newF(i);
    end
    
    
    % Store Record for Current Iteration
    BestCosts(it) = newF(1);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
    
end

classification_acc = BestCosts(end);
num_feature = numel(find(newPB(1,:)~=0));
end
