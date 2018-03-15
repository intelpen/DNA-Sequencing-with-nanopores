%myMain
clear all 
global pathName
global fileNames
global ch1
global loadedFileIndex
global segments
global selectedSegmentIndex
global minDepth 
global minLength
global maxLength
global startPoints
global endPoints
global files
global loadedFile
% the structure 
global data
global debugData
data.files=[]
data.minLength = 2
data.maxLength = 1000
data.minDepth = 1
%data- struct containing
    %selectedFileIndex - integer with the selected file index in the
    %ListBox
    %loadedFileIndex - integer with the loaded file Index
    %files - array of struct fileStruct
            %fileStruct - struct containing
                %fileName - string
                %filePath - string
                %analysed
                %fileHistogram - column vector with the file histogram    
                %allSegmentsHistogram
                %selectedSegmentIndex
                %allSegmentsEventHistogram
                %segments - array of segmentStruct
                
            %segmentsStruct - struct containing         
                %xStart
                %xStop
                %segmentHistogram - column vector with the segment histogram    
                %segmentEventHistogram
                %events - array [nrEventsx2]
                %eventsData - array[nrEvents]
              
   

A = MyMainGUI()
