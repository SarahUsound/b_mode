# b_mode
Run b_mode.m to create 2D gray-scale visualizations of oscilloscope output. 
For example output images, see the /exampleImages/ folder. 

##### Assumptions #####

File Structure for Data
1. All data for visualization are in a single directory
2. Each file in the data directory should correspond to a single pulse
3. If each pulse was emitted at a different angle, files
    should be arranged consecutively in the directory. Ascending vs 
    descending arrangement will reverse final image. 
4. File type should be .h5 with data located at 
    h5_path = '/Waveforms/Channel 2/Channel 2 Data'; 
    This is the automatic structure of files saved from our oscilloscope.
    Be sure to use Channel 2 or change h5_path where data is read...
5. When iterating over a directory, all functions in this repo skip 
    the first 2 files, which are used by mac operating systems and 
    don't contain oscilloscope data

Visualization Parameters
1. gray-scale values are normalized according to the highest and lowest
    values in the first file of the directory
2. scan angle was incremented at a constant rate


#### Functions ####
Two of the functions in this repo are used to generate 
grayscale images. Those are pieFig and barFig, described below. 

Other functions in this repo can be used to process data
before imaging. These are sampleHold and cleanPeak. To read
about how these functions alter your data, see the notes in 
the function files. To see pictures of example outputs from 
these functions, see the /exampleImages/functionBehaviors folder.

Functions like sampleHold and cleanPeak should be added to 
the signal processing algorithm section of your b_mode.m 
script as described in the comments of the script. An example 
use could be to see how your final image would look if you 
had used a lower sampling rate on the analog signal, or 
to see an image without a large outlier disturbance.



##### pieFig #####

function pieFig(dataDirec, processAlg, scanAngle, imageSpeed)

example call: 
pieFig('VGAtest/', f, pi/2, 25);

output:
A .fig that updates 1 or more times while it is being built
from your data

Inputs: 
1. string dataDirec
    - string should contain path to individual data files

2. function processAlg
    - this signal processing function acts on the copy of data 
       passed to pieFIG
    - must return a column of doubles
    
3. float scanAngle
    - full range, in radians, of scan angles included in data directory
    
4. int imageSpeed
    - controls how frequently during the image-building process your 
       view is updated
    - for N scans, the final visualization will be changed N times, but 
       the image will only be updated a max of N/imageSpeed times
    - If your directory contains 100 files and your imageSpeed = 25, 
        your image will be updated 4 times (every 25 file reads)
    - If your imageSpeed integer is larger than the number of files, 
        you will only be shown the final image. 
        
        
 Notes:
 1. If your data directory contains 3 files or fewer, your image
      would be too close to 1-D for a clear visualization across
      scanAngle. In this scenario, scanAngle is used to create
      the shape of a "fake" 2-D image in which your 1-D data
      is used for (repeated to fill) every angle. One of these
      "fake" 2-D images will be rendered for each 1-D file 
      in the directory. 
      
 2. To create fake 2-D images, pieFig calls barFig. You can 
      call barFig separately to avoid creating a directory 
      for just one pulse file.
 
 
 ##### barFig #####
 
 function barFig(data, width, scanAngle, imageSpeed)
 
example call: barFig(data, 500, pi/3, 25);
 
output:
 A .fig that updates 1 or more times while it is being built
 from your data
 
 Inputs: 
1. data --> column of doubles

2. width
    - number of times to copy data for fake 2-D, to 
       simulate having more scans
    - affects resolution of final image, time to render
    
3. float scanAngle
    - full range, in radians, of scan angles to shape image
    
4. int imageSpeed
    - controls how frequently during the image-building process your 
       view is updated
    - for N scans, the final visualization will be changed N times, but 
       the image will only be updated a max of N/imageSpeed times
    - If your directory contains 100 files and your imageSpeed = 25, 
        your image will be updated 4 times (every 25 file reads)
    - If your imageSpeed integer is larger than the number of files, 
        you will only be shown the final image. 
        
    
