function Diagnosis = DGAs_n (methods, ratios_List)
    num_methods = length(methods);
    num_samples = size(ratios_List,1);
    Diagnosis = zeros(num_samples,num_methods);
    for method=1:num_methods
        Diagnosis(:,method)=DGA_n(cell2mat(methods(method)), ratios_List);
    end
end