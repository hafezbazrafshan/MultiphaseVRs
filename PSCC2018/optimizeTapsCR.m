function  [Network]=optimizeTapsCR(Network)
defineCommonOptimizationParameters;
defineCVXSettings;
cvx_begin sdp
%% 1. Define variables
defineCommonVariablesAndExpressions; %checked
defineUPsiVariables;
%% 2. Define objective;
defineObjective % checked
subject to:
%% 3. Constraints
defineCommonWConstraints; %checked
defineSgConstraints; %checked
definePowerFlowConstraintsU; %checked
defineCRConstraints;%checked
cvx_end

%% 4. Check Constraints
checkConstraints;

%% 5. Recover taps
recoverTaps;

%% 6. Return solution
defineCommonOptimizationOutputs;



