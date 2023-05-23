function [E,Pc] = Exprimental(n_layer,n_hid,pop1,test,n_in,n_out,target_test,test_ind,struct2)

% Define Variable Problem ---------------

nweight_ih = n_in*n_hid;
nweight_ho = n_hid*n_out;
bias = (n_hid*n_layer)+n_out;
num_w = nweight_ih+nweight_ho;
% dim = num_w+bias;

% dim = (n_in*n_hid)+((n_hid^2)*(hid-1))+(n_hid*n_out);
% bias = (n_hid*hid)+n_out;
Bias = pop1(num_w+1:end);
pop = pop1(1:num_w);

individual.x = [];
B_hh = individual;
w_hh = individual;
Bih = Bias(1:n_hid);
for g=1:n_layer-1
    B_hh(g).x = Bias(g*n_hid+1:(g+1)*n_hid);
end
index = (n_layer*n_hid)+1;
Boh = Bias(index:end);
    
nweight_ih1 = n_in*n_hid;
nweight_out = n_hid*n_out;
wIH = pop(1:nweight_ih1);
WHH = pop(nweight_ih1+1:num_w-nweight_out);
WHO = pop((num_w-nweight_out)+1:end);

w_ih = zeros(n_in,n_hid);
W_HO = zeros(n_hid,n_out);


for i=1 : n_in
    w_ih(i,:) = wIH((i-1)*n_hid+1 : i*n_hid);
end

for k =1:n_layer-1
    for j=1:n_hid
        w_hh(k).x(:,j) = WHH((j-1)*n_hid+1 : j*n_hid);
    end
end

for h = 1:n_out
    W_HO(:,h) = WHO((h-1)*n_hid+1 : h*n_hid);
end

% Output 1
% y1_step1.ymin = -1;
% y1_step1.gain = 2*ones(n_out,1);
% y1_step1.xoffset = 0*ones(n_out,1);

% Dimensions
[rowTR,~] = size(test);
nT = rowTR;

% Input 1
x = test;

% Layer 1
a1 = tansig_apply(repmat(Bih',1,nT) + w_ih'*x');
% a1 = feval(actFunhidden,(repmat(Bih',1,nT) + w_ih'*x));
% Hidden Layer
for k = 1:n_layer-1
        
        B = B_hh(k).x';
        X = w_hh(k).x';
%         a2 = tansig_apply(repmat(B,1,nT) + X*a1);
        a2 = feval(actFunhidden,(repmat(B,1,nT) + X*a1));
        a1 = a2;
        
end
    % end Layer
   
a2 = repmat(Boh',1,nT) + W_HO'*a1;

% y1 = mapminmax_reverse(a2,y1_step1);
%  y1 = mapminmax('reverse',a2,y1_step1);
y1 = mapminmax('reverse',a2',struct2);

y1 = y1';

[~,MaxInd] = max(y1);

[~,maxInd] = find(test_ind~=MaxInd);

matchInd = numel(maxInd);

E = 100*(matchInd/nT);

Pc = n_in*n_hid+(n_layer-1)*n_hid^2+n_hid*n_out+bias;


% f = perform_MSE(target_test,y1);

end

% function x = mapminmax_reverse(y,settings)
% x = bsxfun(@minus,y,settings.ymin);
% x = bsxfun(@rdivide,x,settings.gain);
% x = bsxfun(@plus,x,settings.xoffset);
% end

function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% function perf = perform_MSE(targets,outputs)
% 
% % Error
% error = gsubtract(targets,outputs);
% 
% %calculate performance by the MSE criterion
% perfs = error.^2;
% 
% perf = 0;
% perfN = 0;
% 
% perf = perf + sum(perfs(:));
% perfN = perfN + numel(perfs);
% 
% %perform normalization
% perf = perf / perfN;
% end
