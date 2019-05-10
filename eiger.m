function varargout = eiger(varargin)
% EIGER MATLAB code for eiger.fig
%      EIGER, by itself, creates a new EIGER or raises the existing
%      singleton*.
%
%      H = EIGER returns the handle to a new EIGER or the handle to
%      the existing singleton*.
%
%      EIGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EIGER.M with the given input arguments.
%
%      EIGER('Property','Value',...) creates a new EIGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eiger_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eiger_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eiger

% Last Modified by GUIDE v2.5 13-Mar-2019 15:56:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eiger_OpeningFcn, ...
                   'gui_OutputFcn',  @eiger_OutputFcn, ...
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


% --- Executes just before eiger is made visible.
function eiger_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eiger (see VARARGIN)

% Choose default command line output for eiger
handles.output = hObject;
handles.imgfilename = [];
handles.imgdata = [];
handles.imgoutput = [];
handles.imgnumber = [];
handles.methodNo = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eiger wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eiger_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
% 按键1执行数字识别
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.imgfilename)
    handles.methodNo = get(handles.popupmenu2, 'value');
    [handles.imgoutput, handles.imgnumber] = patternIdentity(handles.imgdata, handles.methodNo);
    image(handles.axes2, handles.imgoutput);    %输出识别图像
    colormap(handles.axes2, gray(256));     %设置画布颜色模式
    set(handles.edit1, 'String', handles.imgnumber);    %输出识别数字
end
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
% 按键2选择手写数字图片
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[imgfilename, imgpathname] = uigetfile({'*.jpg;*.png'},'请选择一张手写数字图片');
if imgfilename
    imgdata = imread([imgpathname '\' imgfilename]);
    imgdata = imresize(imgdata,[28 28]);
    image(handles.axes1,imgdata);
    
    handles.imgfilename = imgfilename;    
    %handles.imgdata = formMyImages(imgdata);  
    handles.imgdata = rgb2gray(imgdata);
    %转成灰度图，将灰度图进行数字范围选定再resize到28*28
    
    
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
% 按键3保存识别后图片
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.output)
    % 保存识别后图像
    [FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';...
                                             '*.bmp','Bitmap(*.bmp)';...
                                             '*.gif','GIF(*.gif)';...
                                             '*.*',  'All Files (*.*)'},...
                                             '保存图片','Untitled');
    if FileName==0
          disp('保存失败');
          return;
    else
          h=getframe(handles.axes2);    %获取axes2的图片，返回的对象有cdata和colormap两个成员
          imwrite(h.cdata,[PathName,FileName]);
    end           
end
guidata(hObject,handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% 模式识别算法函数
%TODO: 参数调整选项待加入
function [resultImg, resultNumber] = patternIdentity(img, method)
images_trainset = loadMNISTImages('C:\Users\37419\Desktop\研一教材及参考书籍\模式识别\模式识别\MNIST_of_handwritten_digits\train-images.idx3-ubyte');
labels_trainset = loadMNISTLabels('C:\Users\37419\Desktop\\研一教材及参考书籍\模式识别\模式识别\MNIST_of_handwritten_digits\train-labels.idx1-ubyte');
[ sortedData_trainset,numImages_trainset,index ] = sortMyTrainset( images_trainset, labels_trainset );
switch(method)
    case 1
        %菜单首行选项，测试用
        %不作任何处理
        resultImg = img;
        resultNumber = '测试';       
    case 2
        %贝叶斯决策
        [max_hi, label_x] = eiger_Bayes_min_error(img, sortedData_trainset, numImages_trainset, index);
        resultImg = img;
        resultNumber = label_x;
    case 3
        %其他
end
