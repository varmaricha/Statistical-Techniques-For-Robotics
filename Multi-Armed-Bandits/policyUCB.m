classdef policyUCB < Policy
    %POLICYUCB This is a concrete class implementing UCB.

        
    properties
        
        nbActions
        steps
        lastAction
        sum_reward
        counter
    end
    
    methods
        function init(self, nbActions)
            self.nbActions = nbActions;
            self.sum_reward = zeros(self.nbActions,1);
            self.counter = zeros(self.nbActions,1);
            self.steps = 0;% Initialize
        end
        
        function action = decision(self)
            bound = zeros(self.nbActions,1);
            self.steps = self.steps + 1;
            alpha = 1;
            if self.steps <= self.nbActions
                
                action = self.steps;
            else
                for n = 1:self.nbActions
                    
                    bound(n) = (self.sum_reward(n)/self.counter(n)) + ...
                    sqrt(alpha * log(self.steps)/(2 * self.counter(n)));
                end
                [~, action] = max(bound);% Choose action
                
            end
%             figure(1);
%             plot(self.steps, bound(1), 'r*');
%             hold on;
%             plot(self.steps, bound(2), 'g*');
%             legend({'action1', 'action2'});
%                        
            self.lastAction = action;
%             drawnow;
        end
        
        function getReward(self, reward)
            % Update ucb
            self.sum_reward(self.lastAction) = self.sum_reward(self.lastAction) + reward;
            self.counter(self.lastAction) = self.counter(self.lastAction) + 1;
        end        
    end

end