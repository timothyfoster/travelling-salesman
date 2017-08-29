stop = 0;
    
while( ~stop)

    prompt = '\nPlease select an option:\n1) Generate TSP.\n2) Read TSP.\n3) Solve Problem From City File.\n4) Solve TSP by City Increment\n5) Quit.\n Your Input: ';
    option = input(prompt);
    
    switch (option)
        case 1
            tspgen();
        case 2
            tspread(1);
        case 3
            tspread(0);
            tspsolve(0);
        case 4
            tspsolve(1);
        case 5
            stop = 1;
        otherwise
            display('Unable to parse input');
    end
    
    display('Press any key to continue...');
    pause;
    close all;
    clc;
end