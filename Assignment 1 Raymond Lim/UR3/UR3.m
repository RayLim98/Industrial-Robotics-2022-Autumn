classdef UR3 < handle
    properties
        model;
        workspace = [-2 2 -2 2 0 2];   
        useGripper = false;
        x = 0;
        y = 0;
        z = 0;
    end
    
    methods%% Class for UR5 robot simulation
        function self = UR3(x, y, z)
            self.x = x;
            self.y = y;
            self.z = z;
            self.GetUR3Robot();
            self.PlotAndColourRobot();%
        end

%% GetUR3dRobot
        function GetUR3Robot(self)
        %     if nargin < 1
                % Create a unique name (ms timestamp after 1ms pause)
                pause(0.001);
                name = ['UR_3_',datestr(now,'yyyymmddTHHMMSSFFF')];
        %     end
            L(1) = Link('d',0.1519,  'a',0,       'alpha',pi/2,  'offset',pi,'qlim',[deg2rad(-360),deg2rad(360)]);
            L(2) = Link('d',0,       'a',-0.24365,'alpha',0,     'offset',0,'qlim',[deg2rad(-90),deg2rad(90)]);
            L(3) = Link('d',0,       'a',-0.21325,'alpha',0,     'offset',0,'qlim',[deg2rad(-170),deg2rad(170)]);
            L(4) = Link('d',0.11235, 'a',0,       'alpha',pi/2,  'offset',0,'qlim',[deg2rad(-360),deg2rad(360)]);
            L(5) = Link('d',0.08535, 'a',0,       'alpha',-pi/2, 'offset',0,'qlim',[deg2rad(-360),deg2rad(360)]);
            L(6) = Link('d',0.0819,  'a',0,       'alpha',0,     'offset',0,'qlim',[deg2rad(-360),deg2rad(360)]);
            self.model = SerialLink(L,'name',name);

            self.model.base = self.model.base * transl(self.x, self.y, self.z);
        end
%% PlotAndColourRobot
        function PlotAndColourRobot(self)%robot,workspace)
            tic
            display('Coloring Robot Sequence started')
            for linkIndex = 0:self.model.n
                display(['Getting Link Data ', num2str(linkIndex + 1)])
                if self.useGripper && linkIndex == self.model.n
                    [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['UR3Link',num2str(linkIndex),'Gripper.ply'],'tri'); %#ok<AGROW>
                else
                    [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['UR3Link',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
                end
                self.model.faces{linkIndex+1} = faceData;
                self.model.points{linkIndex+1} = vertexData;
                display(['Acquired face and vertex data for Link ', num2str(linkIndex + 1),'...',num2str(toc)]);
                display(['Facedata size: ', num2str(size(faceData))...
                    ,' ,Vertexx size: ', num2str(size(vertexData))])
            end
            self.model.plot3d(zeros(1,self.model.n),'noarrow','workspace',self.workspace);
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end  
            self.model.delay = 0;
            for linkIndex = 0:self.model.n
                handles = findobj('Tag', self.model.name);
                h = get(handles,'UserData');
                try 
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                                  , plyData{linkIndex+1}.vertex.green ...
                                                                  , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'interp';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end
            display(['Finished coloring ', num2str(toc), ' seconds']);
        end        
    end
end