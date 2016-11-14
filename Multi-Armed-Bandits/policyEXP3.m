classdef policyEXP3 < Policy
    %POLICYEXP3 This is a concrete class implementing EXP3.
    
    properties
        % Define member variables
        nbActions % number of bandit actions
        lastAction
        weights
        N
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
            normalizedWeights = self.weights/sum(self.weights);

            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            scaledLossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;
            
            for i = 1 : length(self.weights)
                scaledLossVector(i) = lossVector(i)/normalizedWeights(i);
            end
            
            
            % Do more stuff here using loss Vector
            
            % Update the weights
            for i = 1:length(self.weights)                
                eta = sqrt(log(self.nbActions)/(self.N*self.nbActions));             
                %lossVector
                self.weights(i) = self.weights(i)*exp(-(eta*scaledLossVector(i)));
                %self.weights
            end
        end        
    end
end

