function varargout = TAgui(varargin)
% TAGUI MATLAB code for TAgui.fig
%      TAGUI, by itself, creates a new TAGUI or raises the existing
%      singleton*.
%
%      H = TAGUI returns the handle to a new TAGUI or the handle to
%      the existing singleton*.
%
%      TAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAGUI.M with the given input arguments.
%
%      TAGUI('Property','Value',...) creates a new TAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TAgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TAgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TAgui

% Last Modified by GUIDE v2.5 25-Jun-2013 17:17:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TAgui_OpeningFcn, ...
                   'gui_OutputFcn',  @TAgui_OutputFcn, ...
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


% --- Executes just before TAgui is made visible.
function TAgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TAgui (see VARARGIN)

handles.D2 = datestr(now,1);
handles.horizon = 10*360;
handles.Workday = datewrkdy(handles.D2,-handles.horizon, 0);
handles.D1 = datestr(handles.Workday);
handles.ticker = 'AAPL';
[HIGH,LOW,OPEN,CLOSE] = getdata(handles.ticker,handles.D1, handles.D2);
handles.current_data = CLOSE;
handles.k = 0.05;
plot(handles.current_data);
handles.type = 0; %handles tpe is 0 if equity and 1 if fx

% Choose default command line output for TAgui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TAgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TAgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Ticker_Callback(hObject, eventdata, handles)
% hObject    handle to Ticker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ticker = get(hObject, 'String');
fail = 0;
if handles.type
    try CLOSE = fx(handles.ticker);
    catch err
        fail = 1;
        errordlg('Currency doesn''exist','Error');

    end
    if fail ==0 
       CLOSE = fx(handles.ticker);
    end
    
    
    
else
    try fetch(yahoo,handles.ticker,handles.D1,handles.D2);
    catch err
        fail = 1;
        errordlg('Security doesn''exist or is not in yahoo finance','Error');
    end   
    if fail ==0 
       [HIGH,LOW,OPEN,CLOSE] = getdata(handles.ticker,handles.D1, handles.D2);
       
    end

    
end
    
if fail == 0
    handles.current_data = CLOSE;
    guidata(hObject, handles);
    
end




% Hints: get(hObject,'String') returns contents of Ticker as text
%        str2double(get(hObject,'String')) returns contents of Ticker as a double


% --- Executes during object creation, after setting all properties.
function Ticker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ticker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boot_elliot_Callback(hObject, eventdata, handles)
% hObject    handle to boot_elliot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boot_elliot as text
%        str2double(get(hObject,'String')) returns contents of boot_elliot as a double


% --- Executes during object creation, after setting all properties.
function boot_elliot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boot_elliot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elliot_waves_Callback(hObject, eventdata, handles)
% hObject    handle to elliot_waves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elliot_waves as text
%        str2double(get(hObject,'String')) returns contents of elliot_waves as a double


% --- Executes during object creation, after setting all properties.
function elliot_waves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elliot_waves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose_k.
function choose_k_Callback(hObject, eventdata, handles)
% hObject    handle to choose_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_k contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_k
val = get(hObject, 'Value');
volume = str2double(get(hObject, 'String'));
handles.k = volume(val);
guidata(hObject, handles); %Update the data handle structure - we added this






% --- Executes during object creation, after setting all properties.
function choose_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose_data.
function choose_data_Callback(hObject, eventdata, handles)
% hObject    handle to choose_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_data


% --- Executes during object creation, after setting all properties.
function choose_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in update.
function update_Callback(hObject, eventdata, handles)
% hObject    handle to update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.HP =  zigzaggui(handles.current_data,handles.k);
Ellis = Elliots(handles.HP);
Nsims = 1000;
simulatedelliots = bootsclosegui(handles.current_data, Nsims,handles.k);
avg = simulatedelliots / Nsims; % average the number of elliot waves observed in the bootstrapped series.
set(handles.boot_elliot, 'String', avg);
set(handles.elliot_waves, 'String', Ellis);
guidata(hObject, handles); %Update the data handle structure - we added this









% --- Executes on button press in reset_push.
function reset_push_Callback(hObject, eventdata, handles)
% hObject    handle to reset_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in time_series.
function time_series_Callback(hObject, eventdata, handles)
% hObject    handle to time_series (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns time_series contents as cell array
%        contents{get(hObject,'Value')} returns selected item from time_series
val = get(hObject, 'Value');
if isfield(handles, 'HP')
    switch val
        case 1
            plot(handles.current_data);
        case 2
            plot(handles.HP(:,1));
        
    end
else
   errordlg('Need to retrieve data before being able to plot the Zig Zag chart','Error');
 
end






% --- Executes during object creation, after setting all properties.
function time_series_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_series (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_type.
function radio_type_Callback(hObject, eventdata, handles)
% hObject    handle to radio_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_type




function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TypeData.
function TypeData_Callback(hObject, eventdata, handles)
% hObject    handle to TypeData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject, 'Value');
handles.type = val-1;
guidata(hObject, handles); %Update the data handle structure - we added this


% Hints: contents = cellstr(get(hObject,'String')) returns TypeData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TypeData


% --- Executes during object creation, after setting all properties.
function TypeData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TypeData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
