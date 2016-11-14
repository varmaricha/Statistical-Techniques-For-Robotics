classdef policyGWM < Policy
    %POLICYGWM This policy implementes GWM for the bandit setting.
    
    properties
        nbActions % number of bandit actions
        lastAction
        weights
        N
        % Add more member variables as needed
    end
    
    methods
        
        function init(self, nbActions)
            % Initialize any member variables
            self.nbActions = nbActions;
            self.weights = ones(1, self.nbActions);
            self.N = 0;
            % Initialize other variables as needed

        end
        
        function action = decision(self)
            % Choose an action according to multinomial distribution            
            normalizedWeights = self.weights/sum(self.weights);            
            r = rand();
            for i = 1:length(self.weights)
                s = sum(normalizedWeights(1:i));
                if r <= s
                    self.lastAction = i;
                    break
                end
            end
        action =  self.lastAction;
        end
        
        function getReward(self, reward)
            self.N = self.N + 1;

            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;
            
            % Do more stuff here using loss Vector
            
            % Update the weights
            for i = 1:length(self.weights)                
                eta = sqrt(log(self.nbActions)/self.N);             
                %lossVector
                self.weights(i) = self.weights(i)*exp(-(eta*lossVector(i)));
                %self.weights
            end
        end        
    end
end

