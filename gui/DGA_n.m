% update_progress_callback(current)
function Diagnosis = DGA_n (method, ratios_List, update_progress_callback)
    num_samples = size(ratios_List,1);
    Diagnosis = zeros(num_samples,1);
    progress = 0;
    for sample_row=1:num_samples
        progress = progress + 1;
        update_progress_callback(progress);
        Diagnosis(sample_row)=DGA_1(method, ratios_List(sample_row,:));
    end
end