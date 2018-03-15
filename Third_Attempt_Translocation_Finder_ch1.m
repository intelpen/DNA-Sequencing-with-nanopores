function[translocstart, translocstop, translocdepth, translocations, guide, bighist, histvect,translocstartsections]=Third_Attempt_Translocation_Finder_ch1(ch1, minLength, maxLength, minDepth,startpoint,endpoint)

%Procedure for easing some of the restrictions on translocation finding:
% 1) Lower your minimum translocation depth. All of the extra restrictions
% are tied to it, if it drops even a little many things can change
% 2) If that doesn't work, you can change any of the values below to
% reflect their importance to you.
% 3) Look in the translocation finding section and change anything around
% that you don't need. Most of the actually conditions are stored in the
% final if statement, so you can look there and delete whatever doesn't
% interest you

delchecksize=10; %The size of the regions that the program uses to calculate the longest jump. A longer range will allow for less steep "edges" of your translocations. Default is 5.
delcheckscale=.3; %The fraction of the minimum depth that the afforemention jump must cover over the course of delchecksize. Default is .3
gapmod=.3; %The fraction of mindepth that the translocation's average value must be from the average value of the file in order to qualify as a translocation.
%The other relevant value are the .9 and the 1.1 in the big if statement.
%Those compare the maximum point of the translocation to the average value of
%the file, and force it to fall within a certain distance of the average.
%This simultaneously weeds out weird spikes in the data that would be
%outliers in the depth vs time chart and ensures that translocations that
%start too high or low get thrown out, ensuring consistancy in the data.

%DONT CHANGE THESE RIGHT NOW... it's still hardcoded in other sections,
%I'll fix that in a future build.

histmax=6; %values that reflect the bounds and increments of the histograms used in data collection and presentation
histmin=0; %If you change these, make sure that (max-min)/del is an integer!
del=.005;
edges=[histmin:del:histmax];

t=[1:size(ch1)];
%h=figure('Position',[0 0 fullscreen(3) fullscreen(4)]);

%scrsz = get(0,'ScreenSize');



translocstart=[];
translocstop=[];
translocstartsections=[];
translocdepth=[];
translocations=[];
guide=[];
histvect=[];
bighist=zeros(1,(histmax-histmin)/del);

disp('Setting Macroscopic Histogram');
bighist=histc(ch1,edges);

%Histogram translocaiton finding
for l=1:size(startpoint)
    translocstarttemp=[];
    translocstoptemp=[];
    disp('Setting histogram.')
    histogramtemp=histc(ch1(startpoint(l):endpoint(l)), edges);
    disp('Generating cut off values.')
    hmax=0;
    hmaxloc=0;
    for n=1:length(histogramtemp)
        if(histogramtemp(n)>hmax)
            hmax=histogramtemp(n);
            hmaxloc=n;
        end
    end
    transloccut=histmax/del;
    histderiv=diff(histogramtemp);
    for n=hmaxloc:-1:11
        b=endpoint(l)-startpoint(l);
        averagediff=sum(histderiv(n-10:n));
        if(averagediff<=0 & histogramtemp(n)<=b/1000)
            if(transloccut==histmax/del)
                transloccut=n;
            end
        end
    end
    avgval=mean(ch1(startpoint(l):endpoint(l)));
    realcut=del*transloccut
    histvect=[histvect,histogramtemp];
    disp('Finding translocations.')
    for n=startpoint(l)+1:endpoint(l)-1
        hit=0;
        if(ch1(n)<realcut) %Is it below the cut?
            if(1) %Is the voltage nonzero?
                changecheck=0;
                if(n-1>=1) %Was the previous point above the cut?
                    if(ch1(n-1)>=realcut)
                        changecheck=1;
                    end
                end
                if(size(translocstop)~=0)
                    fin=translocstop(end);
                end
                if(size(translocstop)==0 | n>fin)
                    baselengthcheck=1;
                    check=0;
                    transstop=0;
                    for k=1:minLength
                        if(ch1(n+k)>=realcut) %Is any point inside the minlength above the cut?
                            baselengthcheck=0;
                        end
                    end

                    if(baselengthcheck==1 & changecheck==1)
                        for j=minLength:maxLength %Where does it first go above the cut? How many times does it do so?
                            if(ch1(n+j)>=realcut)
                                check=check+1;
                                if(check==1)
                                    transstop=n+j;
                                end
                                if(check==4)
                                    break;
                                end
                            end
                        end
                        minintrans=intmax;
                        maxintrans=intmin; %What were the max and min values in the range?
                        if(check>=3)

                            r=n-40;
                            if(r<=0)
                                r=1;
                            end
                            ch1size=length(ch1);
                            t=transstop+40;
                            if(t>ch1size)
                                t=ch1size-1;
                            end
                            subsection=ch1(r:t);
                            maxintrans=max(subsection);
                            minintrans=min(subsection);
                        end
                        gap=0;
                        for c=n:transstop %What was the average gap size between the cut and the points in the range?
                            gap=gap+realcut-ch1(c);
                        end
                        avggap=gap/(transstop-n);
                        deltotal=abs(avgval-minintrans);
                       
                        if(check>=3 && deltotal>=minDepth) %was there a sharp jump somewhere that could act as the side of a translocation?
      

                            if(avggap>=gapmod*minDepth & maxintrans/avgval<=1.1 & maxintrans/avgval>=.9)%finish up some checks from before, make sure that the max value was close to the average value of the whole system
                                 if((size(translocstart)==0) | translocstop(end)<n)
                                    translocstarttemp=[translocstarttemp;n];
                                    translocstoptemp=[translocstoptemp; transstop];
                                    translocdepth=[translocdepth;maxintrans-minintrans];
                                    if(size(guide)~=0)
                                        guide=[guide;guide(end)+transstop-n+31];
                                    end
                                    if(size(guide)==0)
                                        guide=[transstop-n+31];
                                    end
                                    translocations=[translocations;ch1(n-15:transstop+15)];
                                end
                            end
                        end
                    end
                end
            end %end if voltage !=0
        end %end if less than real cut
    end %end for loop
    translocstart=[translocstart;translocstarttemp];
    translocstop=[translocstop;translocstoptemp];
    translocstartsections=[translocstartsections; length(translocstarttemp)];
end

disp(translocstart)
disp(translocstop)


