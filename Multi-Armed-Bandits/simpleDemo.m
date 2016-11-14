%% This script applies a random policy on a constant game
clc;
close; 
clear all;
univ = load('data\univLatencies.mat');
%% Get the constant game
%game = gameGaussian(10,10000);
%game = gameConstant();
%game = gameLookupTable(univ.univ_latencies, 1);
game = gameAdversarial();
%% Get a set of policies to try out
%policies = {policyUCB()};
policies = {policyEXP3()};
%policyConstant(), policyRandom(), policyGWM(),policyEXP3(), policyUCB() 
policy_names = {'policyEXP3'};
%'policyConstant', 'policyRandom', 'policyGWM', 'policyEXP3', 'policyUCB'

%% Run the policies on the game
figure;
hold on;
for k = 1:length(policies)
    policy = policies{k};
    game.resetGame(); 
    [reward, action, regret] = game.play(policy);
    plot(action);
    axis([1,game.totalRounds,0,game.nbActions+1]);
    fprintf('Policy: %s Reward: %.2f\n', class(policy), sum(reward));
    %plot(regret);
    %title('Regret')
    title('Actions');
end
legend(policy_names);