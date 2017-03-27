function Diagnosis = DGA_1 (method, ratios)
    ratios1=zeros(1,9);
    ratios1(1:size(ratios,2))=ratios(1:size(ratios,2));
    try
        if ~isempty(strfind(lower(method), '.exe'))
            fid = fopen('ratios.txt');
            fprintf(fid, '%f\n', ratios);
            fclose(fid);
            cmd=strcat('[status,out]=system(''',method,''');');
            eval(cmd);
            fid=fopen('diagnosis.txt');
            Diagnosis=fscanf(fid, '%f', [1 1]);
            fclose(fid);
        else
            cmd=strcat(method,'(ratios1);');
            Diagnosis=eval(cmd);
        end
    catch e
        strcat('Error attempting to calculate : ', cmd)
        Diagnosis = 7;
    end
end