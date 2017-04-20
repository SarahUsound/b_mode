% Create radial gray-scale image from directory of h5 files
% Each h5 file should represent one "scan" / 1 dimension

% assumes mac OS (ctrl+F "DEPENDS on OS")
% assumes h5 files created by oscilloscope 
% assumes relevant data was on channel 2

function pieFig(dataDirec, processAlg, scanAngle, imageSpeed)
    warning('off','images:initSize:adjustingMag')
    
    d = dir(dataDirec);
    width = length(d) - 2; % DEPENDS on OS!
    % gray-scale should be normalized according 
    % to expected ADC output. For now, normalizing
    % based on min/max of first scan file
    
    if width > 3
    
    % read first data file for gray-scale parameters
    % and image size parameters (# samples)
    filename = d(3).name; % DEPENDS on OS!
    x = strcat(dataDirec, filename);
    h5_path = '/Waveforms/Channel 2/Channel 2 Data'; 
    data = h5read(x, h5_path);
    data = processAlg(data);
    amin = min(data);
    amax = max(data);
    rows = length(data);
    
    % determine scanAngle start and stop for image
    symmetryTheta = scanAngle / 2;
    startTheta = pi/2 - symmetryTheta;
    endTheta = pi/2 + symmetryTheta;
    
    
    template = zeros(rows, width);
    i = 3; % DEPENDS on OS! (first real file in direc)
    while i <= width + 2
        filename = dat(i).name;
        x = strcat(data_directory, filename);
        h5_path = '/Waveforms/Channel 2/Channel 2 Data'; 
        % This is how our scope 
        % structures h5 files automatically
        data = h5read(x, h5_path);
        data = processAlg(data);
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
    

    else 
        i = 3;
        while i <= width + 2
            filename = d(i).name;
            x = strcat(dataDirec, filename);
            h5_path = '/Waveforms/Channel 2/Channel 2 Data'; 
            data = h5read(x, h5_path);
            data = processAlg(data);
            barFig(data, 500, scanAngle, 25);
            
            i = i + 1;
        end
    end
        
end   
    