function Video2Image(VideoPath,ImageSaveFolder,ImNamePre,ImSpanNum,ImageNum,ImageSize)
ImageSaveForm='.jpg';
ImStartId=100;
ObjImSize=ImageSize;
%获取视频信息
vidObj= VideoReader(VideoPath);
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
%创造一个存储视频的结构体
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
%先把视频每一帧信息记录下来
k = 1;
while hasFrame(vidObj)
% while k<ImageNum+1
    s(k).cdata = readFrame(vidObj);
    k = k+1;
    k
end
%把上面保存的信息写入图片中去
if ~exist(ImageSaveFolder,'dir')
    mkdir(ImageSaveFolder);
end
for i=ImStartId:ImSpanNum:ImStartId+ImageNum*ImSpanNum
    %取出结构体中一张图片信息
    Image=s(i).cdata;
    Image=imresize(Image,ObjImSize);
    %按指定格式保存到指定的文件夹
    ImageName=sprintf('%s-%d.%s',ImNamePre,i,ImageSaveForm);
    ImagePath=fullfile(ImageSaveFolder,ImageName);
    imwrite(Image,ImagePath);
end
end

