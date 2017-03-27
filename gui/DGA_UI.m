function varargout = DGA_UI(varargin)
% DGA_UI MATLAB code for DGA_UI.fig
%      DGA_UI, by itself, creates a new DGA_UI or raises the existing
%      singleton*.
%
%      H = DGA_UI returns the handle to a new DGA_UI or the handle to
%      the existing singleton*.
%
%      DGA_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DGA_UI.M with the given input arguments.
%
%      DGA_UI('Property','Value',...) creates a new DGA_UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DGA_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DGA_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DGA_UI

% Last Modified by GUIDE v2.5 27-Mar-2017 09:19:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DGA_UI_OpeningFcn, ...
                   'gui_OutputFcn',  @DGA_UI_OutputFcn, ...
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


% --- Executes just before DGA_UI is made visible.
function DGA_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DGA_UI (see VARARGIN)

% Choose default command line output for DGA_UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DGA_UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Read config file and fill in the methods list
[methods,datasets] = Read_Config();
set(handles.MethodList, 'String', methods(:,2));
set(handles.MethodList, 'Max', length(methods));
%set(handles.DatasetList, 'String', dataset(:,2));
%set(handles.DatasetList, 'Max', length(dataset));

% --- Outputs from this function are returned to the command line.
function varargout = DGA_UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in MethodList.
function MethodList_Callback(hObject, eventdata, handles)
% hObject    handle to MethodList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MethodList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MethodList


% --- Executes during object creation, after setting all properties.
function MethodList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MethodList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio1_Callback(hObject, eventdata, handles)
% hObject    handle to ratio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio1 as text
%        str2double(get(hObject,'String')) returns contents of ratio1 as a double


% --- Executes during object creation, after setting all properties.
function ratio1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio2_Callback(hObject, eventdata, handles)
% hObject    handle to ratio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio2 as text
%        str2double(get(hObject,'String')) returns contents of ratio2 as a double


% --- Executes during object creation, after setting all properties.
function ratio2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio3_Callback(hObject, eventdata, handles)
% hObject    handle to ratio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio3 as text
%        str2double(get(hObject,'String')) returns contents of ratio3 as a double


% --- Executes during object creation, after setting all properties.
function ratio3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio4_Callback(hObject, eventdata, handles)
% hObject    handle to ratio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio4 as text
%        str2double(get(hObject,'String')) returns contents of ratio4 as a double


% --- Executes during object creation, after setting all properties.
function ratio4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio5_Callback(hObject, eventdata, handles)
% hObject    handle to ratio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio5 as text
%        str2double(get(hObject,'String')) returns contents of ratio5 as a double


% --- Executes during object creation, after setting all properties.
function ratio5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio6_Callback(hObject, eventdata, handles)
% hObject    handle to ratio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio6 as text
%        str2double(get(hObject,'String')) returns contents of ratio6 as a double


% --- Executes during object creation, after setting all properties.
function ratio6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio7_Callback(hObject, eventdata, handles)
% hObject    handle to ratio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio7 as text
%        str2double(get(hObject,'String')) returns contents of ratio7 as a double


% --- Executes during object creation, after setting all properties.
function ratio7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio8_Callback(hObject, eventdata, handles)
% hObject    handle to ratio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio8 as text
%        str2double(get(hObject,'String')) returns contents of ratio8 as a double


% --- Executes during object creation, after setting all properties.
function ratio8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio9_Callback(hObject, eventdata, handles)
% hObject    handle to ratio9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio9 as text
%        str2double(get(hObject,'String')) returns contents of ratio9 as a double


% --- Executes during object creation, after setting all properties.
function ratio9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SinglePointButton.
function SinglePointButton_Callback(hObject, eventdata, handles)
% hObject    handle to SinglePointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SinglePointButton
choice=get(hObject,'Value');
if choice==1
    set(handles.MultiplePointsPanel, 'visible', 'off')
    set(handles.SinglePointPanel, 'visible', 'on')
else
    set(handles.MultiplePointsPanel, 'visible', 'on')
    set(handles.SinglePointPanel, 'visible', 'off')
end

% --- Executes on button press in InputFileButton.
function InputFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to InputFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname]=uigetfile({'.xlsx'},'Select Input File');
if ~isequal(filename,0) && ~isequal(pathname,0)
    fullname = strcat(pathname, filename);
    set(handles.InputFileText,'String',fullname);
    set(handles.SinglePointButton, 'Value', 2);
    SinglePointButton_Callback(handles.SinglePointButton, eventdata, handles)
end

function InputFileText_Callback(hObject, eventdata, handles)
% hObject    handle to InputFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputFileText as text
%        str2double(get(hObject,'String')) returns contents of InputFileText as a double


% --- Executes during object creation, after setting all properties.
function InputFileText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function OpenInputButton_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to OpenInputButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InputFileButton_Callback(hObject, eventdata, handles)


% --- Executes on button press in SelectAllMethodsButton.
function SelectAllMethodsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllMethodsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
methods = get(handles.MethodList, 'String');
set(handles.MethodList, 'Value', 1:length(methods));


% --- Executes on button press in GoButton.
function GoButton_Callback(hObject, eventdata, handles)
% hObject    handle to GoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%methods = get(handles.MethodList, 'String');
%selectedMethods = methods(get(handles.MethodList, 'Value'));

global DGA_histogram 

[methods,datasets] = Read_Config();
selectedMethods = methods(get(handles.MethodList, 'Value'),3);

Input = {'H2';'CH4';'C2H6'; 'C2H4';'C2H2';'CO';'CO2';'N2';'O2'};

% Single Point
if isequal(get(handles.SinglePointButton, 'Value'),1)    

    set(handles.RawDataView, 'Value', 1);
    set(handles.AccuracyTabularView, 'Enable','off');
    set(handles.AccuracyGraphicalView, 'Enable','off');
    set(handles.selectedMethod, 'Enable','off');
    set(handles.selectedMethod, 'String', '');

    ratios = NaN* ones(1,9);
    for ratio_i=1:9
        ratio = strcat('get(handles.ratio', num2str(ratio_i),', ''String'')');
        r = str2double(eval(ratio));
        if r>=0.0
            ratios(ratio_i) = r;
        end
    end

    results=DGAs_n(selectedMethods , ratios);
    symbolicResults=arrayfun(@(x) DGA_Diagnosis(x),results,'UniformOutput',false);

    set(handles.DiagnosisTable, 'RowName', [Input; methods(get(handles.MethodList, 'Value'),2)]);
    set(handles.DiagnosisTable, 'Data', [num2cell(ratios) symbolicResults]');
   
%Muliple Points
else
    set(handles.RawDataView, 'Value', 1);
        
    full=get(handles.InputFileText,'String');

    [data, header] =xlsread(full);

    ratios = NaN * ones([size(data,1) length(Input)]);
    for gas_i=1:length(Input)
        col = find(strcmpi(strtrim(header),Input{gas_i})); 
        if(~isempty(col))
            ratios(:,gas_i)= data(:,col);
        end        
    end
    
    results=DGAs_n(selectedMethods , ratios);
    
    ACTcol = find(strcmpi(strtrim(header),'ACT')); 
    if(~isempty(ACTcol))
        actual = data(:,ACTcol);
        set(handles.AccuracyTabularView, 'Enable','on');
        set(handles.AccuracyGraphicalView, 'Enable','on');
        set(handles.selectedMethod, 'Enable','on');
    else
        actual = 7*ones([size(data,1) 1]);
        set(handles.AccuracyTabularView, 'Enable','off');
        set(handles.AccuracyGraphicalView, 'Enable','off');
        set(handles.selectedMethod, 'Enable','off');
    end

    symbolicResults=arrayfun(@(x) DGA_Diagnosis(x),results,'UniformOutput',false);

    symbolicActual = arrayfun(@(x) DGA_Diagnosis(x),actual,'UniformOutput',false);
    
    selectedMethods = methods(get(handles.MethodList, 'Value'),2);
    set(handles.DiagnosisTable, 'RowName', [Input; 'ACT'; selectedMethods]);
    set(handles.DiagnosisTable, 'Data', [num2cell(ratios) symbolicActual symbolicResults]');

    DGA_histogram = AnalyzeResults(results, actual);
    
    %set(handles.AccuracyTable, 'Data', DGA_histogram);

    %Display and Analysis
        
%     u=histogram(1:7,10);
%     bar(handles.AccuracyGraph,u);
%     xlabel(handles.AccuracyGraph,'FAULT TYPE');
%     ylabel(handles.AccuracyGraph,'%');
%     grid on;
%     set(handles.AccuracyGraph,'XTickLabel',{'PD','D1','D2','T1','T2','T3','TOT'});
%     ylim(handles.AccuracyGraph,[0 100]);
    
        

    all = reshape(DGA_histogram(:,10),7,length(selectedMethods));

    bar(all);

    xlabel(handles.AccuracyGraph,'FAULT TYPE');
    ylabel(handles.AccuracyGraph,'%Percentage');
    grid on;
    set(handles.AccuracyGraph,'XTickLabel',{'PD','D1','D2','T1','T2','T3','Agree'});
    ylim(handles.AccuracyGraph, [0 100]);
    legend(handles.AccuracyGraph, methods(get(handles.MethodList, 'Value'),2),'Location','northoutside','Orientation','horizontal');

    set(handles.selectedMethod, 'String', selectedMethods);
    set(handles.selectedMethod, 'Value', 1);
    selectedMethod_Callback(handles.selectedMethod, eventdata, handles)
   
end

% --- Executes when selected object is changed in uipanel9.
function uipanel9_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel9 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.RawDataView, 'Value')
        Visible='on';
    else
        Visible='off';
    end
    
    set(handles.DiagnosisTable, 'Visible', Visible);
    
    
    if get(handles.AccuracyTabularView, 'Value')
        Visible='on';
    else
        Visible='off';
    end
    set(handles.AccuracyTable, 'Visible', Visible);

    if get(handles.AccuracyGraphicalView, 'Value')
        Visible='on';
    else
        Visible='off';
    end
    set(handles.AccuracyGraph, 'Visible', Visible);


% --- Executes on selection change in selectedMethod.
function selectedMethod_Callback(hObject, eventdata, handles)
% hObject    handle to selectedMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectedMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectedMethod

    global DGA_histogram;
    s = get(handles.selectedMethod, 'Value');
    set(handles.AccuracyTable, 'Data', DGA_histogram(7*(s-1)+1:7*s,:));

% --- Executes during object creation, after setting all properties.
function selectedMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AccuracyTabularView.
function AccuracyTabularView_Callback(hObject, eventdata, handles)
% hObject    handle to AccuracyTabularView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AccuracyTabularView
