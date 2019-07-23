function varargout = ui(varargin)
%UI MATLAB code file for ui.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('Property','Value',...) creates a new UI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      UI('CALLBACK') and UI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in UI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui

% Last Modified by GUIDE v2.5 26-Jun-2019 22:18:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% 添加代码
% 全局变量
if exist('template.mat','file')~=0
    load template pattern;
else
    for i = 1:10 
        pattern(1,i).num=0;
        pattern(1,i).feature=[];
    end
    save template pattern;
end

% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% No.1 获取鼠标位置（鼠标按下）
set(handles.axesImageHandWriting,'XLim',[0,1],'YLim',[0,1])
global draw_enable;
global x;
global y;
draw_enable=1;
if draw_enable
    position=get(gca,'currentpoint');
    x(1)=position(1);
    y(1)=position(3);
end

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% No.2更新鼠标位置并画线（鼠标在按下的情况下运动）
global draw_enable;
global x;
global y;
if draw_enable
    position=get(gca,'currentpoint');
    x(2)=position(1);
    y(2)=position(3);
    %line(x,y,'EraseMode','xor','LineWidth',5,'color','k');
    %line(x,y, 'marker', '.','markerSize',18, 'LineStyle','-','LineWidth',2,'Color','Black');
    line(x,y, 'LineStyle','-','LineWidth',16,'Color','Black');
    x(1)=x(2);
    y(1)=y(2);
end

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% No.3鼠标放开后停止画线
global draw_enable
draw_enable=0;
Img=getframe(handles.axesImageHandWriting);
imwrite(Img.cdata,'yourHandWriting.bmp','bmp');
I=imread('yourHandWriting.bmp'); 
I=rgb2gray(I);
[width, height] = size(I);
%将手写板保存下来的图片中显示坐标轴的部分截除掉
I=I(1:width-5,5:height,:);
I=imbinarize(I);
imwrite(I,'yourHandWriting.bmp','bmp');


% --- Executes on button press in buttonIdentity.
function buttonIdentity_Callback(hObject, eventdata, handles)
% hObject    handle to buttonIdentity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('yourHandWriting.bmp');
data=GetFeature(I);
data=data';
algo = get(handles.popupmenuSelectAlgorithm, 'value');
switch algo
    case 1
        result = -1;
        msgbox('请选择分类算法！','提示');
    case 2
        result=BayesTwoValue(data);
    case 3
        result=BayesLeastError(data);
    case 4
        result=Fisherclass(data);
    case 5
        result = -1;
        msgbox('更多分类算法正在添加中！','提示');
end 
Result=num2str(result);
set(handles.textResult,'String',Result);
global myresult;
myresult = result;  %global



% --- Executes on button press in buttonClear.
function buttonClear_Callback(hObject, eventdata, handles)
% hObject    handle to buttonClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% No.4清除图像（按下清除按键，这里要说明一下创建回调函数的时候要在清除按钮上右键，比较快）
axes(handles.axesImageHandWriting);
cla;
set(handles.textResult,'String','');
global myresult;
myresult = -1; % global


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% NO.5保存图像（按下保存按键）
%global data
I=imread('yourHandWriting.bmp');  %从这里开始可以一点一点来
data=GetFeature(I);
num=get(handles.popupmenuLabelNumber, 'value');
switch num
    case 1
        msgbox('请选择数字类别再保存','提示');
    otherwise
        numSamples = saveSample(num-2, data);
        if numSamples == -1
            msgbox('出错！请重新手写再保存！','提示');
        else
            msgbox('保存成功！','提示');
        end
end
% 清空结果，为分类做准备
set(handles.textResult,'String','');
%无论如何，更新表格数据
dataS = get(handles.sampleNumTable, 'data');
load template pattern;
for i=1:10 
    dataS{1,i} = num2str(pattern(1,i).num);
end
set(handles.sampleNumTable, 'data', dataS);

% --- Executes on button press in pushbuttonSaveCorrect.
function pushbuttonSaveCorrect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSaveCorrect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 也是保存样本
global myresult;
if myresult == -1
    msgbox('出错！请重新手写并识别，再保存！','提示');
else
    I=imread('yourHandWriting.bmp');  
    data=GetFeature(I);
    numSamples = saveSample(myresult, data);
    if numSamples == -1
        msgbox('出错！请重新手写并识别，再保存！','提示');
    else
        msgbox('保存成功！','提示');
    end
end
%无论如何，更新表格数据
dataS = get(handles.sampleNumTable, 'data');
load template pattern;
for i=1:10 
    dataS{1,i} = num2str(pattern(1,i).num);
end
set(handles.sampleNumTable, 'data', dataS);

% --- Executes on selection change in popupmenuSelectAlgorithm.
function popupmenuSelectAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuSelectAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuSelectAlgorithm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuSelectAlgorithm


% --- Executes during object creation, after setting all properties.
function popupmenuSelectAlgorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuSelectAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuLabelNumber.
function popupmenuLabelNumber_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuLabelNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuLabelNumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuLabelNumber


% --- Executes during object creation, after setting all properties.
function popupmenuLabelNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuLabelNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function sampleNumTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleNumTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% TODO:样本数量展示及更新（更新设在保存按钮回调）
% 设置表格属性
set(hObject, 'RowName', {'Nums'});
set(hObject, 'ColumnName', {'0','1','2','3','4','5','6','7','8','9'});
set(hObject, 'ColumnEditable', false);  %单元格不可编辑
set(hObject, 'Visible', 'on'); % off则不可见
dataS = cell(1,10); %取出1行10列的数据
load template pattern;
for i=1:10 
    dataS{1,i} = num2str(pattern(1,i).num);
end
set(hObject, 'data', dataS);
%调试disp(dataS);
