function [message,results,timeElapsed] = runcontest(drawboard)
%RUNCONTEST Test an entry.
%   [MESSAGE,RESULTS,TIME] = RUNCONTEST(DRAWBOARD) runs the M-file
%   solver.m against all the problems defined in testsuite_sample.mat.  The
%   input DRAWBOARD specifies if you want to graphically visualize the results.
%   MESSAGE returns a summary of the testing.  RESULTS measures how well the
%   entry solved the problem, and TIME measures the time the entry took to
%   compute its answer.

% Argument parsing.
if (nargin < 1)
    drawboard = 0;
end

% Define constants.
scentDecay = 1;
range = -2:2;
secret = 8;
load testsuite_actual testsuite

% Run the submission for each problem in the suite.
score = zeros(size(testsuite));
time0 = cputime;
for i = 1: numel(testsuite)
    
    main  = testsuite(i).main;
    food  = testsuite(i).food;
    scent = testsuite(i).scent;
    ants  = testsuite(i).ants;
    locs  = testsuite(i).locs;

    if drawboard, viewsolution(main,scent,food,locs,1); end

    nAnts = sum(ants(:));
    for timeCtr = 1:1000
        for antCtr = 1:nAnts

            y = locs(antCtr,1);
            x = locs(antCtr,2);
            yv = y + range;
            xv = x + range;
            mainMap  = main(yv,xv);
            foodMap  = food(yv,xv);
            antMap   = ants(yv,xv);
            scentMap = scent(yv,xv);

            % call ant micro-program
        rand('seed',timeCtr+antCtr+secret);
        randn('seed',timeCtr+antCtr+secret);
        rand('state',timeCtr+antCtr+secret);
        randn('state',timeCtr+antCtr+secret);
            clear global
            [dy,dx,mark,carry] = solver(mainMap,foodMap,antMap,scentMap);

            % figure out the new ant position
            ny = y;
            nx = x;
            if dy>0
                ny = ny+1;
            elseif dy<0
                ny = ny-1;
            end
            if dx>0
                nx = nx+1;
            elseif dx<0
                nx = nx-1;
            end
            
            % validate move
            if main(ny,nx)<0
                ny = y;
                nx = x;
            end

            % move food when carry is true
            if carry & food(y,x)
                food(y,x)   = food(y,x)  -1;
                food(ny,nx) = food(ny,nx)+1;
            end

            % leave scent
            mark = min(max(real(round(mark)),0),100);
            if mark
                scent(y,x) = scent(y,x)+mark;
            end

            % move ant
            locs(antCtr,:)=[ny nx];
            ants(y,x)   = ants(y,x)  -1;
            ants(ny,nx) = ants(ny,nx)+1;

        end % next ant

        % time passes, reduce scent
        scent = max(0,scent - scentDecay);

        if drawboard
            viewsolution(main,scent,food,locs,0)
            drawnow
        end

    end % next time step

    score(i) = grade(main,food);
    
end % next problem in testsuite

% report the time
timeElapsed = cputime-time0;
if drawboard
    % time is not accurate when drawing the board
    timeElapsed = NaN;
end

% Report results.
results = sum(score);
message = sprintf('results: %.2f\ntime: %.2f',results,timeElapsed);


%===============================================================================
function m = grade(main,food)
%GRADE Make sure the answer is valid and compute its score.

% Add up distance of all food units to the closest home.
f = food(find(food));
[yf,xf] = find(food);
[ym,xm] = find(main==1);
nm = numel(ym);
nf = numel(yf);
m = min(abs(repmat((xf+i*yf).',nm,1)-repmat((xm+i*ym),1,nf)),[],1) * f;


%===============================================================================
function viewsolution(map,scent,food,ants,reset)
% shows the ant map in a MATLAB figure
if (reset | ~strcmp(get(gca,'Tag'),'AntMap'))
    % create new map
    clf
    set(gcf,'DoubleBuffer','on')
    set(gca,'Position',[0 0.05 1 .95],'Visible','off')
    [m,n]=size(map);
    % draw image (rocks and world limits)
    h.image = image(min(256,(scent/10+1).*(map~=-1)+1));
    colormap([[0;0;0] 1-[1;1;0]*[0:254]/254]');
    hold on

    % draw home
    [y,x] = find(map==1);
    for i=1:numel(x)
        plot(x(i)+[1 1 -1 -1 1]/2,y(i)+[-1 1 1 -1 -1]/2,'m','LineWidth',2)
    end
    
    % draw food
    [y,x] = find(food);
    h.food = plot(x,y,'g.','MarkerSize',18);
    
    % draw ants
    h.ants = plot(ants(:,2),ants(:,1),'rx','LineWidth',2);

    % update axes properties
    axis equal
    axis([2.5 n-1.5 2.5 m-1.5])
    set(gca,'Tag','AntMap','Visible','on')
    axis off
    
    % set uicontrols
    h.text01 = uicontrol('Style','text','Position',[20 0 160 15],...
            'HorizontalAlignment','left','BackgroundColor',get(gcf,'Color'));
    
    setappdata(gca,'AntHandles',h)
    set(gcf,'MenuBar','none')
    figure(gcf)
    
else
    % AntMap exists, just update
    h = getappdata(gca,'AntHandles');
    set(h.image,'CData',min(256,(scent/10+1).*(map~=-1)+1))
    [y,x] = find(food);
    set(h.food,'XData',x,'YData',y)
    set(h.ants,'XData',ants(:,2),'YData',ants(:,1))
    set(h.text01,'String',sprintf('Food Metric: %.2f',grade(map,food)))
    
end


