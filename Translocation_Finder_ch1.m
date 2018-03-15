function[translocstart, translocstop, translocdepth, translocations, guide, bighist, histvect]=Translocation_Finder_ch1(ch1, minLength, maxLength, minDepth,startpoint,endpoint)

%Procedure for easing some of the restrictions on translocation finding:
% 1) Lower your minimum translocation depth. All of the extra restrictions
% are tied to it, if it drops even a little many things can change
% 2) If that doesn't work, you can change any of the values below to
% reflect their importance to you.
% 3) Look in the translocation finding section and change anything around
% that you don't need. Most of the actually conditions are stored in the
% final if statement, so you can look there and delete whatever doesn't
% interest you

delchecksize=5; %The size of the regions that the program uses to calculate the longest jump. A longer range will allow for less steep "edges" of your translocations. Default is 5.
delcheckscale=.3; %The fraction of the minimum depth that the afforemention jump must cover over the course of delchecksize. Default is .3
gapmod=.4; %The fraction of mindepth that the translocation's average value must be from the average value of the file in order to qualify as a translocation.
%The other relevant value are the .9 and the 1.1 in the big if statement.
%Those compare the maximum point of the translocation to the average value of
%the file, and force it to fall within a certain distance of the average.
%This simultaneously weeds out weird spikes in the data that would be
%outliers in the depth vs time chart and ensures that translocations that
%start too high or low get thrown out, ensuring consistancy in the data.

%DONT CHANGE THESE RIGHT NOW... it's still hardcoded in other sections,
%I'll fix that in a future build.

max=6; %values that reflect the bounds and increments of the histograms used in data collection and presentation
min=0; %If you change these, make sure that (max-min)/del is an integer!
del=.005;

t=[1:size(ch1)];
%h=figure('Position',[0 0 fullscreen(3) fullscreen(4)]);

%scrsz = get(0,'ScreenSize');

ch3=ch1;

translocstart=[];
translocstop=[];
translocdepth=[];
translocations=[];
guide=[];
histvect=[];
bighist=zeros(1,(max-min)/del);

disp('Setting Macroscopic Histogram');


for bighistinc=1:size(ch1)
        check=ceil(round((ch1(bighistinc)-min)/del));
        if(check>max/del)
            check=max/del;
        end
        if(check<min/del+1)
            check=min/del+1;
        end
        bighist(check)=bighist(check)+1;
end  

disp(startpoint);
disp(endpoint);
%Histogram translocaiton finding
for l=1:size(startpoint)

    histogramtemp=zeros((max-min)/del,1);
    disp('Setting histogram.')
    disp('cicle: ');
    disp(l)
    for n=startpoint(l):endpoint(l)
        check=ceil(round((ch1(n)-min)/del));
        if(check>max/del)
            check=max/del;
        end
        if(check<min/del+1)
            check=min/del+1;
        end
        histogramtemp(check)=histogramtemp(check)+1;
    end

    disp('Generating cut off values.')
    hmax=0;
    hmaxloc=0;
    histsizestore=size(histogramtemp);
    for n=1:histsizestore(1)
        if(histogramtemp(n)>hmax)
            hmax=histogramtemp(n);
            hmaxloc=n;
        end
    end
    transloccut=max/del;
    histderiv=diff(histogramtemp);
    for n=hmaxloc:-1:11
        b=endpoint(l)-startpoint(l);
        averagediff=sum(histderiv(n-10:n));
        if(averagediff<=0 & histogramtemp(n)<=b/1000)
            if(transloccut==max/del)
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
            if(ch3(n)~=0) %Is the voltage nonzero?
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
                                    check=check+1;
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
                            ch1size=size(ch1);
                            t=transstop+40;
                            if(t>ch1size(1))
                                t=ch1size(1)-1;
                            end
                            for(k=r:t)
                                if(ch1(k)>maxintrans)
                                    maxintrans=ch1(k);
                                end
                                if(ch1(k)<minintrans)
                                    minintrans=ch1(k);
                                end
                            end
                        end
                        gap=0;
                        for c=n:transstop %What was the average gap size between the cut and the points in the range?
                            gap=gap+realcut-ch1(c);
                        end
                        avggap=gap/(transstop-n);
                        deltotal=abs(avgval-minintrans);
                        if(check>=3 && deltotal>=minDepth) %was there a sharp jump somewhere that could act as the side of a translocation?
                            checkregion=ch1(n:transstop);
                            delcheckregion=diff(checkregion);
                            maxdel=intmin;
                            mindel=intmax;
                            for e=1:size(delcheckregion)-delchecksize
                                sumdel5=sum(delcheckregion(e:e+delchecksize));
                                if(sumdel5>maxdel)
                                    maxdel=sumdel5;
                                end
                                if(sumdel5<mindel)
                                    mindel=sumdel5;
                                end
                            end

                            if( maxdel>delcheckscale*minDepth & mindel<-1*delcheckscale*minDepth & avggap>=gapmod*minDepth & maxintrans/avgval<=1.1 & maxintrans/avgval>=.9)%finish up some checks from before, make sure that the max value was close to the average value of the whole system
                                if((size(translocstart)==0) | translocstop(end)<n)
                                    translocstart=[translocstart;n];
                                    translocstop=[translocstop; transstop];
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
end



