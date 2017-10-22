function movegui(hFig, position)
  %Make sure hFig is a valid graphics handle and is not the root graphics handle
  if ~ishghandle(hFig) | hFig==0
    error('movegui() first parameter must be a graphics handle');
  end
  
  %Get parent
  hParent = get(hFig,'Parent');

  %Get parent size in pixels
  old_parent_units = get(hParent,'units');  
  
  %Add cleanup step
  CleanUp = @() set(hParent, 'units', old_parent_units);
  
  set(hParent, 'units', 'pixels');
  if hParent==0
    Parent_Size = get(hParent, 'ScreenSize');
  else
    Parent_Size = get(hParent, 'Position');
  end

  %Get figure OuterPosition in pixels
  old_fig_units = get(hFig, 'Units');  
  CleanUp = @() seq( ...
    @() set(hFig, 'Units', old_fig_units), ...
    CleanUp);
  
  set(hFig, 'Units', 'pixels');
  if hParent==0
    old_pos = get(hFig, 'Position');
  else
    old_pos = get(hFig, 'OuterPosition');
  end  
  xshift=0;  yshift=0;
  
  if nargin==1
        xshift = (Parent_Size(3)-old_pos(3))/2-old_pos(1);
        yshift = (Parent_Size(4)-old_pos(4))/2-old_pos(2);      
  elseif ischar(position)    
    switch position
      case 'north'  %Top center edge of screen
        yshift =Parent_Size(4)-sum(old_pos([2,4]));
      case 'south'  %Bottom center edge of screen
        yshift= -old_pos(2);
      case 'east'   %Right center edge of screen
        xshift = Parent_Size(3)-sum(old_pos([1,3]));
      case 'west'   %Left center edge of screen
        xshift = -old_pos(1);
      case 'northeast'  %Top right corner of screen
        xshift = Parent_Size(3)-sum(old_pos([1,3]));
        yshift = Parent_Size(4)-sum(old_pos([2,4]));
      case 'northwest'  %Top left corner of screen
        xshift = -old_pos(1);
        yshift = Parent_Size(4)-sum(old_pos([2,4]));
      case 'southeast'  %Bottom right corner of screen
        xshift = Parent_Size(3)-sum(old_pos([1,3]));
        yshift = -old_pos(2);
      case 'southwest'  %Bottom left corner
        xshift = -old_pos(1);
        yshift = -old_pos(2);
      case 'center' %Centered on screen
        xshift = (Parent_Size(3)-old_pos(3))/2-old_pos(1);
        yshift = (Parent_Size(4)-old_pos(4))/2-old_pos(2);
      case 'onscreen'
        %Nearest location to current location that is entirely on screen 
        if old_pos(1)<0 
          xshift = -old_pos(1);
        end
        if old_pos(2)<0 
          yshift = -old_pos(2);
        end
        if sum(old_pos([1,3]))>Parent_Size(3) 
          xshift = Parent_Size(3)-sum(old_pos([1,3]));
        end
        if sum(old_pos([2,4]))>Parent_Size(4) 
          yshift = Parent_Size(4)-sum(old_pos([2,4]));
        end
      otherwise 
        error('movegui called with unknown parameter');
    end
  elseif isnumeric(position)
    if position(1)>=0
      xshift = position(1)-old_pos(1);
    else 
      xshift = Parent_Size(3)+position(1)-sum(old_pos([1,3]));
    end
    if position(2)>=0
      yshift = position(2)-old_pos(2);
    else 
      yshift = Parent_Size(4)+position(2)-sum(old_pos([2,4]));
    end
  end
  
  new_pos = old_pos + [xshift, yshift, 0, 0];

  if hParent==0  
    set(hFig, 'Position', new_pos);
  else
    set(hFig, 'OuterPosition', new_pos);
  end 
  
  %Perform Clean Up
  CleanUp(); 
end

