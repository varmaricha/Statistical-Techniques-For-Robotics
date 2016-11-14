classdef gameAdversarial<Game
    %GAMEADVERSARIAL This is a concrete class defining a game where rewards
    %   are adversarially chosen.

    methods
        
        function self = gameAdversarial()
            self.nbActions = 2;         
            self.totalRounds = 10000;
            self.tabR = zeros(self.nbActions, self.totalRounds);
            self.N = 0;
            for i = 1 : self.totalRounds
                if mod(i,5) == 0
                    self.tabR(1,i) = 0.1;
                    self.tabR(2,i) = 0.4;
                
                elseif mod(i,5) == 2
                    self.tabR(1,i) = 0.3;
                    self.tabR(2,i) = 0.9;                                                      

                elseif mod(i,5) == 4
                    self.tabR(1,i) = 0.3;
                    self.tabR(2,i) = 0.8;                    
                end
            end 
%             newtabR = (self.tabR)';
%             newtabR = rand(size(newtabR));
%             [R,C] = size(newtabR);
%             ii = 1:R;
%             jj = mod(ii,C);
%             jj(jj==0) = C;
%             newtabR(ii+(jj-1)*R) = 10; 
%             
%             self.tabR = newtabR';
                            
            end
                                
    end       
        
end

