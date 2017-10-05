function Diagnosis = DGA_1 (method, ratios_)
    ratios=-1*ones(1,9);
    ratios(1:size(ratios_,2))=ratios_(1:size(ratios_,2));
    ratios(isnan(ratios))=-1;
    try
        if ~isempty(strfind(lower(method), '.exe'))
            InFile = 'ratios.txt';
            OutFile = 'diagnosis.txt';
            fid = fopen(InFile,'w');
            fprintf(fid, '%f\n', ratios);
            fclose(fid);
            cmd=strcat('[status,out]=system(''',method, ...
                ' <', InFile, ' >', OutFile, ''');');
            eval(cmd);
            fid=fopen(OutFile,'r');
            Diagnosis=fscanf(fid, '%f', [1 1]);
            fclose(fid);
            eval(['delete ' InFile ' ' OutFile]);
        elseif ~isempty(strfind(lower(method), '.m'))
            h2=ratios(1);   ch4=ratios(2);  c2h6=ratios(3);
            c2h4=ratios(4); c2h2=ratios(5); co=ratios(6);
            co2=ratios(7); n2=ratios(8);   o2=ratios(9);
            cmd='run(method);';
            eval(cmd);
        else
        display(strcat('Error attempting to calculate : ', method))
            Diagnosis=7;
        end
    catch e
        display(strcat('Error attempting to calculate : ', method))
        Diagnosis = 7;
    end
end
