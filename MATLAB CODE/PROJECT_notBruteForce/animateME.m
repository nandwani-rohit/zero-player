clear all

[file_name file_path]=uigetfile({'*.jpeg;*.jpg;*.bmp;*.tif;*.tiff;*.png;*.gif','Image Files (JPEG, BMP, TIFF, PNG and GIF)'},'Select Images','multiselect','on');
file_name=sort(file_name);
[file_name2 file_path2]=uiputfile('*.gif','Save as animated GIF',file_path);

loops = 1;
delay = 0.0167;
delay1 = 3;

h = waitbar(0,['0% done'],'name','Progress') ;
for i=1:length(file_name)
    if strcmpi('gif',file_name{i}(end-2:end))
        [M  c_map]=imread([file_path,file_name{i}]);
    else
        a=imread([file_path,file_name{i}]);
        [M  c_map]= rgb2ind(a,256);
    end
    if i==1
        imwrite(M,c_map,[file_path2,file_name2],'gif','LoopCount',loops,'DelayTime',delay1)
    elseif (i==643)
        imwrite(M,c_map,[file_path2,file_name2],'gif','WriteMode','append','DelayTime',delay1)
%     elseif (i == length(file_name)-2)
%         imwrite(M,c_map,[file_path2,file_name2],'gif','WriteMode','append','DelayTime',delay1/2)
    else
        imwrite(M,c_map,[file_path2,file_name2],'gif','WriteMode','append','DelayTime',delay)
    end
    waitbar(i/length(file_name),h,[num2str(round(100*i/length(file_name))),'% done']) ;
end
close(h);
disp('Finished Succesffully!');