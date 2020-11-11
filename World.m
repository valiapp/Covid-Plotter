classdef World
    
    properties
        Entire_world; % Country object containing data for the entire world.
                      % Its variable Cases contains the sum of all cases and variable
                      % Deaths contains the sum of all deaths in the world.
                      % None of the countries is separated into states or
                      % regions.
        Countries; % Vector containing all countries and their data.
    end
    
    methods
        function world = World(covid_data) % Constructor 
            
           [rows, ~] = size(covid_data);
           
           world.Entire_world = Country(covid_data);
           
           world.Countries = Country.empty; 

            j = 1;

            for i = 2 : rows
                if isempty(covid_data{i, 2})
                    world.Countries(j) = Country(covid_data, char(covid_data{i, 1}));
                    j = j + 1;
                end
            end
            
        end
        
        function index = CountryIndex(world, name)
            % Given a country's name, CountryIndex(world, name) returns the index
            % of this country in the Countries vector.
            
            [~, number_of_countries] = size(world.Countries);
                    
            for ii = 1 : number_of_countries
                if isequal(world.Countries(ii).Name, name)
                    break;
                end                            
            end
            
            index = ii;
        end
    end
    
end