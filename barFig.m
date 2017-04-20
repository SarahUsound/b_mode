
function barFig(data, width, scanAngle, imageSpeed)
    warning('off','images:initSize:adjustingMag')
    rows = length(data);
    amin = min(data);
    amax = max(data);
    
    symmetryTheta = scanAngle / 2;
    startTheta = pi/2 - symmetryTheta;
    endTheta = pi/2 + symmetryTheta;
    
    template = zeros(rows, width);
    i = 1;
    while i < width
        template(:,i) = data;
        i = i + 1;
        if mod(i,imageSpeed) == 0 
                img = mat2gray(template, [amin amax]);
                [h,w,~] = size(img);
                s = min(h,w)/2;
                [rho,theta] = meshgrid(linspace(0,s-1,s), linspace(startTheta,endTheta));
                [x,y] = pol2cart(theta, rho);
                z = zeros(size(x));
                warp(x, y, z, img.'), view(2), axis square tight off
                drawnow
            
        end
    end

end
      
    