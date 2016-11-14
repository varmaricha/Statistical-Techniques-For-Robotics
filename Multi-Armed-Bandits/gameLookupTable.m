classdef gameLookupTable < Game
    %GAMELOOKUPTABLE This is a concrete class defining a game defined by an
    %external input
    
    methods
        function self = gameLookupTable(tabInput, isLoss)
            
            self.nbActions = size(tabInput,1);         % 2 actions
            self.totalRounds = size(tabInput,2);    % 1000 time steps
            self.N = 0; % the current round counter is initialized to 0 
            % Input
            %   tabInput - input table (actions x rewards or losses)
            %   isLoss - 1 if input table represent loss, 0 otherwise
            if isLoss
                self.tabR = 1 - tabInput;
            else
                self.tabR = tabInput;
            end             
        end
        
    end
    
end
