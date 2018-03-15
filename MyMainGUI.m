function varargout = MyMainGUI(varargin)
% MYMAINGUI MATLAB code for MyMainGUI.fig
%      MYMAINGUI, by itself, creates a new MYMAINGUI or raises the existing
%      singleton*.
%
%      H = MYMAINGUI returns the handle to a new MYMAINGUI or the handle to
%      the existing singleton*.
%
%      MYMAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYMAINGUI.M with the given input arguments.
%
%      MYMAINGUI('Property','Value',...) creates a new MYMAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyMainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyMainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyMainGUI

% Last Modified by GUIDE v2.5 05-Apr-2013 18:48:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyMainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MyMainGUI_OutputFcn, ...
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

% --- Executes just before MyMainGUI is made visible.
function MyMainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyMainGUI (see VARARGIN)

% Choose default command line output for MyMainGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using MyMainGUI.
%if strcmp(get(hObject,'Visible'),'off')
%    plot(rand(5));
%end

% UIWAIT makes MyMainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyMainGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbuttonSegmentHistogram.
function pushbuttonSegmentHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSegmentHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch1
global segments
global loadedFileIndex
global minLength
global maxLength
global minDepth
global selectedSegmentIndex


loadedSegments = segments{loadedFileIndex}
display(loadedSegments)
display selectedSegmentIndex
selectedSegment = loadedSegments{selectedSegmentIndex}
%for m=1:length(loadedSegments)

startPoints(1) = selectedSegment(1)
endPoints(1) = selectedSegment(2)

axes(handles.axes3);
cla;
[translocstart, translocstop, translocdepth, translocations, guide, bighisttemp,histvecttemp ]=Translocation_Finder_ch1(ch1, minLength, maxLength, minDepth,startPoints,endPoints)



%old bart code

 d=size(translocstart);
        numtranslocs=d(1);
        ch3=ch1;
        ch2= ch1;
        mode=1;
        vChanges=0;
        histogram=zeros(1001,1);
        histvec=[]
        histvec=[histvec,histvecttemp];
        A=DataDisplay(ch1, ch2, translocstart, translocstop, histogram, ch3, vChanges, numtranslocs, mode, histvecttemp, bighisttemp)
        




popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




























% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on selection change in listboxFileNames.
function listboxFileNames_Callback(hObject, eventdata, handles)
% hObject    handle to listboxFileNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxFileNames contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxFileNames
 contents = cellstr(get(hObject,'String')) 
 contents{get(hObject,'Value')}
 global data
 if (get(hObject,'Value')<=length(data.files))
        data.selectedFileIndex = get(hObject,'Value')
        display(data.selectedFileIndex);
 end
% --- Executes during object creation, after setting all properties.
function listboxFileNames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxFileNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxSegmentList.
function listboxSegmentList_Callback(hObject, eventdata, handles)
% hObject    handle to listboxSegmentList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxSegmentList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxSegmentList

 global data
 global ch1
 if (data.loadedFileIndex)
     
     if (get(hObject,'Value')<=length(data.files(data.loadedFileIndex).segments))
            selSegIndex = get(hObject,'Value');
            data.files(data.loadedFileIndex).selectedSegmentIndex=  selSegIndex;
            display(data.files(data.loadedFileIndex).selectedSegmentIndex);
            currSeg = data.files(data.loadedFileIndex).segments(selSegIndex);
           
            axes(handles.axes2);
            cla;
            b=ch1(currSeg.xStart:currSeg.xEnd);
            plot(b)
            
            if (data.files(data.loadedFileIndex).analysed==1)
                %If already analysed refresh also the segment Histogram
               refreshSelectedSegmentHistogram(handles.axes4)
               refreshSelectedSegmentEventList(handles)
               refreshSegmentAllEvents(handles)
              
               refreshSegmentEventHistogram(handles.axes8)
               
               
            end
     end

 end




% --- Executes during object creation, after setting all properties.
function listboxSegmentList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxSegmentList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonOpenFiles.
function pushbuttonOpenFiles_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOpenFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
%global pathName
%global fileNames
%global segments
%display(fileNames)

%pathName
[fileName, pathName] = uigetfile('C:\Data\TL Data\matt\R35\030113\030113\*.*', 'File Selector','MultiSelect', 'on')
    if iscell(fileName)
        nbfiles = length(fileName);
    elseif (~fileName==0)
        nbfiles = 1;
    else
        nbfiles = 0;

    end
    if(nbfiles==1) %one file selected case
        pathName
        fileNames{0} = fileName;
      set (handles.textFolder,'String',pathName)
      get (handles.listboxFileNames,'String')
      set (handles.listboxFileNames,'String',fileNames{0})
         
    end
    if(nbfiles>1)
        pathName
        set (handles.textFolder,'String',pathName)
                  
        for i=1:nbfiles %New Stuff
            data.files(end+1).fileName = fileName{1,i}
            data.files(end).filePath =pathName
            data.files(end).segments =[]
            data.files(end).analysed=0;
            data.files(end).fileHistogram=[];
            data.files(end).allSegmentsHistogram = [];
            data.files(end).allSegmentsEventHistogram = [];
            data.selectedSegmentIndex=0;
          
            
        end
        data.selectedFileIndex=1;
        data.loadedFileIndex=0;
      disp(data.files)
      refreshListboxFileNames(handles);
     
    end
    
function refreshListboxFileNames(handles)
global data
fileNames = []
for i=1:length(data.files)
    fileNames{i} = data.files(i).fileName
end
set (handles.listboxFileNames,'String',fileNames)
set (handles.listboxFileNames,'Value',data.selectedFileIndex)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonLoadFile.
function pushbuttonLoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data
 %contents = cellstr(get(handles.listboxFileNames,'String')) 
 %selectedfile = contents{get(handles.listboxFileNames,'Value')}
 

 if  (~(data.selectedFileIndex==0))
        
        global ch1
        sFullFileName = strcat(data.files(data.selectedFileIndex).filePath,data.files(data.selectedFileIndex).fileName)
        disp('Reading ionic current file.')
        binary=fopen(sFullFileName);
        ch1=fread(binary, 'double', 'ieee-be');
        fclose(binary);
        clear binary;
        %cd(oldfolder);
        axes(handles.axes1);
        cla;
        hold off;
        plot(handles.axes1, ch1)
        axes(handles.axes2);
        cla;
        data.loadedFileIndex= data.selectedFileIndex;
        
 else
     set (handles.textFileName,'String','Please select file')
 end
 
 function refreshLoadedFile(handles)
     if  (~(data.loadedFileIndex==0))
        
        global ch1
        %cd(oldfolder);
        axes(handles.axes1);
        cla;
        hold off;
        plot(handles.axes1, ch1)
        refreshAllSegments(handles)
        
 else
     set (handles.textFileName,'String','Please select file')
 end
     

 function refreshAllSegments(handles)
     global data
     global ch1
     
     axes(handles.axes1)
     cla reset
     
     plot(ch1);
     hold all
     for m = 1:length(data.files(data.loadedFileIndex).segments)
        currSeg = data.files(data.loadedFileIndex).segments(m);
        b=[];
        b(currSeg.xStart:currSeg.xEnd)=ch1(currSeg.xStart:currSeg.xEnd);
        plot(b)
     end
    hold off
     
      
        

     
% --- Executes on button press in pushbuttonSelectSegments.
function pushbuttonSelectSegments_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSelectSegments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
global ch1

if (data.loadedFileIndex)
    
    [x,y]=ginput(2);
    disp(x)
    disp(y)

    axes(handles.axes2);
    plot(ch1(x(1):x(2)))

    axes(handles.axes1);
    b(x(1):x(2))=ch1(x(1):x(2));
    hold all;
    plot(b)

    
    data.files(data.loadedFileIndex).segments(end+1).xStart = round(x(1))
    data.files(data.loadedFileIndex).segments(end).xEnd = round(x(2))
    data.files(data.loadedFileIndex).segments(end).segmentHistogram = []
    data.files(data.loadedFileIndex).segments(end).segmentEventHistogram = []
    data.files(data.loadedFileIndex).segments(end).events = []
    data.files(data.loadedFileIndex).segments(end).eventsData = []
    data.files(data.loadedFileIndex).segments(end).segmentEventHistogram = []
    data.files(data.loadedFileIndex).selectedSegmentIndex=length(data.files(data.loadedFileIndex).segments);
    
    data.files(data.loadedFileIndex).analysed = 0;
    
    refreshSegmentsList(handles)
end
%create proper screen names




function refreshSegmentsList(handles)
global data

for m = 1:length(data.files(data.loadedFileIndex).segments)
    currSeg = data.files(data.loadedFileIndex).segments(m);
    segmentListDisplay{m}=strcat(num2str(currSeg.xStart),'|',num2str(currSeg.xEnd))
end
%set (handles.listboxSegmentList,'String',segments{loadedFileIndex})
set (handles.listboxSegmentList,'String',segmentListDisplay)
set (handles.listboxSegmentList,'Value',data.files(data.loadedFileIndex).selectedSegmentIndex);


% --- Executes on button press in pushbuttonDeleteFile.
function pushbuttonDeleteFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDeleteFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data

if (data.selectedFileIndex>0)

    if (data.selectedFileIndex == data.loadedFileIndex)
        %eventualy clear graph 
        %later clear graph xxx
        data.loadedFileIndex=0;
    end
    data.files(data.selectedFileIndex)=[];
    data.selectedFileIndex =  data.selectedFileIndex-1;
    if (data.selectedFileIndex ==0 )
        data.selectedFileIndex =1;
    end
    %test if empty
    refreshSegmentsList(handles);
    
end

% --- Executes on button press in pushbuttonDeleteSegment.
function pushbuttonDeleteSegment_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDeleteSegment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data;
global ch1;

if (data.loadedFileIndex)
    loadedFile = data.files(data.loadedFileIndex);
    if (loadedFile.selectedSegmentIndex)
        loadedFile.segments(loadedFile.selectedSegmentIndex)=[];
        loadedFile.analysed=0;
        if (length(loadedFile.segments)>0)
            loadedFile.selectedSegmentIndex = 1;
        else
            loadedFile.selectedSegmentIndex= 0; 
    
        end
    end  
    data.files(data.loadedFileIndex)=loadedFile;
end
refreshAllSegments(handles);        
refreshSegmentsList(handles);



function editMinLength_Callback(hObject, eventdata, handles)
% hObject    handle to editMinLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinLength as text
%        str2double(get(hObject,'String')) returns contents of editMinLength as a double
global minLength;
minLength= str2num(get(hObject,'String'));




% --- Executes during object creation, after setting all properties.
function editMinLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global maxLength
maxLength= str2num(get(hObject,'String'))

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMinDepth_Callback(hObject, eventdata, handles)
% hObject    handle to editMinDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinDepth as text
%        str2double(get(hObject,'String')) returns contents of editMinDepth as a double

global minDepth;
minDepth= str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function editMinDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonSegmentsInFileHistogram.
function pushbuttonSegmentsInFileHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSegmentsInFileHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AnalyseLoadedFile()
refreshSelectedSegmentHistogram(handles.axes4)
displayLoadedFileHistogram(handles.axes3)
refreshAllSegmentsHistogram(handles.axes5)
refreshSelectedSegmentEventList(handles);
refreshSegmentEventHistogram(handles.axes8)
refreshSegmentAllEvents(handles);
refreshAllSegmentsInFileEventHistogram(handles.axes9);

function  refreshAllSegmentsInFileEventHistogram(axeshandles)
global data

axes(axeshandles)
cla
currFile = getLoadedFile();
increment5=[0:0.005:6];
bar(increment5, log(currFile.allSegmentsEventHistogram));


function AnalyseLoadedFile()
    global data;
    global ch1;
    global debugData
    global loadedFile;
    histmax=6; %values that reflect the bounds and increments of the histograms used in data collection and presentation
    histmin=0; %If you change these, make sure that (max-min)/del is an integer!
    del=.005;
    edges=[histmin:del:histmax];
    
    
    if (data.loadedFileIndex)
    %we have a file
        loadedFile=data.files(data.loadedFileIndex);
        if (loadedFile.analysed==0)
            %make the startpoints
            startPoints = []
            endPoints =[]
            for m=1:length(loadedFile.segments)
                startPoints(m)= loadedFile.segments(m).xStart; 
                endPoints(m)= loadedFile.segments(m).xEnd;
            end
            %then do the analyse
            [translocstart, translocstop, translocdepth, translocations, guide, bighisttemp,histvecttemp, eventsPerSection ]=Third_Attempt_Translocation_Finder_ch1(ch1, data.minLength, data.maxLength, data.minDepth,startPoints.',endPoints.')
           % [translocstart, translocstop, translocdepth, translocations, guide, bighist, histvect,translocstartsections]=Third_Attempt_Translocation_Finder_ch1(ch1, minLength, maxLength, minDepth,startpoint,endpoint)
            %save to the data struct the hystograms
            loadedFile.analysed=1;
            loadedFile.fileHistogram= bighisttemp;
            evListStart =1;
            debugData.translocstart = translocstart;
            debugData.translocstop = translocstop;
           debugData.eventsPerSection = eventsPerSection;
            for m=1:length(loadedFile.segments)
                loadedFile.segments(m).segmentHistogram =  histvecttemp(:,m) 
                evListEnd=evListStart+eventsPerSection(m)-1;
                display(evListEnd);
                loadedFile.segments(m).events(:,1) =translocstart(evListStart:evListEnd)
                loadedFile.segments(m).events(:,2)= translocstop(evListStart:evListEnd)
                evListStart=evListEnd+1;
            end
            %generate the all segments histogram combined
            loadedFile.allSegmentsHistogram = (sum(histvecttemp.')).'
            
            %save all events data and histograms
            
            for m=1:length(loadedFile.segments)
                for n=1:size(loadedFile.segments(m).events)
                    loadedFile.segments(m).eventsData{n}= ch1(loadedFile.segments(m).events(n,1)-50:loadedFile.segments(m).events(n,2)+50)
                    if (n==1)
                        loadedFile.segments(m).segmentEventHistogram =  histc(loadedFile.segments(m).eventsData{n},edges);
                    else
                        loadedFile.segments(m).segmentEventHistogram = loadedFile.segments(m).segmentEventHistogram  +  histc(loadedFile.segments(m).eventsData{n},edges);
                    end
                end
            end
            
            %save allSegmentsEventHistogram
          %  loadedFile.allSegmentsEventHistogram = sum(loadedFile.segments(:).segmentEventHistogram)
            for m=1:length(loadedFile.segments)
            
                    if (m==1)
                        loadedFile.allSegmentsEventHistogram =  loadedFile.segments(m).segmentEventHistogram;
                    else
                        loadedFile.allSegmentsEventHistogram =   loadedFile.allSegmentsEventHistogram + loadedFile.segments(m).segmentEventHistogram;
                    end
            
            end
            %save the file  back
            data.files(data.loadedFileIndex) = loadedFile;
        end    
    end        

    
function refreshSelectedSegmentHistogram(axesHandle)
global data
%xxx- verify if there is a loaded file and selected index
loadedFile =data.files(data.loadedFileIndex);
display(data.loadedFileIndex)
display(loadedFile.selectedSegmentIndex)

refreshSegmentHistogram(axesHandle, data.loadedFileIndex,loadedFile.selectedSegmentIndex);

function refreshAllSegmentsHistogram(axesHandle)
global data
%xxx- verify if there is a loaded file and selected index
loadedFile =data.files(data.loadedFileIndex);
axes(axesHandle);
cla;
increment5=[0:0.005:6];
bar(increment5, log(loadedFile.allSegmentsHistogram));
function refreshSegmentEventHistogram(axesHandle)
global data
%xxx- verify if there is a loaded file and selected index
seg = getSelectedSegment();
axes(axesHandle);
cla;
increment5=[0:0.005:6];
bar(increment5, log(seg.segmentEventHistogram));

               
function refreshSegmentHistogram( axesHandle,fileIndex, segmentIndex )
global data

selectedSegHist = data.files(fileIndex).segments(segmentIndex).segmentHistogram;
axes(axesHandle);
cla;
increment5=[0:0.005:6];
bar(increment5, log(selectedSegHist));

function refreshSelectedSegmentEventList( handles )

global data
%if ~exist(fileIndex) 
%    selFile= data.files(data.loadedFileIndex);
%    selSeg= selFile.segments(selFile.selectedSegmentIndex);
%    selectedSegEvents = selSeg.events;
%else
%    if exist(segmentIndex)
%        selectedSegEvents = data.files(fileIndex).segments(segmentIndex).events;
%    end   
%end
    selFile= data.files(data.loadedFileIndex);
    selSeg= selFile.segments(selFile.selectedSegmentIndex);
    selectedSegEvents = selSeg.events;

eventsList = []
for i=1:length(selectedSegEvents)
    eventsList{i}=num2str(selectedSegEvents(i,1))
end
set(handles.textEventsNo,'String',length(selectedSegEvents));
set(handles.popupmenuEventList,'String',eventsList)
set (handles.popupmenuEventList,'Value',1);


function displayLoadedFileHistogram(axesHandle)            
global data
axes(axesHandle)    
cla;
increment5=[0:0.005:6];
bar(increment5, log(data.files(data.loadedFileIndex).fileHistogram));

        
  
% --- Executes on button press in pushbuttonNextEvent.
function pushbuttonNextEvent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNextEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonPreviousEvent.
function pushbuttonPreviousEvent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPreviousEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenuEventList.
function popupmenuEventList_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuEventList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuEventList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuEventList

refreshEvent(handles.axes6,  get(hObject,'Value'))

function refreshEvent(haxes, eventIndex)
global ch1
axes(haxes)
cla
seg = getSelectedSegment();
a=ch1(seg.events(eventIndex,1)-50:seg.events(eventIndex,2)+50)
plot (a);

function refreshSegmentAllEvents(handles)
global ch1
seg = getSelectedSegment();
a=[]
b=[]

axes(handles.axes7)
cla
hold all
for i=1:size(seg.events)
    b=ch1(seg.events(i,1)-50:seg.events(i,2)+50);
    %a=[a;b]
    plot(b)

end
hold off

    



% --- Executes during object creation, after setting all properties.
function popupmenuEventList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuEventList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [file] = getLoadedFile()
global data
file = data.files(data.loadedFileIndex);

function [segment] = getSelectedSegment()
global data
[file] = getLoadedFile()
segment = file.segments(file.selectedSegmentIndex);


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

%display event
axes(handles.axes6)
cla






% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDeleteEvent.
function pushbuttonDeleteEvent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDeleteEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
