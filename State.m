classdef State 
    
    properties 
        Cases % Vector containing the number of cases in the state per day.
        Deaths % Vector containing the number of deaths in the state per day.
        State_name % State's name
    end
    
    methods
        function state = State(cases, deaths, name) % Constructor            
            state.Cases = cases;
            state.Deaths = deaths;
            state.State_name = name;
        end
    end
end