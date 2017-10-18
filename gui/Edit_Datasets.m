function varargout = Edit_Datasets(varargin)
% EDIT_DATASETS MATLAB code for Edit_Datasets.fig
%      EDIT_DATASETS, by itself, creates a new EDIT_DATASETS or raises the existing
%      singleton*.
%
%      H = EDIT_DATASETS returns the handle to a new EDIT_DATASETS or the handle to
%      the existing singleton*.
%
%      EDIT_DATASETS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_DATASETS.M with the given input arguments.
%
%      EDIT_DATASETS('Property','Value',...) creates a new EDIT_DATASETS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Edit_Datasets_OpeningFcn gets called.  An
%      unrecognized property tbdatasetname or invalid value makes property application
%      stop.  All inputs are passed to Edit_Datasets_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Edit_Datasets

% Last Modified by GUIDE v2.5 03-Oct-2017 05:45:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Edit_Datasets_OpeningFcn, ...
                   'gui_OutputFcn',  @Edit_Datasets_OutputFcn, ...
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


% --- Executes just before Edit_Datasets is made visible.
function Edit_Datasets_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Edit_Datasets (see VARARGIN)

% Choose default command line output for Edit_Datasets
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

LoadButtonImage(handles.pbRemoveDataset, './res/delete-button.jpg', 20, 20);
LoadButtonImage(handles.pbAddDataset, './res/add-button.jpg', 20, 20);

% UIWAIT makes Edit_Datasets wait for user response (see UIRESUME)
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
function varargout = Edit_Datasets_OutputFcn(hObject, eventdata, handles) 
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
