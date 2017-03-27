function Diagnosis = DGA_n (method, ratios_List)
    num_samples = size(ratios_List,1);
    Diagnosis = zeros(num_samples,1);
    for sample_row=1:num_samples
        Diagnosis(sample_row)=DGA_1(method, ratios_List(sample_row,:));
    end
end