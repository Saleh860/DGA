function LoadButtonImage(handle, filename)
    [a,map]=imread(filename);
    [r,c,d]=size(a); 
    x=ceil(r/20); 
    y=ceil(c/20); 
    g=a(1:x:end,1:y:end,:);
    g(g==255)=5.5*255;
    set(handle,'CData',g);
end
