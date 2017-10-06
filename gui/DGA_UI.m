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

    % Last Modified by GUIDE v2.5 06-Oct-2017 01:22:00

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
end

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

    set(handles.DiagnosisTable, 'Visible', 'off');
    set(handles.AccuracyTable, 'Visible', 'off');
    set(handles.AccuracyGraph, 'Visible', 'off');

    %Read config file and fill in the methods list
    LoadDatasetList(handles);
    LoadMethodList(handles);
end

function LoadMethodList(handles)
    [methods,datasets] = Read_Config();
    set(handles.MethodList, 'String', methods(:,2));
    set(handles.MethodList, 'Max', length(methods));
    set(handles.MethodList, 'Value', []);
end


function LoadDatasetList(handles)
    [methods,datasets] = Read_Config();
    set(handles.lbDatasets, 'String', datasets(:,2));
    set(handles.lbDatasets, 'Max', length(datasets)); 
    set(handles.lbDatasets, 'Value', []);
end

% --- Outputs from this function are returned to the command line.
function varargout = DGA_UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes during object creation, after setting all properties.
function MethodList_CreateFcn(hObject, eventdata, handles)
    SetDefaultBackgroundColor(hObject);
end

function ratio1_Callback(hObject, eventdata, handles)
% hObject    handle to ratio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of ratio1 as text
    %        str2double(get(hObject,'String')) returns contents of ratio1 as a double
end

% --- Executes during object creation, after setting all properties.
function ratio1_CreateFcn(hObject, eventdata, handles)
    SetDefaultBackgroundColor(hObject);
end

% --- Select All Methods
function SelectAllMethodsButton_Callback(hObject, eventdata, handles)
    methods = get(handles.MethodList, 'String');
    set(handles.MethodList, 'Value', 1:length(methods));
end

function SetDiagnosisTableHeader(handles, Header)
    set(handles.DiagnosisTable, 'ColumnName', Header);
end

function Header = GetDiagnosisTableHeader(handles)
    Header=get(handles.DiagnosisTable, 'ColumnName');
end

function SetDiagnosisTableData(handles, ratiosx)
    set(handles.DiagnosisTable, 'Data', ratiosx);
end

function data=GetDiagnosisTableData(handles)
    data =get(handles.DiagnosisTable, 'Data');
end

% --- DGA for single point entered using textboxes
function SinglePointDiagnosis(handles)
    
    methods = Read_Config();
    selectedMethods = methods(get(handles.MethodList, 'Value'),3);
    Input = {'H2';'CH4';'C2H6'; 'C2H4';'C2H2';'CO';'CO2';'N2';'O2'};

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
    
    symbolicResults=arrayfun(@(x) DGA_Diagnosis(x), ...
        results,'UniformOutput',false);

    FullColumns = find(~isnan(ratios(1,:)));

    selectedMethods = methods(get(handles.MethodList, 'Value'),2);
    SetDiagnosisTableHeader(handles, [Input(FullColumns)
         selectedMethods]);
     
    SetDiagnosisTableData(handles, ...
        [num2cell(ratios(:,FullColumns)) symbolicResults]);
        
    set(handles.RawDataView, 'Value', 1);
    
    ShowSelectedView(handles);

end

% --- Executes on button press in GoButton.
function GoButton_Callback(hObject, eventdata, handles)
% hObject    handle to GoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%methods = get(handles.MethodList, 'String');
%selectedMethods = methods(get(handles.MethodList, 'Value'));

    if size(get(handles.MethodList, 'Value'),1)==0
        msgbox('You must first choose at least one DGA method', 'modal');
        return
    end
    if size(get(handles.lbDatasets, 'Value'),1)==0
        msgbox('You must first choose at least one dataset', 'modal');
        return
    end

    % Single Point
    if isequal(get(handles.optSinglePoint, 'Value'),1)    
        
        SinglePointDiagnosis(handles);

    %Muliple Points
    else
        
        DatasetDiagnosis(handles);
        
    end
end

%Combine all selected datasets in one dataset
function [ratios, actual]=CombineSelectedDatasets(handles, selectedDatasets)
    ratios=[];
    actual=[];
    %assume actual data exists until it can't be found
    actual_exists=true;
    
    Input = {'H2';'CH4';'C2H6'; 'C2H4';'C2H2';'CO';'CO2';'N2';'O2'};        

    for iDataset=1: size(selectedDatasets,1)

        [data, txt, header] =xlsread(cell2mat(selectedDatasets(iDataset)));
        
        ratios1 =  NaN * ones(size(data,1), length(Input));
        
        for gas_i=1:length(Input)
            col = find(strcmpi(Input{gas_i},strtrim(header(1,:)))); 
            if(~isempty(col))
                ratios1(:,gas_i)= data(:,col);
            end        
        end

        ACTcol = find(strcmpi('ACT',strtrim(header(1,:)))); 

        if(~isempty(ACTcol))
            actual1 = data(:,ACTcol);

        else
            actual_exist=false;
            actual1 = 7*ones([size(data,1) 1]);
        end

        ratios=[ratios;ratios1];
        actual = [actual;actual1]; 
    end
    
    set(handles.RawDataView, 'Value', 1);

    if actual_exists
        set(handles.AccuracyTabularView, 'Enable','on');
        set(handles.AccuracyGraphicalView, 'Enable','on');
        set(handles.selectedMethod, 'Enable','on');
    else
        set(handles.AccuracyTabularView, 'Enable','off');
        set(handles.AccuracyGraphicalView, 'Enable','off');
        set(handles.selectedMethod, 'Enable','off');
    end
end

function UpdateProgressSlider(handle, maximum, current)
    set(handle, 'Slider', [0.01; max(0.01, 100*(current/maximum)^6)]);
    drawnow
end

function DatasetDiagnosis(handles)
    global DGA_histogram
    
    if size(get(handles.MethodList, 'Value'),1)==0
        msgbox('You must first choose at least one dataset.', 'modal');
        return
    end

    [methods,datasets] = Read_Config();
    selectedMethods = methods(get(handles.MethodList, 'Value'),3);
    Input = {'H2';'CH4';'C2H6'; 'C2H4';'C2H2';'CO';'CO2';'N2';'O2'};        
    selectedDatasets = datasets(get(handles.lbDatasets, 'Value'),3);

    [ratios, actual]=CombineSelectedDatasets(handles, selectedDatasets);    

    set(handles.ProgressSlider, 'Visible', 'on');
    
    results=DGAs_n(selectedMethods , ratios, ...
        @(m,c) UpdateProgressSlider(handles.ProgressSlider, m, c));
    
    set(handles.ProgressSlider, 'Visible', 'off');

    symbolicResults=arrayfun(@(x) DGA_Diagnosis(x),results,'UniformOutput',false);

    symbolicActual = arrayfun(@(x) DGA_Diagnosis(x),actual,'UniformOutput',false);

    FullColumns = find(~isnan(ratios(1,:)));

    selectedMethods = methods(get(handles.MethodList, 'Value'),2);
    SetDiagnosisTableHeader(handles,[Input(FullColumns); 'ACT'; selectedMethods]);
    SetDiagnosisTableData(handles, ...
        [num2cell(ratios(:,FullColumns)) symbolicActual symbolicResults]);

    DGA_histogram = AnalyzeResults(results, actual);

    PlotAccuracyGraph(handles);

    set(handles.selectedMethod, 'String', selectedMethods);
    set(handles.selectedMethod, 'Value', 1);
    ShowSelectedView(handles);
    ShowSelectedMethodAnalysisResults(handles);
end
    
function PlotAccuracyGraph(handles)
    axes(handles.AccuracyGraph);
    PlotAccuracyGraph1(handles);
end

function PlotAccuracyGraph1(handles)
    global DGA_histogram;    
    methods = Read_Config();
    
    selectedMethodCount = length(get(handles.MethodList, 'Value'));
    all = reshape(DGA_histogram(:,10),7,selectedMethodCount);

    bar(all);
    xlabel('Fault Type');
    ylabel('Accuracy %');

    grid on;

    set(gca,'XTickLabel', ...
        {'PD','D1','D2','T1','T2','T3','Overall'});

    ylim([0 100]);    

    legend( methods(get(handles.MethodList, 'Value'),2), ...
        'Location','northoutside','Orientation','horizontal');
end

% --- helper function to show/hid an object based on the value of another    
function ShowView(hOption, hView)    
    V ={'off'; 'on'};
    set(hView, 'Visible', cell2mat(V(get(hOption, 'Value')+1))); 
end

% --- show the view corresponding to the selected result/analysis option 
function uipanel9_SelectionChangeFcn(hObject, eventdata, handles)
    ShowSelectedView(handles)
end

function ShowSelectedView(handles)
    ShowView(handles.RawDataView, handles.DiagnosisTable);
    ShowView(handles.AccuracyTabularView, handles.AccuracyTable);
    ShowView(handles.AccuracyGraphicalView, handles.AccuracyGraph);
end

% --- Display analysis results for the selected method
function selectedMethod_Callback(hObject, eventdata, handles)
    ShowSelectedMethodAnalysisResults(handles);
end

function H=MethodHistogram(index)
    %Histogram for all attempted methods
    global DGA_histogram;
    
    %The portion of the histogram corresponding to the selected method
    MethodPart= 7*(index-1)+1:7*index;
    
    H = DGA_histogram(MethodPart,:);
end

function ShowSelectedMethodAnalysisResults(handles)
    %The index of the method selected for display
    SelectedMethod = get(handles.selectedMethod, 'Value');
        
    %Display the accuracy table corresponding to the selected method
    set(handles.AccuracyTable, 'Data', MethodHistogram(SelectedMethod));
end

% --- Executes during object creation, after setting all properties.
function selectedMethod_CreateFcn(hObject, eventdata, handles)
    SetDefaultBackgroundColor(hObject);
end

function pbEditMethods_Callback(hObject, eventdata, handles)
    h=Edit_Methods;
    uiwait(h);
    LoadMethodList(handles);
end

function lbDatasets_CreateFcn(hObject, eventdata, handles)
    SetDefaultBackgroundColor(hObject);
end

% --- Display Dataset configuration window
function pbEditDatasets_Callback(hObject, eventdata, handles)
    h=Edit_Datasets;
    uiwait(h);
    LoadDatasetList(handles);
end

function pbSelectAllDatasets_Callback(hObject, eventdata, handles)  
    datasets = get(handles.lbDatasets, 'String');
    set(handles.lbDatasets, 'Value', 1:length(datasets));
end

% --- On Windows, replace default background color with white
function SetDefaultBackgroundColor(hObject)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end    


% --- Executes on button press in pbExportView.
function pbExportView_Callback(hObject, eventdata, handles)

    warning('off', 'MATLAB:xlswrite:AddSheet');

    if get(handles.RawDataView, 'Value')
        ExportDiagnosisTable(handles);
    end
    
    if get(handles.AccuracyTabularView, 'Value')
        ExportAccuracyTable(handles);
    end
    
    if get(handles.AccuracyGraphicalView, 'Value')
        ExportGraph(handles);
    end
    
    warning('on', 'MATLAB:xlswrite:AddSheet');
    
end


function ExportDiagnosisTable(handles)
    colHeaders = GetDiagnosisTableHeader(handles); 

    data=GetDiagnosisTableData(handles);

    if ~iscell(data)
        data = num2cell(data);
    end


    Table = [colHeaders'
             data];

    filename = 'DiagnosisTable.xlsx';
    
    [filename,pathname]=uiputfile({'*.xlsx;*.xls', 'All supported files';'*.xlsx', 'Excel Workbook 2007';'*.xls', 'Excel Workbook 2003'},'Select Export File',filename);
    if ~isequal(filename,0) && ~isequal(pathname,0)
        rel_path = relativepath(pathname);
        filename = strcat(rel_path, filename);
        if exist(filename) 
            delete(filename)
        end

        xlswrite(filename, Table, 'Data');

        msgbox(['Data saved to ' filename]);
    end
end

function ExportAccuracyTable(handles)
    global DGA_histogram
    columnHeaders = [' '; get(handles.AccuracyTable, 'ColumnName')]';
    rowHeaders = get(handles.AccuracyTable, 'RowName'); 

    selectedMethods = get(handles.selectedMethod, 'String');
    
    filename = 'AccuracyTable.xlsx';

    [filename,pathname]=uiputfile({'*.xlsx;*.xls', 'All supported files';'*.xlsx', 'Excel Workbook 2007';'*.xls', 'Excel Workbook 2003'},'Select Export File',filename);
    if ~isequal(filename,0) && ~isequal(pathname,0)
        rel_path = relativepath(pathname);
        filename = strcat(rel_path, filename);

        if exist(filename) 
            delete(filename)
        end

        for iMethod = 1: length(selectedMethods)

            data=MethodHistogram(iMethod);

            if ~iscell(data)
                data = num2cell(data);
            end


            Table = [rowHeaders, data];
            if size(columnHeaders, 2) >= size(Table, 2)
                Header = columnHeaders(1,1:size(Table,2));
                Table = [Header;Table];
            end

            sheet = char(selectedMethods(iMethod));
            xlswrite(filename, Table, sheet);
        end

        msgbox(['Data saved to ' filename]);    
    end
end

function ExportGraph(handles)
    filename = 'AccuracyGraph.png';
    
    [filename,pathname]=uiputfile({'*.png', 'PNG formatted image'},'Select Export File',filename);
    if ~isequal(filename,0) && ~isequal(pathname,0)
        rel_path = relativepath(pathname);
        filename = strcat(rel_path, filename);

        h = figure;
        PlotAccuracyGraph1(handles);
        xlabel('Fault Type', 'fontsize', 20);
        ylabel('Accuracy %', 'fontsize', 20);
        set(h, 'paperpositionmode','manual');
        set(h, 'paperorientation','landscape');
        set(h, 'paperunits','normalized');
        set(h, 'paperposition',[0 0 1 1]);    
        set(gca,'fontsize',20);

        if exist(filename) 
            delete(filename)
        end

        print(h, filename ,'-dpng');
        close(h);

        msgbox(['Graph saved to ' filename]);
    end
end


% --- Executes during object creation, after setting all properties.
function ProgressSlider_CreateFcn(hObject, eventdata, handles)
    SetDefaultBackgroundColor(hObject);
end


% --- Executes when selected object is changed in InputModeGroup.
function InputModeGroup_SelectionChangeFcn(hObject, eventdata, handles)
    ShowView(handles.optSinglePoint, handles.SinglePointPanel)
    ShowView(handles.optDataset, handles.DatasetsPanel)
end
