classdef Country
    
    properties 
        States % Vector containing State class objects. If the country 
               % hasn't states variable States is an empty vector.
        Number_of_states; % Number of states the country has
        Cases % Vector containing the number of total cases in the country per day.
        Deaths % Vector containing the number of total deaths in the country per day.
        Name % Country's name
    end
    
    methods
        function country = Country(covid_data, country_name) % Constructor
            % COUNTRY_NAME must be a char array
                        
            [rows, columns] = size(covid_data);
            
            country.States = State.empty; 
              
            if nargin == 1
                % No argument is passed when constructing world object and 
                % especially its property named Entire_world (contains
                % data for the entire world).
                
                country.Cases = zeros(1, columns - 2); % Preallocation
                country.Deaths = zeros(1, columns - 2); % Preallocation
                
                for ii = 2 : rows
                    
                    cases = zeros(1, columns-2); % Preallocation
                    deaths = zeros(1, columns-2); % Preallocation
                    
                    if (isempty(covid_data{ii, 2}))
                        for i = 3 : columns
                            cases(i-2) = covid_data{ii, i}(1);
                            deaths(i-2) = covid_data{ii, i}(2); 
                        end
                    end
                    
                    country.Cases = country.Cases + cases;
                    country.Deaths = country.Deaths + deaths;
                end    
                
            else
            
                jj = 1;
                for ii = 2 : rows
                    if isequal(char(covid_data{ii, 1}), country_name)
             
                        cases = zeros(1, columns-2); % Preallocation
                        deaths = zeros(1, columns-2); % Preallocation
                    
                        for i = 3 : columns
                            cases(i-2) = covid_data{ii, i}(1);
                            deaths(i-2) = covid_data{ii, i}(2); 
                        end
                    
                        if(isempty(covid_data{ii, 2})) % Country's Properties  
                            country.Cases = cases;
                            country.Deaths = deaths;   
                            country.Name = country_name;
                        else    
                            name = char(covid_data{ii, 2});
                            country.States(jj) = State(cases, deaths, name); % State's Properties
                            jj = jj + 1;
                        end
                    
                    end
                end
                [~, country.Number_of_states] = size(country.States);
            end
        end
        
        function index = StateIndex(country, name)
            % Given a state's name, StateIndex(country, name) returns the index
            % of this state in the States vector.            
            % Method used only when country has states.
            
            for ii = 1 : country.Number_of_states
                if isequal(country.States(ii).State_name, name)
                    break;
                end                            
            end
            
            index = ii;
        end
    end
end    