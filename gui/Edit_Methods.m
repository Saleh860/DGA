function varargout = Edit_Methods(varargin)
% EDIT_METHODS MATLAB code for Edit_Methods.fig
%      EDIT_METHODS, by itself, creates a new EDIT_METHODS or raises the existing
%      singleton*.
%
%      H = EDIT_METHODS returns the handle to a new EDIT_METHODS or the handle to
%      the existing singleton*.
%
%      EDIT_METHODS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_METHODS.M with the given input arguments.
%
%      EDIT_METHODS('Property','Value',...) creates a new EDIT_METHODS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Edit_Methods_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Edit_Methods_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Edit_Methods

% Last Modified by GUIDE v2.5 05-Oct-2017 02:24:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Edit_Methods_OpeningFcn, ...
                   'gui_OutputFcn',  @Edit_Methods_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Edit_Methods is made visible.
function Edit_Methods_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Edit_Methods (see VARARGIN)

% Choose default command line output for Edit_Methods
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Edit_Methods wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%Read config file and fill in the methods list
global DGA_Methods;
global DGA_MethodsSelectedIndex;
[n,t,DGA_Methods] = xlsread('Config.xlsx', 'Methods');
DGA_Methods=DGA_Methods(2:size(DGA_Methods,1),:);
set(handles.lbMethods, 'String', DGA_Methods(:,2));
set(handles.lbMethods, 'Max', size(DGA_Methods,1));
DGA_MethodSelectedIndex=0;
LoadMethodDetails(handles);


% --- Outputs from this function are returned to the command line.
function varargout = Edit_Methods_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lbMethods.
function lbMethods_Callback(hObject, eventdata, handles)
% hObject    handle to lbMethods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbMethods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbMethods
SaveMethodDetails(handles);
LoadMethodDetails(handles);

function LoadMethodDetails(handles)
    global DGA_Methods;
    global DGA_MethodSelectedIndex
    DGA_MethodSelectedIndex=get(handles.lbMethods,'Value');    
    set(handles.tbMethodName, 'String', DGA_Methods(DGA_MethodSelectedIndex, 2));
    set(handles.tbFileName, 'String', DGA_Methods(DGA_MethodSelectedIndex, 3));
    set(handles.tbReference,'String', DGA_Methods(DGA_MethodSelectedIndex, 4));     


function SaveMethodDetails(handles)
    global DGA_Methods;
    global DGA_MethodSelectedIndex
    if DGA_MethodSelectedIndex>0 && size(DGA_Methods,1)>=DGA_MethodSelectedIndex
        DGA_Methods(DGA_MethodSelectedIndex, 2)=get(handles.tbMethodName, 'String');
        DGA_Methods(DGA_MethodSelectedIndex, 3)=get(handles.tbFileName, 'String');
        DGA_Methods(DGA_MethodSelectedIndex, 4)={strjoin(get(handles.tbReference,'String')','\n')};
        set(handles.lbMethods, 'String', DGA_Methods(:,2));
    end


% --- Executes during object creation, after setting all properties.
function lbMethods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbMethods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Max',0,'Min',0);


% --- Executes on button press in pbAddMethod.
function pbAddMethod_Callback(hObject, eventdata, handles)
% hObject    handle to pbAddMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global DGA_Methods;
    global DGA_MethodSelectedIndex;
    
    SaveMethodDetails(handles);
    
    if size(DGA_Methods,1)>0
        lastID=cell2mat(DGA_Methods(size(DGA_Methods,1),1));
        newID=lastID+1;
    else
        newID=1;
    end
    
    DGA_MethodSelectedIndex=size(DGA_Methods,1)+1;
    DGA_Methods(DGA_MethodSelectedIndex,:)= {newID, 'New Method', 'Choose source file', ' '};
    set(handles.lbMethods, 'String', DGA_Methods(:,2));
    set(handles.lbMethods, 'Value', DGA_MethodSelectedIndex);
    LoadMethodDetails(handles);
    



function tbMethodName_Callback(hObject, eventdata, handles)
% hObject    handle to tbMethodName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbMethodName as text
%        str2double(get(hObject,'String')) returns contents of tbMethodName as a double


% --- Executes during object creation, after setting all properties.
function tbMethodName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbMethodName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tbReference_Callback(hObject, eventdata, handles)
% hObject    handle to tbReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbReference as text
%        str2double(get(hObject,'String')) returns contents of tbReference as a double


% --- Executes during object creation, after setting all properties.
function tbReference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbBrowse.
function pbBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to pbBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname]=uigetfile({'*.m;*.exe', 'All supported files';'*.m', 'Matlab Function';'*.exe', 'Stand-alone Executable'},'Select Method Implementation File');
if ~isequal(filename,0) && ~isequal(pathname,0)
    rel_path = relativepath(pathname);
    fullname = strcat(rel_path, filename);
    set(handles.tbFileName,'String',{fullname});
end


function tbFileName_Callback(hObject, eventdata, handles)
% hObject    handle to tbFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbFileName as text
%        str2double(get(hObject,'String')) returns contents of tbFileName as a double


% --- Executes during object creation, after setting all properties.
function tbFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbRemoveMethod.
function pbRemoveMethod_Callback(hObject, eventdata, handles)
% hObject    handle to pbRemoveMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global DGA_Methods;
    global DGA_MethodSelectedIndex;
    
    if size(DGA_Methods,1)>=1
        DGA_MethodSelectedIndex=get(handles.lbMethods, 'Value');
        DGA_Methods(DGA_MethodSelectedIndex,:)= [];

        if size(DGA_Methods,1)==0
            pbAddMethod_Callback(hObject, eventdata, handles)
        else
            if size(DGA_Methods,1)<DGA_MethodSelectedIndex
                DGA_MethodSelectedIndex=size(DGA_Methods,1);
                set(handles.lbMethods, 'Value', DGA_MethodSelectedIndex);
            end
            set(handles.lbMethods, 'String', DGA_Methods(:,2));
            LoadMethodDetails(handles);
        end
    end
 


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    global DGA_Methods;
    global DGA_MethodSelectedIndex;

    drawnow
    SaveMethodDetails(handles);
    
    response= questdlg('Do you want to save changes?');
    if strcmp(response,'Yes')
        xlswrite('Config.xlsx',zeros(1000,10)*NaN, 'Methods');
        xlswrite('Config.xlsx',[{'ID','Name','Filename','Reference'};DGA_Methods], 'Methods');
    end
    if ~strcmp(response,'Cancel')
        clear DGA_Methods;
        clear DGA_MethodSelectedIndex;
        delete(hObject);
    end


% --- Executes on button press in pbClose.
function pbClose_Callback(hObject, eventdata, handles)
% hObject    handle to pbClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(handles.figure1);


% --- Executes on key press with focus on tbDatasetName and none of its controls.
function tbMethodName_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to tbDatasetName (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    drawnow
    if strcmp(eventdata.Key,'return')
        SaveMethodDetails(handles);
    end


% --- Executes on button press in pbEditScript.
function pbEditScript_Callback(hObject, eventdata, handles)
    filename = char(get(handles.tbFileName, 'String'));
    
    if length(strfind(filename, '.m'))>0
        if exist(filename, 'file')==0
            copyfile('./gui/DGA_New.m', filename);
        end
        
        edit(filename);
        close(handles.figure1);
    else
        msgbox('Can only edit MATLAB .m script files');
    end