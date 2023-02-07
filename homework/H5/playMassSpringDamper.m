function playMassSpringDamper(t,h)
% MEGR 3122 - Dynamics II
% A. Wolek, UNC Charlotte, Feb. 16, 2020

recordFlag = 0;

boxh = 0.05;
boxw = 0.1;
perimx = [-boxw -boxw boxw boxw];
perimy = [-boxh boxh boxh -boxh];
hnom = 0.3;

xlimVec = [-1 1]*0.4;
ylimVec = [0 0.5];
damperOffset = 0.05;
Ux = -0.063;
springOffset = 0.05;
springThickness = 0.02;

figure;
subplot(2,1,1);
set(gcf,'Color','w');
fill(perimx*2, perimy,'g'); hold on;
plot([-boxw boxw]*1.5,[1 1]*hnom,'k--');
%skipFrames = length(t)/100;
skipFrames = 1;
iter = 1;
for i = 1:skipFrames:length(t)
    yrange = linspace(boxh,h(i)+hnom-boxh);
    springx= cos(linspace(0,2*pi*6))*springThickness+springOffset;
    
    if ( i == 1 )
        subplot(2,1,1);
        box_hdl = fill(perimx, perimy+hnom+h(i),'k');
        hold on;
        spring_hdl = plot(springx,yrange,'b','linewidth',2);
        damp_hdl = plot(ones(size(yrange))*-damperOffset,yrange,'r','linewidth',2);
        dampt_hdl = text(Ux,mean(yrange),'U','FontSize',15,'Color','r');
        subplot(2,1,2);
        line_hdl = plot(t(1),h(1),'b-','linewidth',2);
        hold on;
        set(gca,'FontSize',12)
        xlabel('Time (sec.)')
        ylabel('Displacement (m)');
    else
        subplot(2,1,1);
        set(box_hdl,'YData',perimy+hnom+h(i));
        set(spring_hdl,'YData',yrange);
        set(damp_hdl,'YData',yrange);
        set(dampt_hdl,'Position',[Ux mean(yrange) 0]);
        subplot(2,1,2);
        set(line_hdl,'XData',t(1:i),'YData',h(1:i));
        
    end
    
    subplot(2,1,1)
    xlim(xlimVec);
    ylim(ylimVec);
   % title(sprintf('Time = %3.1f sec',t(i)));

     set(gca,'FontSize',12)
     ylabel('Height (m)');
%    axis off;
    
    subplot(2,1,2);
    xlim([0 t(end)]);
    ylim([min(h) max(h)]);
    
    grid on;
    
    
    drawnow;
    if ( recordFlag ) 
        print(1,'-dpng',sprintf('./frames/frame_%04d.png',iter));
        iter = iter + 1;
    end
    pause(1/50); % 50 frames per second    
end
end
