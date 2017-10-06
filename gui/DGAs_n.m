% update_progress_callback(maximum, current)
function Diagnosis = DGAs_n (methods, ratios_List, update_progress_callback)
    num_methods = length(methods);
    num_samples = size(ratios_List,1);
    Diagnosis = zeros(num_samples,num_methods);
    progress = 0;
    for method=1:num_methods
        if nargin > 2
            Diagnosis(:,method)= ...
                DGA_n(cell2mat(methods(method)), ratios_List, ...
                @(p) update_progress_callback(num_samples*num_methods, ...
                                            p+progress));
        else
              Diagnosis(:,method)= ...
                DGA_n(cell2mat(methods(method)), ratios_List);
        end
        
        progress = progress + num_samples;
    end
end