% update_progress_callback(maximum, current)
function [Diagnosis,Canceled] = DGAs_n (methods, ppms_List, update_progress_callback)
    num_methods = length(methods(:,3));
    num_samples = size(ppms_List,1);
    Diagnosis = zeros(num_samples,num_methods);
    progress = 0;
    Canceled = false;
    for method=1:num_methods
        if nargin > 2
            [Diagnosis(:,method), C] = ...
                DGA_n(cell2mat(methods(method,3)), ppms_List, ...
                @(p) update_progress_callback(num_samples*num_methods, ...
                    p+progress ...
                    ,['Applying ',char(methods(method,2)), '...'] ...
                    ));
                if C
                    Canceled = true;
                    return
                end
        else
              Diagnosis(:,method)= ...
                DGA_n(cell2mat(methods(method,3)), ppms_List);
        end
        
        progress = progress + num_samples;
    end
end

% update_progress_callback(current)
function [Diagnosis, Canceled] = DGA_n (method, ppms_List, update_progress_callback)
    num_samples = size(ppms_List,1);
    Diagnosis = zeros(num_samples,1);
    progress = 0;
    Canceled = false;
    for sample_row=1:num_samples
        progress = progress + 1;
        if nargin >2 
            if update_progress_callback(progress)
                Canceled=true;
                return
            end
        end
        
        Diagnosis(sample_row)=DGA_1(method, ppms_List(sample_row,:));
    end
end

function Diagnosis = DGA_1 (method, ppms_)
    ppms=-1*ones(1,9);
    ppms(1:size(ppms_,2))=ppms_(1:size(ppms_,2));
    ppms(isnan(ppms))=-1;
    %Assume diagnosed fault is "undefined", i.e. 7
    %If the invoked method doesn't set a specific
    %diagnosis code, the default is 7
    Diagnosis = 7;
    try
        if ~isempty(strfind(lower(method), '.exe'))
            InFile = 'ppms.txt';
            OutFile = 'diagnosis.txt';
            fid = fopen(InFile,'w');
            fprintf(fid, '%f\n', ppms);
            fclose(fid);
            cmd=strcat('[status,out]=system(''',method, ...
                ' <', InFile, ' >', OutFile, ''');');
            eval(cmd);
            fid=fopen(OutFile,'r');
            Diagnosis=fscanf(fid, '%f', [1 1]);
            fclose(fid);
            eval(['delete ' InFile ' ' OutFile]);
        elseif ~isempty(strfind(lower(method), '.m'))
            h2=ppms(1);   ch4=ppms(2);  c2h6=ppms(3);
            c2h4=ppms(4); c2h2=ppms(5); co=ppms(6);
            co2=ppms(7); n2=ppms(8);   o2=ppms(9);
            cmd='run(method);';
            eval(cmd);
        else
            display(strcat('Error attempting to calculate : ', method))
        end
    catch e
        display(strcat('Error attempting to calculate : ', method))
    end
end
