function [ Symbol ] = DGA_Diagnosis( Code )

    if Code==1
        Symbol='PD';
    elseif Code==2
        Symbol='D1';
    elseif Code==3
        Symbol='D2';
    elseif Code==4
        Symbol='T1';
    elseif Code==5
        Symbol='T2';
    elseif Code==6
        Symbol='T3';
    elseif Code==7
        Symbol='UD';
    elseif Code==0
        Symbol='Nf';
    else
        Symbol='';
    end

end

