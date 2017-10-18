function LoadButtonImage(handle, filename, width, height)
    try
        [a,map]=imread(filename);
        [r,c,d]=size(a); 
        x=ceil(r/width); 
        y=ceil(c/height); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(handle,'CData',g);
    catch me
        display(['Can''t load image ' filename])
    end     
end
