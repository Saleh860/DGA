function varargout = Cfg_Methods(varargin)
% CFG_METHODS MATLAB code for Cfg_Methods.fig
%      CFG_METHODS, by itself, creates a new CFG_METHODS or raises the existing
%      singleton*.
%
%      H = CFG_METHODS returns the handle to a new CFG_METHODS or the handle to
%      the existing singleton*.
%
%      CFG_METHODS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CFG_METHODS.M with the given input arguments.
%
%      CFG_METHODS('Property','Value',...) creates a new CFG_METHODS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cfg_Methods_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cfg_Methods_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cfg_Methods

% Last Modified by GUIDE v2.5 21-Oct-2017 00:02:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cfg_Methods_OpeningFcn, ...
                   'gui_OutputFcn',  @Cfg_Methods_OutputFcn, ...
                   'gui_LayoutFcn',  @Cfg_Methods_LayoutFcn, ...
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

end

% --- Executes just before Cfg_Methods is made visible.
function Cfg_Methods_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cfg_Methods (see VARARGIN)

% Choose default command line output for Cfg_Methods
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


LoadButtonImage(handles.pbRemoveMethod, './res/delete-button.jpg', 20, 20);
LoadButtonImage(handles.pbAddMethod, './res/add-button.jpg', 20, 20);

% UIWAIT makes Cfg_Methods wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%Read config file and fill in the methods list
global DGA_Methods;
global DGA_MethodSelectedIndex;
global DGA_Methods_Modified

[n,t,DGA_Methods] = xlsread('Config.xlsx', 'Methods');
DGA_Methods=DGA_Methods(2:size(DGA_Methods,1),:);
DGA_Methods_Modified = false;

set(handles.lbMethods, 'String', DGA_Methods(:,2));
set(handles.lbMethods, 'Max', size(DGA_Methods,1));
DGA_MethodSelectedIndex=0;
LoadMethodDetails(handles);


end

% --- Outputs from this function are returned to the command line.
function varargout = Cfg_Methods_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on selection change in lbMethods.
function lbMethods_Callback(hObject, eventdata, handles)
    SaveMethodDetails(handles);
    if length(get(handles.lbMethods, 'Value'))==1
        LoadMethodDetails(handles);
    else
        ClearMethodDetails(handles);
    end
end

function ClearMethodDetails(handles)
    global DGA_MethodSelectedIndex
    DGA_MethodSelectedIndex=0; 
    set(handles.tbMethodName, 'String', '');
    set(handles.tbFileName, 'String', '');
    set(handles.tbReference,'String', '');     
end

function LoadMethodDetails(handles)
    global DGA_Methods;
    global DGA_MethodSelectedIndex
    DGA_MethodSelectedIndex=get(handles.lbMethods,'Value');    
    set(handles.tbMethodName, 'String', DGA_Methods(DGA_MethodSelectedIndex, 2));
    set(handles.tbFileName, 'String', DGA_Methods(DGA_MethodSelectedIndex, 3));
    set(handles.tbReference,'String', DGA_Methods(DGA_MethodSelectedIndex, 4));     
end

function SaveMethodDetails(handles)
    global DGA_Methods;
    global DGA_MethodSelectedIndex
    global DGA_Methods_Modified
    
    modified = false;
    if DGA_MethodSelectedIndex>0 && ...
            size(DGA_Methods,1)>=DGA_MethodSelectedIndex
        
        if ~strcmp(DGA_Methods(DGA_MethodSelectedIndex, 2), ...
                get(handles.tbMethodName, 'String'))
            DGA_Methods(DGA_MethodSelectedIndex, 2)= ...
                get(handles.tbMethodName, 'String');
            modified=true;
        end
        
        
        if ~strcmp(DGA_Methods(DGA_MethodSelectedIndex, 3), ...
                get(handles.tbFileName, 'String'))
            DGA_Methods(DGA_MethodSelectedIndex, 3)= ...
                get(handles.tbFileName, 'String');
            modified = true;
        end
        
        
        if ~strcmp(DGA_Methods(DGA_MethodSelectedIndex, 4), ...
                {strjoin(get(handles.tbReference,'String')','\n')})
            DGA_Methods(DGA_MethodSelectedIndex, 4)= ...
                {strjoin(get(handles.tbReference,'String')','\n')};
            modified = true;
        end
        
        if modified 
            set(handles.lbMethods, 'String', DGA_Methods(:,2));
            set(handles.lbMethods, 'UserData', true);
            DGA_Methods_Modified = true;
        end
    end
end

% --- Executes during object creation, after setting all properties.
function lbMethods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbMethods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    SetDefaultBackgroundColor(hObject);
    set(hObject,'Max',0,'Min',0);

end
% --- Executes on button press in pbAddMethod.
function pbAddMethod_Callback(hObject, eventdata, handles)
% hObject    handle to pbAddMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global DGA_Methods;
    global DGA_MethodSelectedIndex;
    global DGA_Methods_Modified
    
    SaveMethodDetails(handles);
    
    if size(DGA_Methods,1)>0
        lastID=cell2mat(DGA_Methods(size(DGA_Methods,1),1));
        newID=lastID+1;
    else
        newID=1;
    end
    
    DGA_MethodSelectedIndex=size(DGA_Methods,1)+1;
    DGA_Methods(DGA_MethodSelectedIndex,:)= {newID, 'New Method', 'Choose source file', ' '};
    DGA_Methods_Modified = true;
    set(handles.lbMethods, 'String', DGA_Methods(:,2));
    set(handles.lbMethods, 'Value', DGA_MethodSelectedIndex);

    set(handles.lbMethods, 'UserData', true);

    LoadMethodDetails(handles);
    
end


function tbMethodName_Callback(hObject, eventdata, handles)
% hObject    handle to tbMethodName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbMethodName as text
%        str2double(get(hObject,'String')) returns contents of tbMethodName as a double
end

% --- Executes during object creation, after setting all properties.
function tbMethodName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbMethodName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    SetDefaultBackgroundColor(hObject);
end



function tbReference_Callback(hObject, eventdata, handles)
% hObject    handle to tbReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbReference as text
%        str2double(get(hObject,'String')) returns contents of tbReference as a double
end

% --- Executes during object creation, after setting all properties.
function tbReference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    SetDefaultBackgroundColor(hObject);
end

% --- Executes on button press in pbBrowse.
function pbBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to pbBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [filename,pathname]=uigetfile({'*.m;*.exe', 'All supported files';'*.m', 'Matlab Function';'*.exe', 'Stand-alone Executable'},'Select Method Implementation File');
    if ~isequal(filename,0) && ~isequal(pathname,0)
        rel_path = relativepath(pathname);
        if rel_path(end)~='\'
            rel_path = strcat(rel_path, '\');
        end        
        fullname = strcat(rel_path, filename);
        set(handles.tbFileName,'String',{fullname});
    end
end

function tbFileName_Callback(hObject, eventdata, handles)
% hObject    handle to tbFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbFileName as text
%        str2double(get(hObject,'String')) returns contents of tbFileName as a double
end

% --- Executes during object creation, after setting all properties.
function tbFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    SetDefaultBackgroundColor(hObject);
end

% --- Executes on button press in pbRemoveMethod.
function pbRemoveMethod_Callback(hObject, eventdata, handles)
% hObject    handle to pbRemoveMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global DGA_Methods;
    global DGA_MethodSelectedIndex;
    global DGA_Methods_Modified
    
    if size(DGA_Methods,1)>=1
        DGA_MethodSelectedIndex=get(handles.lbMethods, 'Value');
        DGA_Methods(DGA_MethodSelectedIndex,:)= [];
        DGA_Methods_Modified = true;
        
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
end 


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    try

        global DGA_Methods;
        global DGA_MethodSelectedIndex;
        global DGA_Methods_Modified

        drawnow
        SaveMethodDetails(handles);

        if DGA_Methods_Modified
            response= questdlg('Do you want to save changes?');
            drawnow; pause(0.05);  % this innocent line prevents the Matlab hang
            if strcmp(response,'Yes')
                xlswrite('Config.xlsx',zeros(1000,10)*NaN, 'Methods');
                xlswrite('Config.xlsx',[{'ID','Name','Filename','Reference'};DGA_Methods], 'Methods');
            end
            if ~strcmp(response,'Cancel')
                clear DGA_Methods;
                clear DGA_MethodSelectedIndex;
                clear DGA_Methods_Modified;
                delete(hObject);
            end
        else
            delete(hObject);
        end
    catch error
        display('Sorry! An error occured while closing the Edit_Methods figure. Any changes may have been lost!')
        delete(hObject);
    end

end

% --- Executes on button press in pbClose.
function pbClose_Callback(hObject, eventdata, handles)
% hObject    handle to pbClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(handles.figure1);
end

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
end

% --- Executes on button press in pbEditScript.
function pbEditScript_Callback(hObject, eventdata, handles)
    filename = char(get(handles.tbFileName, 'String'));
    
    if length(strfind(filename, '.m'))>0
        if exist(filename, 'file')==0
            copyfile('./res/DGA_New.m', filename);
        end
        
        edit(filename);
        close(handles.figure1);
    else
        uiwait(msgbox('Can only edit MATLAB .m script files'));
    end
end


% --- Creates and returns a handle to the GUI figure. 
function h1 = Cfg_Methods_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'text', 6, ...
    'listbox', 2, ...
    'pushbutton', 6, ...
    'edit', 4), ...
    'override', 0, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Users\Baba\OneDrive\Research\DGA\DGA\DGA\gui\Cfg_Methods.m', ...
    'lastFilename', 'C:\Users\Baba\OneDrive\Research\DGA\DGA\DGA\gui\Edit_Methods.fig');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'figure1');

h1 = figure(...
'Units','characters',...
'CloseRequestFcn',@(hObject,eventdata)Cfg_Methods('figure1_CloseRequestFcn',hObject,eventdata,guidata(hObject)),...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','Edit_Methods',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[103.8 30.6923076923077 110.8 30.8461538461538],...
'Resize','off',...
'WindowStyle','modal',...
'HandleVisibility','callback',...
'UserData',[],...
'Tag','figure1',...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text1';

h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',14,...
'Position',[28.2 27 53.8 3],...
'String','Configure Methods',...
'Style','text',...
'Tag','text1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lbMethods';

h3 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Methods('lbMethods_Callback',hObject,eventdata,guidata(hObject)),...
'Max',0,...
'Position',[5.2 4.38461538461538 36.6 19.9230769230769],...
'String',{  'Listbox' },...
'Style','listbox',...
'TooltipString','Select a method to edit its details',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Methods('lbMethods_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','lbMethods');

appdata = [];
appdata.lastValidTag = 'text2';

h4 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[5.4 24.9230769230769 19.2 1.15384615384615],...
'String','Methods',...
'Style','text',...
'Tag','text2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbAddMethod';

h5 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Methods('pbAddMethod_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[31.8 24.3846153846154 4.6 1.69230769230769],...
'String',blanks(0),...
'TooltipString','Add dataset',...
'Tag','pbAddMethod',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbMethodName';

h6 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Methods('tbMethodName_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'KeyPressFcn',@(hObject,eventdata)Cfg_Methods('tbMethodName_KeyPressFcn',hObject,eventdata,guidata(hObject)),...
'Position',[45.2 22.2307692307692 36.8 2.15384615384615],...
'String',blanks(0),...
'Style','edit',...
'TooltipString','Method friendly name which will appear in results and analysis',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Methods('tbMethodName_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbMethodName');

appdata = [];
appdata.lastValidTag = 'text3';

h7 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[45 24.6153846153846 16.8 1.46153846153846],...
'String','Method name',...
'Style','text',...
'Tag','text3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbReference';

h8 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Methods('tbReference_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'Max',10,...
'Position',[45.4 4.38461538461539 64.6 10.0769230769231],...
'String','Reference',...
'Style','edit',...
'TooltipString','Information about the method',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Methods('tbReference_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbReference');

appdata = [];
appdata.lastValidTag = 'text4';

h9 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[45.4 14.6923076923077 16.8 1.46153846153846],...
'String','Reference',...
'Style','text',...
'Tag','text4',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbBrowse';

h10 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Methods('pbBrowse_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[95.8 18.5384615384615 16 1.69230769230769],...
'String','Browse ...',...
'TooltipString','Select the method implementation using folder browser',...
'Tag','pbBrowse',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbFileName';

h11 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Methods('tbFileName_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'Position',[45.2 18.3846153846154 50 1.84615384615385],...
'String',blanks(0),...
'Style','edit',...
'TooltipString','MATLAB script or standalone executable file implementing the method',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Methods('tbFileName_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbFileName');

appdata = [];
appdata.lastValidTag = 'text5';

h12 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[44.6 20.2307692307692 35.4 1.15384615384615],...
'String','Implementation File Name',...
'Style','text',...
'Tag','text5',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbRemoveMethod';

h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Methods('pbRemoveMethod_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[37.2 24.3846153846154 4.6 1.69230769230769],...
'String',blanks(0),...
'TooltipString','Remove dataset',...
'Tag','pbRemoveMethod',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbClose';

h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Methods('pbClose_Callback',hObject,eventdata,guidata(hObject)),...
'FontSize',12,...
'Position',[43.6 0.923076923076923 22.6 2.84615384615385],...
'String','Close',...
'TooltipString','CLose the method list editor, optionally saving any changes',...
'Tag','pbClose',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbEditScript';

h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Methods('pbEditScript_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[59.8 16 30.2 1.92307692307692],...
'String','Edit MATLAB Script',...
'TooltipString','Open the MATLAB script file for editing. Create a new file if one doesn''t already exist.',...
'Tag','pbEditScript',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


hsingleton = h1;

end
% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end
end

% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error(message('MATLAB:guide:StateFieldNotFound', gui_StateFields{ i }, gui_Mfile));
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % CFG_METHODS
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % CFG_METHODS(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % CFG_METHODS('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % CFG_METHODS(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~ishghandle(fig,'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || (isscalar(fig)&&isprop(fig,'GUIDEFigure'));
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishghandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);

        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI M-file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end
end
function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = matlab.hg.internal.openfigLegacy(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    % Call version of openfig that accepts 'auto' option"
    gui_hFigure = matlab.hg.internal.openfigLegacy(name, singleton, visible);  
    %workaround for CreateFcn not called to create ActiveX
    if feature('HGUsingMATLABClasses')
        peers=findobj(findall(allchild(gui_hFigure)),'type','uicontrol','style','text');    
        for i=1:length(peers)
            if isappdata(peers(i),'Control')
                actxproxy(peers(i));
            end            
        end
    end
end
end
function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end
end
function result = local_isInvokeHGCallback(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishghandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end
end

