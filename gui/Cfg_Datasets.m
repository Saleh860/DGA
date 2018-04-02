function varargout = Cfg_Datasets(varargin)
% CFG_DATASETS MATLAB code for Cfg_Datasets.fig
%      CFG_DATASETS, by itself, creates a new CFG_DATASETS or raises the existing
%      singleton*.
%
%      H = CFG_DATASETS returns the handle to a new CFG_DATASETS or the handle to
%      the existing singleton*.
%
%      CFG_DATASETS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CFG_DATASETS.M with the given input arguments.
%
%      CFG_DATASETS('Property','Value',...) creates a new CFG_DATASETS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cfg_Datasets_OpeningFcn gets called.  An
%      unrecognized property tbdatasetname or invalid value makes property application
%      stop.  All inputs are passed to Cfg_Datasets_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cfg_Datasets

% Last Modified by GUIDE v2.5 20-Oct-2017 10:44:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cfg_Datasets_OpeningFcn, ...
                   'gui_OutputFcn',  @Cfg_Datasets_OutputFcn, ...
                   'gui_LayoutFcn',  @Cfg_Datasets_LayoutFcn, ...
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


% --- Executes just before Cfg_Datasets is made visible.
function Cfg_Datasets_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cfg_Datasets (see VARARGIN)

% Choose default command line output for Cfg_Datasets
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

LoadButtonImage(handles.pbRemoveDataset, './res/delete-button.jpg', 20, 20);
LoadButtonImage(handles.pbAddDataset, './res/add-button.jpg', 20, 20);

% UIWAIT makes Cfg_Datasets wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Read config file and fill in the methods list
global DGA_Datasets;
global DGA_DatasetSelectedIndex;
global DGA_Datasets_Modified 

[n,t,DGA_Datasets] = xlsread('Config.xlsx', 'Datasets');
DGA_Datasets=DGA_Datasets(2:size(DGA_Datasets,1),:);
DGA_Datasets_Modified= false;

set(handles.lbDatasets, 'String', DGA_Datasets(:,2));
set(handles.lbDatasets, 'Max', size(DGA_Datasets,1));

DGA_DatasetSelectedIndex=0;
LoadDatasetDetails(handles);




% --- Outputs from this function are returned to the command line.
function varargout = Cfg_Datasets_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lbDatasets.
function lbDatasets_Callback(hObject, eventdata, handles)
% hObject    handle to lbDatasets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbDatasets contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbDatasets
SaveDatasetDetails(handles);

if length(get(handles.lbDatasets, 'Value'))<=1
    LoadDatasetDetails(handles);
else
    ClearDatasetDetails(handles);
end



function ClearDatasetDetails(handles)
    global DGA_DatasetSelectedIndex
    DGA_DatasetSelectedIndex=0;
    set(handles.tbDatasetName, 'String', '');
    set(handles.tbFileName, 'String', '');
    set(handles.tbReference,'String', '');     


function LoadDatasetDetails(handles)
    global DGA_Datasets;
    global DGA_DatasetSelectedIndex
    DGA_DatasetSelectedIndex=get(handles.lbDatasets,'Value');
    set(handles.tbDatasetName, 'String', DGA_Datasets(DGA_DatasetSelectedIndex, 2));
    set(handles.tbFileName, 'String', DGA_Datasets(DGA_DatasetSelectedIndex, 3));
    set(handles.tbReference,'String', DGA_Datasets(DGA_DatasetSelectedIndex, 4));     

    
function SaveDatasetDetails(handles)
    global DGA_Datasets;
    global DGA_DatasetSelectedIndex
    global DGA_Datasets_Modified;
    
    modified = false;
    if DGA_DatasetSelectedIndex>0 && ...
            size(DGA_Datasets,1)>=DGA_DatasetSelectedIndex
        if ~strcmp(DGA_Datasets(DGA_DatasetSelectedIndex, 2), ...
                get(handles.tbDatasetName, 'String'))
            DGA_Datasets(DGA_DatasetSelectedIndex, 2)= ...
                get(handles.tbDatasetName, 'String');
            modified=true;
        end
        
        
        if ~strcmp(DGA_Datasets(DGA_DatasetSelectedIndex, 3), ...
                get(handles.tbFileName, 'String'))
            DGA_Datasets(DGA_DatasetSelectedIndex, 3)= ...
                get(handles.tbFileName, 'String');
            modified = true;
        end
        
        
        if ~strcmp(DGA_Datasets(DGA_DatasetSelectedIndex, 4), ...
                {strjoin(get(handles.tbReference,'String')','\n')})
            DGA_Datasets(DGA_DatasetSelectedIndex, 4)= ...
                {strjoin(get(handles.tbReference,'String')','\n')};
            modified = true;
        end
        
        if modified 
            set(handles.lbDatasets, 'String', DGA_Datasets(:,2));
            DGA_Datasets_Modified= true;
        end
    end


% --- Executes during object creation, after setting all properties.
function lbDatasets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbDatasets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbAddDataset.
function pbAddDataset_Callback(hObject, eventdata, handles)
% hObject    handle to pbAddDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global DGA_Datasets;
    global DGA_DatasetSelectedIndex;
    global DGA_Datasets_Modified;
    
    SaveDatasetDetails(handles);
    
    if size(DGA_Datasets,1)>0
        lastID=cell2mat(DGA_Datasets(size(DGA_Datasets,1),1));
        newID=lastID+1;
    else
        newID=1;
    end
    
    DGA_DatasetSelectedIndex=size(DGA_Datasets,1)+1;
    DGA_Datasets(DGA_DatasetSelectedIndex,:)= {newID, 'New Dataset', 'Choose source file', ' '};
    DGA_Datasets_Modified = true;
    
    set(handles.lbDatasets, 'String', DGA_Datasets(:,2));
    set(handles.lbDatasets, 'Value', DGA_DatasetSelectedIndex);
    
    LoadDatasetDetails(handles);
    

% --- Executes during object creation, after setting all properties.
function tbDatasetName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbDatasetName (see GCBO)
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

[filename,pathname]=uigetfile({'.xlsx'},'Select Input File (*.xlsx)');
if ~isequal(filename,0) && ~isequal(pathname,0)
    rel_path = relativepath(pathname);
    if rel_path(end)~='\'
        rel_path = strcat(rel_path, '\');
    end
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


% --- Executes on button press in pbRemoveDataset.
function pbRemoveDataset_Callback(hObject, eventdata, handles)
% hObject    handle to pbRemoveDataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global DGA_Datasets;
    global DGA_DatasetSelectedIndex;
    global DGA_Datasets_Modified;
    
    if size(DGA_Datasets,1)>=1
        DGA_DatasetSelectedIndex=get(handles.lbDatasets, 'Value');
        DGA_Datasets(DGA_DatasetSelectedIndex,:)= [];
        DGA_Datasets_Modified= true;

        if size(DGA_Datasets,1)==0
            pbAddDataset_Callback(hObject, eventdata, handles)
        else
            if size(DGA_Datasets,1)<DGA_DatasetSelectedIndex
                DGA_DatasetSelectedIndex=size(DGA_Datasets,1);
                set(handles.lbDatasets, 'Value', DGA_DatasetSelectedIndex);
            end
            set(handles.lbDatasets, 'String', DGA_Datasets(:,2));
            LoadDatasetDetails(handles);
        end
    end
 

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try
        global DGA_Datasets;
        global DGA_DatasetSelectedIndex;
        global DGA_Datasets_Modified;

        drawnow
        SaveDatasetDetails(handles);

        if DGA_Datasets_Modified
            response= questdlg('Do you want to save changes?');
            if strcmp(response,'Yes')
                xlswrite('Config.xlsx',zeros(1000,10)*NaN, 'Datasets');
                xlswrite('Config.xlsx',[{'ID','Name','Filename','Reference'};DGA_Datasets], 'Datasets');
            end
            if ~strcmp(response,'Cancel')
                clear DGA_Datasets;
                clear DGA_DatasetSelectedIndex;
                clear DGA_Datasets_Modified;

                delete(hObject);
            end
        else
            delete(hObject);
        end
    catch error
        display('Sorry! An error occured while closing the Edit_Datasets figure. Any changes may have been lost!')
        delete(hObject);
    end

% --- Executes on button press in pbClose.
function pbClose_Callback(hObject, eventdata, handles)
% hObject    handle to pbClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(handles.figure1);


% --- Executes on key press with focus on tbDatasetName and none of its controls.
function tbDatasetName_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to tbDatasetName (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    drawnow
    if strcmp(eventdata.Key,'return')
        SaveDatasetDetails(handles);
    end


% --- Creates and returns a handle to the GUI figure. 
function h1 = Cfg_Datasets_LayoutFcn(policy)
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
    'uipanel', 2, ...
    'listbox', 2, ...
    'pushbutton', 5, ...
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
    'lastSavedFile', 'C:\Users\Baba\OneDrive\Research\DGA\DGA\DGA\gui\Cfg_Datasets.m', ...
    'lastFilename', 'C:\Users\Baba\OneDrive\Research\DGA\DGA\DGA\gui\Edit_Datasets.fig');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'figure1');

h1 = figure(...
'Units','characters',...
'CloseRequestFcn',@(hObject,eventdata)Cfg_Datasets('figure1_CloseRequestFcn',hObject,eventdata,guidata(hObject)),...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','Edit_Datasets',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[103.8 31 110.4 30.4615384615385],...
'Resize','off',...
'WindowStyle','modal',...
'DeleteFcn',@(hObject,eventdata)Cfg_Datasets('figure1_DeleteFcn',hObject,eventdata,guidata(hObject)),...
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
'Position',[26.2 27.4615384615385 53.8 3],...
'String','Configure Datasets',...
'Style','text',...
'Tag','text1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lbDatasets';

h3 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Datasets('lbDatasets_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[3.2 4.84615384615385 36.6 19.9230769230769],...
'String',{  'Listbox' },...
'Style','listbox',...
'TooltipString','Select dataset to edit its details',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Datasets('lbDatasets_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','lbDatasets');

appdata = [];
appdata.lastValidTag = 'text2';

h4 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize', 12,...
'HorizontalAlignment','left',...
'Position',[3.4 25.3846153846154 19.2 1.6],...
'String','Datasets',...
'Style','text',...
'Tag','text2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbAddDataset';

h5 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Datasets('pbAddDataset_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[29.8 24.8461538461538 4.6 1.69230769230769],...
'String',blanks(0),...
'TooltipString','Add dataset',...
'Tag','pbAddDataset',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbDatasetName';

h6 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'HorizontalAlignment','left',...
'KeyPressFcn',@(hObject,eventdata)Cfg_Datasets('tbDatasetName_KeyPressFcn',hObject,eventdata,guidata(hObject)),...
'Position',[43.2 22.6923076923077 36.8 2.15384615384615],...
'String',blanks(0),...
'Style','edit',...
'TooltipString','User friendly name',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Datasets('tbDatasetName_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbDatasetName');

appdata = [];
appdata.lastValidTag = 'text3';

h7 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[43 25.0769230769231 22.8 1.6],...
'String','Dataset name',...
'Style','text',...
'Tag','text3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbReference';

h8 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Datasets('tbReference_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'KeyPressFcn',@(hObject,eventdata)Cfg_Datasets('tbDatasetName_KeyPressFcn',hObject,eventdata,guidata(hObject)),...
'Max',10,...
'Position',[43.4 4.84615384615385 64.6 11.5384615384615],...
'String','Reference',...
'Style','edit',...
'TooltipString','Information about the source of the dataset and its purpose',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Datasets('tbReference_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbReference');

appdata = [];
appdata.lastValidTag = 'text4';

h9 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[43 16.4615384615385 16.8 1.46153846153846],...
'String','Reference',...
'Style','text',...
'Tag','text4',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbBrowse';

h10 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Datasets('pbBrowse_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[93.8 19 16 1.69230769230769],...
'String','Browse ...',...
'TooltipString','Select file form folder browser',...
'Tag','pbBrowse',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'tbFileName';

h11 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)Cfg_Datasets('tbFileName_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'KeyPressFcn',@(hObject,eventdata)Cfg_Datasets('tbDatasetName_KeyPressFcn',hObject,eventdata,guidata(hObject)),...
'Position',[43.2 18.8461538461538 50 1.84615384615385],...
'String',blanks(0),...
'Style','edit',...
'TooltipString','File path and file name',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)Cfg_Datasets('tbFileName_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','tbFileName');

appdata = [];
appdata.lastValidTag = 'text5';

h12 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[42.6 20.6923076923077 30.2 1.6],...
'String','File Name',...
'Style','text',...
'Tag','text5',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbRemoveDataset';

h13 = uicontrol(...
'Parent',h1,...
'FontSize', 12,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Datasets('pbRemoveDataset_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[35.2 24.8461538461538 4.6 1.69230769230769],...
'String',blanks(0),...
'TooltipString','Remove dataset',...
'Tag','pbRemoveDataset',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pbClose';

h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)Cfg_Datasets('pbClose_Callback',hObject,eventdata,guidata(hObject)),...
'FontSize',12,...
'Position',[41.8 0.615384615384615 22.6 2.84615384615385],...
'String','Close',...
'TooltipString','Close dataset list editor optionally saving any changes',...
'Tag','pbClose',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


hsingleton = h1;


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
    % CFG_DATASETS
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % CFG_DATASETS(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % CFG_DATASETS('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % CFG_DATASETS(...)
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
        %guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
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

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
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


