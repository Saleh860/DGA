function [ histogram ] = AnalyzeResults( results, actual )
    m = size(results,2);
    histogram = zeros([10 7 m]);
    for i=1:m
        %ACT
        for j=1:6
            histogram(1,j,i)=sum(actual==j);

            %Diagnosis
            for k=1:7
                histogram(k+1,j,i) = sum((10*results(:,i)+actual)==(10*k+j));
            end
            
            histogram(9,j,i)   = sum((10*results(:,i)+actual)==j);
            histogram(10,j,i)  = 100*sum((10*results(:,i)+actual)==11*j)/histogram(1,j,i);
        end        
        for k=1:9
            histogram(k,7,i) = sum(histogram(k,1:6,i));
        end
        
        histogram(10,7,i) = 100*sum(results(:,i)==actual)/histogram(1,7,i);
    end
    histogram = histogram(1:10,:)';
end
