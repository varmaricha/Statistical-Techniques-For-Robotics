classdef gameGaussian < Game
    %GAMEGAUSSIAN This is a concrete class defining a game where rewards a
    %   are drawn from a gaussian distribution.
    
    methods
        
        function self = gameGaussian(nbActions, totalRounds) 
            % Input
            %   nbActions - number of actions
            %   totalRounds - number of rounds of the game
            self.nbActions = nbActions;         % 10 actions
            self.totalRounds = totalRounds;    % 10000 time steps
            %self.tabR = repmat([0.2; 0.8], 1, self.totalRounds); % table of rewards
            self.tabR = zeros(nbActions, totalRounds);
           
            for i = 1:nbActions
                mu = rand();
                sd = rand();
                for j = 1:totalRounds
                    self.tabR(i,j) = normrnd(mu,sd);
                    while self.tabR(i,j)<0 || self.tabR(i,j)>1
                        self.tabR(i,j) = normrnd(mu,sd);
                    end
                end
            end
            
                
            
%             for i = 1:nbActions
%                 mu = rand();
%                 sd = rand();
%                 self.tabR(i,:) = normrnd(mu, sd, [1,totalRounds]);
%                 actionvalues = self.tabR(i,:);
%                 [r,c] = find(actionvalues>1);
%                 actionvalues(sub2ind(size(actionvalues),r,c)) = mu;
%                 [r,c] = find(actionvalues<0);
%                 actionvalues(sub2ind(size(actionvalues),r,c)) = mu;
%                 self.tabR(i,:) = actionvalues;
%             end

            self.N = 0; % the current round counter is initialized to 0    
        end
        
    end    
end

