function [final_labels ] = FaBP(A,pseudopriors)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unifying Guilt-by-Association Approaches: Theorems and Fast Algorithms  %
% By Danai Koutra, Tai-You Ke, U Kang, Duen Horng Polo Chau, Hsing-Kuo    %
%  Kenneth Pao, and Christos Faloutsos.                                   %
% Proceedings of the ECML/PKDD 2011, (2011)                               %
%                                                                         %
% Online version: http://www.cs.cmu.edu/~dkoutra/papers/fabp_pkdd2011.pdf %
% Source: http://www.cs.cmu.edu/~dkoutra/pub.htm                          %
%                                                                         %
% Code by: Danai Koutra                                                   %
% Contact: danai@cs.cmu.edu                                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Implementation of Fast Belief Propagation (FaBP)                        %
%  for node classification in graphs.                                     %
%                                                                         %
% Required Files:                                                         %
%  DATA/A.mat: has the SPARSE adjacency matrix A of the input graph with  %
%               n nodes.                                                  %     
%  DATA/pseudopriors.mat: nx1 vector with the prior beliefs (labels).     %
%                         Range of initial labels                         %
%                          0: unknown label                               %
%                          1: GOOD (e.g., not spam)                       %
%                          2: BAD  (e.g., spam)                           %
%                                                                         %
% ~~~ NOTES ~~~                                                           %
% 1) About-half Approximations                                            %
% h_h = h - 1/2: this holds for the beliefs, the priors, the messages     %
% and the probabilities. So, all the quantities are in                    %
% "0 (+ or -) \epsilon" for small \epsilon.                               %
% 2) We solve the linear system by using the power series                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp('* * * * * * * * * * * * * * * * * * * * * * * * *');
%disp('*                                               *');
disp('*   FaBP(): Execution started...                *');
%disp('*                                               *');

%% Initialize some constants
max_power = 10;%10;           % maximum number of powers in power method
epsilon = 10^(-14);       %stopping criterion for power method

%% Initialize about-half quantities
prob_good = 0.5001;%0.5001; % not AI
prob_good_h = prob_good - 0.5;

%% Sparse matrices for memory efficiency:
% adjacency matrix, degree-diagonal matrix and identity matrix
%load('DATA/A');
sp_A = sparse(A);
no_nodes = max(size(sp_A,1), size(sp_A,2));
degrees = sum(sp_A,2);
sp_D = diag(degrees);
clear A D degrees;
c1 = trace(sp_D)+2;
c2 = trace(sp_D^2) - 1;
appropriate_hh_l1 = 1/(2*(max(max(sp_D))+1));
appropriate_hh_l2 = sqrt((-c1+sqrt(c1^2+4*c2))/(8*c2));
appropriate_hh = min(appropriate_hh_l1, appropriate_hh_l2);%min
h_h =  0.999*appropriate_hh;%0.999

%% Definitions of  a_h and c_h
ah = 4*h_h^2 /(1-4*h_h^2);
ch = 2*h_h / (1-4*h_h^2);

%% Prior beliefs
%load('DATA/pseudopriors.mat');
priors = pseudopriors * prob_good_h;

%% LINEAR SYSTEM: Fast Belief Propagation (FaBP)
M = ch*sp_A - ah*sp_D;

% Calculate the inverse of matrix I-M using the power method.
% (I-M)*b = phi => b = I*phi + M*phi + M*(M*phi) + M*(M*(M*phi)) + ...
inv_ = priors;
mat_ = M*priors;
power = 1;
while (max(max(mat_)) > epsilon && power < max_power )
    inv_ = inv_ + mat_;
    mat_ = M*mat_;
    power = power + 1;
end

if (power == max_power)
    disp('!! NO CONVERGENCE !!');
end

beliefs = inv_;
clear inv_;

%% Final node labels
idx_bad = beliefs < 0;
idx_good = beliefs > 0;
final_labels = zeros(no_nodes, 1);
final_labels(idx_bad,1) =1; % 2;
final_labels(idx_good,1) = 2;

%% SAVE THE RESULTS
%fid = fopen('finalLabels.out','w');
% fprintf(fid,'%d\n', final_labels);
% fclose(fid);
% disp('* Final node labels saved in "finalLabels.out". *');
% disp('* Format of file: one label (1 or 2) per line,  *');
% disp('*                 where line number == nodeID.  *');
% disp('*                                               *');
% disp('*   Execution ended.                            *');
% disp('*                                               *');
% disp('* * * * * * * * * * * * * * * * * * * * * * * * *');

end

