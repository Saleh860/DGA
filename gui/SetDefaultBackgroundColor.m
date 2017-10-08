% --- On Windows, replace default background color with white
function SetDefaultBackgroundColor(hObject)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end    
